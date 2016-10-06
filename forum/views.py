from django.shortcuts import render, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.http import HttpResponseRedirect, JsonResponse
from django.core.urlresolvers import reverse

from actions.utils import create_action
from constants import *
from comments.forms import ForumPostCommentForm
from .forms import ForumPostForm
from .models import ForumPost
from utils import make_paginator

# Create your views here.
def post_index(request):
    if request.method == 'POST':
        if request.user.is_authenticated():
            form = ForumPostForm(request.POST)
            if form.is_valid():
                post = form.save(commit=False)
                post.creator = request.user
                post.save()
                create_action(request.user, POST, post)
                return HttpResponseRedirect(reverse('forum:index'))
        else:
            return HttpResponseRedirect(reverse('user:login'))
    else:
        form = ForumPostForm()
        posts = make_paginator(request, ForumPost.objects.order_by('-created'), per_page=20)
        return render(request, 'forum/index.tpl', {
            'form': form,
            'posts': posts
        })
    return render(request, 'forum/index.tpl', {
            'form': form
        })

def post_detail(request, post_id):
    post = get_object_or_404(ForumPost.objects.prefetch_related('comments__user__profile'), pk=post_id)
    comments = make_paginator(request, post.comments.all())
    if request.method == 'POST':
        if request.user.is_authenticated():
            form = ForumPostCommentForm(request.POST)
            if form.is_valid():
                comment = form.save(commit=False)
                comment.user = request.user
                comment.post = post
                comment.save()
                return HttpResponseRedirect(reverse('forum:detail', kwargs={'post_id': post.id}))
        else:
            return HttpResponseRedirect(reverse('user:login'))
    else:
        form = ForumPostCommentForm()
    return render(request, 'forum/detail.tpl', {
            'post': post,
            'comments': comments,
            'form': form
        })

@login_required
def delete_post(request, post_id):
    post = get_object_or_404(ForumPost.objects, pk=post_id)
    if post:
        if post.creator == request.user:
            post.delete()
            return HttpResponseRedirect(reverse('forum:index'))

@login_required
def update_post(request):
    pass

@login_required
def query_post(request):
    q = request.POST.get('q', '').strip()
    form = ForumPostForm()
    if q:
        posts = make_paginator(request, ForumPost.objects.filter(title__icontains=q).all(), per_page=20)
    else:
        posts = []
    return render(request, 'forum/index.tpl', {
        'form': form,
        'posts': posts
    })

@login_required
def post_like(request, post_id):
    post = get_object_or_404(ForumPost.objects, pk=post_id)
    post.users_like.add(request.user)
    if post.users_like.count() <= post.total_likes:
        return JsonResponse(JSON_FAIL(POST_ALREADY_LIKE))
    post.total_likes += 1
    post.save()
    return JsonResponse(JSON_SUCCESS)
