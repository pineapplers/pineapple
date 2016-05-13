from django.contrib import messages
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.core.urlresolvers import reverse
from django.http import HttpResponseRedirect, JsonResponse
from django.shortcuts import render
from django.views.decorators.http import require_POST

from .forms import LoginForm, RegisterForm, ProfileForm
from .models import User

from actions.models import Action
from actions.utils import create_action
from utils import make_paginator
from utils.decorators import ajax_required

# 用户主页
def home(request, user_id):
    user = User.objects.get(pk=user_id)
    recent_actions = Action.objects.filter(user=request.user).all()[:10]
    return render(request, 'user/index.tpl', {
            'actions': recent_actions,
            'user': user,
        })

# 登录
def user_login(request):
    if request.method == 'POST':
        form = LoginForm(request.POST)
        if form.is_valid():
            user = form.get_authenticated_user()
            login(request, user)
            return HttpResponseRedirect(reverse('home'))
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
            return HttpResponseRedirect(reverse('home'))
    else:
        form = RegisterForm()
    return render(request, 'user/register.tpl', {
            'form': form
        })

# 正在关注
def user_following(request, user_id):
    user = User.objects.get(pk=user_id)
    followings = make_paginator(request, user.followings.all())
    return render(request, 'user/list.tpl', {
            'users': followings
        })

# 被关注的
def user_followers(request, user_id):
    user = User.objects.get(pk=user_id),
    followers = make_paginator(request, user.followers.all())
    return render(request, 'user/list.tpl', {
            'users': followers
        })

# Food收藏夹
@login_required
def foods_collection(request):
    collections = make_paginator(request, request.user.foods_collect.all())
    return render(request, 'user/foods_collection.tpl', {
            'collections': collections
        })

# Topic收藏夹
@login_required
def topics_collection(request):
    collections = make_paginator(request, request.user.topics_collect.all())
    return render(request, 'user/topics_collection.tpl', {
            'collections': collections
        })

# 个人设置
@login_required
def user_settings(request):
    settings = request.user.settings
    return render(request, 'user/settings.tpl', {
            'settings': settings
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
