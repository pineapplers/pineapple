from django.shortcuts import render, get_object_or_404
from django.contrib.auth.decorators import login_required

from constants import *
from .forms import ForumPostForm
from .models import ForumPost

# Create your views here.
def post_index(request):
    if request.method == 'POST':
        if request.user.is_authenticated():
            form = ForumPostForm(request.POST)
            if form.is_valid():
                post = form.save(commit=False)
                post.creator = request.user
                food.save()
                form.save_m2m()
                create_action(request.user, POST, food)
                return HttpResponseRedirect(reverse('forum:index'))
        else:
            return HttpResponseRedirect(reverse('user:login'))
    else:
        form = ForumPostForm()
        posts = ForumPost.objects.all()[:20]
        return render(request, 'forum/index.tpl', {
            'form': form,
            'posts': posts
        })
    return render(request, 'forum/index.tpl', {
            'form': form
        })

@login_required
def delete_post(request, post_id):
    post = ForumPost.objects.get_object_or_404(id=post_id)
    if post:
        if post.creator == request.user:
            post.delete()
            return HttpResponseRedirect(reverse('forum:index'))

@login_required
def update_post(request):
    pass

@login_required
def query_post(request):
    pass
