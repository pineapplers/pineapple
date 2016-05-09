from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.core.urlresolvers import reverse
from django.http import HttpResponseRedirect, JsonResponse
from django.shortcuts import render
from django.views.decorators.http import require_POST

from .forms import LoginForm, RegisterForm
from .models import User

from utils.decorators import ajax_required

# 用户主页
@login_required
def home(request):
    return render(request, 'user/index.tpl')

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
    return render(request, 'user/login.tpl', form=form)

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
    return render(request, 'user/register.tpl', form=form)

# 正在关注
def user_followings(request, user_id):
    user = User.objects.get(pk=user_id)
    followings = user.followings.all()
    return render(request, 'user/list.tpl', users=followings)

# 被关注的
def user_followers(request, user_id):
    user = User.objects.get(pk=user_id),
    followers = user.followers.all()
    return render(request, 'user/list.tpl', users=followers)

# 收藏夹
def collections(request):
    return render(request, 'user/collections.tpl')

# 个人设置
@login_required
def user_settings(request):
    settings = request.user.settings
    return render(request, 'user/settings.tpl', settings=settings)

# 个人档案
@login_required
def user_profile(request):
    profile = request.user.profile
    return render(request, 'user/profile.tpl', profile=profile)

# 关注/取消关注
@ajax_required
@require_POST
@login_required
def user_follow(request):
    user_id = request.POST.get('id')
    action = request.POST.get('action')
    return JsonResponse()
