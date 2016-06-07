from django.contrib import messages
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.core.urlresolvers import reverse
from django.http import HttpResponseRedirect, JsonResponse
from django.shortcuts import render, get_object_or_404
from django.views.decorators.http import require_POST

from .forms import LoginForm, RegisterForm, ProfileForm, SettingForm
from .models import User
from .tasks import confirm_user

from actions.models import Action
from actions.utils import create_action
from location.models import Province, City
from utils import make_paginator
from utils.decorators import ajax_required, tab


provinces = Province.objects.values_list('name', flat=True)

# 用户主页
@tab('home')
def home(request, user_id):
    user = get_object_or_404(User.objects.select_related('profile'), pk=user_id)
    profile = user.profile
    recent_actions = Action.objects.filter(user=user).all()[:10]
    return render(request, 'user/index.tpl', {
            'actions': recent_actions,
            'user': user,
            'profile': profile,
        })

# 登录
def user_login(request):
    if request.user.is_authenticated():
        return HttpResponseRedirect(reverse('user:home'))
    if request.method == 'POST':
        form = LoginForm(request.POST)
        if form.is_valid():
            user = form.get_authenticated_user()
            login(request, user)
            return HttpResponseRedirect(reverse('home:index'))
    else:
        form = LoginForm()
    return render(request, 'user/login.tpl', {
            'form': form,
        })

# 退出
@login_required
def user_logout(request):
    logout(request)
    return HttpResponseRedirect(reverse('home:index'))

# 注册
def user_register(request):
    if request.method == 'POST':
        form = RegisterForm(request.POST)
        if form.is_valid():
            user = form.get_authenticated_user()
            login(request, user)
            return HttpResponseRedirect(reverse('home:index'))
    else:
        form = RegisterForm()
    return render(request, 'user/register.tpl', {
            'form': form
        })

# 用户验证
@login_required
def user_confirm(request, token):
    from django.core import signing
    tk = signing.loads({'user_id': request.user.id}, max_age=24 * 3600)
    print(tk, token)
    if tk == token:
        return HttpResponseRedirect(reverse('home:index'))


# 用户博客
def user_posts(request, user_id):
    user = get_object_or_404(User.objects.select_related('profile'), pk=user_id)
    profile = user.profile
    posts = user.posts
    return render(request, 'user/posts.tpl', {
            'posts': posts,
            'user': user,
            'profile': profile,
        })

# 正在关注
@tab('following')
def user_following(request, user_id):
    user = get_object_or_404(User.objects.select_related('profile'), pk=user_id)
    profile = user.profile
    followings = make_paginator(request, user.following.all())
    return render(request, 'user/user_list.tpl', {
            'users': followings,
            'user': user,
            'profile': profile,
        })

# 被关注的
@tab('followers')
def user_followers(request, user_id):
    user = get_object_or_404(User.objects.select_related('profile'), pk=user_id)
    profile = user.profile
    followers = make_paginator(request, user.followers.all())
    return render(request, 'user/user_list.tpl', {
            'users': followers,
            'user': user,
            'profile': profile,
        })

# 分享
@tab('share')
def user_shared(request, user_id):
    user = get_object_or_404(User.objects.select_related('profile'), pk=user_id)
    profile = user.profile
    foods_shared = make_paginator(request, user.foods_shared.all())
    return render(request, 'user/share.tpl', {
            'foods': foods_shared,
            'user': user,
            'profile': profile,
        })

# 想吃的
@tab('wta')
def user_wants_to_eat(request, user_id):
    user = get_object_or_404(User.objects.select_related('profile'), pk=user_id)
    profile = user.profile
    foods = make_paginator(request, user.foods_wta.all())
    return render(request, 'user/food_list.tpl', {
            'foods': foods,
            'user': user,
            'profile': profile,
        })

# 吃过的
@tab('ate')
def user_ate(request, user_id):
    user = get_object_or_404(User.objects.select_related('profile'), pk=user_id)
    profile = user.profile
    foods = make_paginator(request, user.foods_ate.all())
    return render(request, 'user/food_list.tpl', {
            'foods': foods,
            'user': user,
            'profile': profile,
        })

# Topic收藏夹
@tab('collection')
def topics_collection(request, user_id):
    user = get_object_or_404(User.objects.select_related('profile'), pk=user_id)
    profile = user.profile
    collections = make_paginator(request, user.topics_collected.all())
    return render(request, 'user/topic_collection.tpl', {
            'collections': collections,
            'user': user,
            'profile': profile,
        })

# 个人设置
@login_required
@tab('settings')
def user_settings(request):
    profile = request.user.profile
    settings = request.user.settings
    if request.method == 'POST':
        form = SettingForm(instance=settings, data=request.POST,
                            files=request.FILES)
        if form.is_valid():
            form.save()
            messages.success(request, '设置更新成功')
        else:
            messages.error(request, '设置更新失败')
    else:
        form = SettingForm(instance=settings)
    return render(request, 'user/settings.tpl', {
            'settings': settings,
            'form': form,
            'profile': profile,
        })

# 个人档案
@login_required
@tab('profile')
def user_profile(request):
    profile = request.user.profile
    if request.method == 'POST':
        form = ProfileForm(instance=profile, data=request.POST,
                            files=request.FILES)
        if form.is_valid():
            print(form.cleaned_data)
            form.save()
            messages.success(request, '资料更新成功')
        else:
            messages.error(request, '资料更新失败')
    else:
        form = ProfileForm(instance=profile)
    return render(request, 'user/profile.tpl', {
            'profile': profile,
            'form': form,
            'provinces': provinces
        })

@login_required
@tab('moments')
def user_moments(request):
    profile = request.user.profile
    actions = Action.objects.all().exclude(user=request.user)
    following_ids = request.user.following.values_list('id', flat=True)
    if following_ids:
        actions = actions.filter(user_id__in=following_ids).select_related('user', 'user__profile').prefetch_related('target')
    actions = actions[:10]
    return render(request, 'user/moments.tpl', {
            'profile': profile,
            'actions': actions
        })

@ajax_required
@login_required
def get_cities(request):
    province = request.GET.get('province')
    cities = City.objects.filter(province__name=province).values_list('id', 'name')
    return JsonResponse(list(cities), safe=False)

# 关注/取消关注
@ajax_required
@require_POST
@login_required
def user_follow(request):
    user_id = request.POST.get('id')
    action = request.POST.get('action')
    if user_id and action:
        user = User.objects.get(pk=user_id)
        if action == 'follow':
            request.user.following.add(user)
            create_action(request.user, '关注了', user)
        elif action == 'unfollow':
            request.user.following.remove(user)
        else:
            return JsonResponse({'status': False})
        return JsonResponse({'status': True})
    return JsonResponse({'status': False}, status=400)
