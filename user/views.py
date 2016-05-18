from django.contrib import messages
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.core.urlresolvers import reverse
from django.http import HttpResponseRedirect, JsonResponse
from django.shortcuts import render, get_object_or_404
from django.views.decorators.http import require_POST

from .forms import LoginForm, RegisterForm, ProfileForm, SettingForm
from .models import User

from actions.models import Action
from actions.utils import create_action
from utils import make_paginator
from utils.decorators import ajax_required

# 用户主页
def home(request, user_id):
    user = get_object_or_404(User, pk=user_id)
    profile = user.profile
    following = user.following.count()
    followers = user.followers.count()
    recent_actions = Action.objects.filter(user=user).all()[:10]
    return render(request, 'user/index.tpl', {
            'actions': recent_actions,
            'user': user,
            'profile': profile,
            'following_num': following,
            'followers_num': followers
        })

# 登录
def user_login(request):
    if request.method == 'POST':
        form = LoginForm(request.POST)
        if form.is_valid():
            user = form.get_authenticated_user()
            login(request, user)
            return HttpResponseRedirect(reverse('home:index'))
    else:
        form = LoginForm()
    return render(request, 'user/login.tpl', {
            'form': form
        })

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

# 用户博客
def user_posts(request, user_id):
    user = get_object_or_404(User, pk=user_id)
    posts = user.posts
    return render(request, 'user/posts.tpl', {
            'posts': posts,
            'user': user,
        })

# 正在关注
def user_following(request, user_id):
    user = get_object_or_404(User, pk=user_id)
    followings = make_paginator(request, user.following.all())
    return render(request, 'user/user_list.tpl', {
            'users': followings,
            'user': user,
        })

# 被关注的
def user_followers(request, user_id):
    user = get_object_or_404(User, pk=user_id)
    followers = make_paginator(request, user.followers.all())
    return render(request, 'user/user_list.tpl', {
            'users': followers,
            'user': user,
        })

# 分享
def user_shared(request, user_id):
    user = get_object_or_404(User, pk=user_id)
    foods_shared = make_paginator(request, user.foods_shared.all())
    return render(request, 'user/share.tpl', {
            'foods': foods_shared,
            'user': user,
        })

# 想吃的
def user_wants_to_eat(request, user_id):
    user = get_object_or_404(User, pk=user_id)
    foods = make_paginator(request, user.foods_wta.all())
    return render(request, 'user/food_list.tpl', {
            'foods': foods,
            'user': user,
        })

# 吃过的
def user_ate(request, user_id):
    user = get_object_or_404(User, pk=user_id)
    foods = make_paginator(request, user.foods_ate.all())
    return render(request, 'user/food_list.tpl', {
            'foods': foods,
            'user': user,
        })

# Topic收藏夹
def topics_collection(request, user_id):
    user = get_object_or_404(User, pk=user_id)
    collections = make_paginator(request, user.topics_collected.all())
    return render(request, 'user/topic_collection.tpl', {
            'collections': collections,
            'user': user,
        })

# 个人设置
@login_required
def user_settings(request):
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
            'form': form
        })

# 个人档案
@login_required
def user_profile(request):
    profile = request.user.profile
    if request.method == 'POST':
        form = ProfileForm(instance=profile, data=request.POST,
                            files=request.FILES)
        if form.is_valid():
            form.save()
            messages.success(request, '资料更新成功')
        else:
            messages.error(request, '资料更新失败')
    else:
        form = ProfileForm(instance=profile)
    return render(request, 'user/profile.tpl', {
            'profile': profile,
            'form': form
        })

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
            request.user.followings.add(user)
            create_action(request.user, '关注了', user)
        elif action == 'unfollow':
            request.user.followings.remove(user)
        else:
            return JsonResponse({'status':'fail'})
        return JsonResponse({'status':'ok'})
    return JsonResponse()
