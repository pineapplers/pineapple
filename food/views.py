from django.contrib import messages
from django.conf import settings
from django.contrib.auth.decorators import login_required
from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.http import require_POST

from .models import Food, FoodCategory

from comments.models import Comment
from comments.forms import CommentForm
from utils.decorators import ajax_required
from utils import make_paginator

import redis


r = redis.StrictRedis(host=settings.REDIS_HOST,
                      port=settings.REDIS_PORT,
                      db=settings.REDIS_DB)


def food_detail(request, food_id):
    food = Food.objects.get(pk=food_id)
    comments = food.comments
    if request.method == 'POST':
        comment_form = CommentForm(request.POST)
        if comment_form.is_valid():
            comment = comment_form.save(commit=False)
            comment.user = request.user
            comment.save()
            messages.success(request, '评论成功')
        else:
            messages.error(request, '评论失败')
    else:
        comment_form = CommentForm()
    food_tags_ids = food.tags.objects.values_list('id')
    similar_foods = Food.objects.filter(tags__in=food.tags).exclude(id=food_tags_ids)
    similar_foods = similar_foods.annotate(same_tags=Count('tags')).order_by('-same_tags',
                                                                             '-publish')[:4]
    total_views = r.incr('food:{}:views'.format(image.id))
    r.zincrby('food_ranking', food.id, 1)
    return render(request, 'food/detail.tpl', {
            'food': food,
            'comments': comments,
            'comment_form': comment_form,
            'similar_foods': similar_foods,
            'total_views': total_views
        })

def food_category(request, category):
    foods = make_paginator(request, Food.objects.filter(category__name=category))
    return render(request, 'food/list.tpl', {
            'foods': foods
        })

def food_tag(request, tag):
    foods = make_paginator(request, Food.objects.filter(tag__name=category))
    return render(request, 'food/list.tpl', {
            'foods': foods
        })

def foods_most_popular(request):
    food_ranking = r.zrange('food_ranking', 0, -1, desc=True)[:10]
    food_ranking_ids = [int(id) for id in food_ranking]

    most_viewed = list(Food.objects.filter(id__in=food_ranking_ids))
    most_viewed.sort(key=lambda x: food_ranking_ids.index(x.id))
    return render(request, 'food/ranking.tpl', {
                   'most_viewed': most_viewed
                })

@ajax_required
@require_POST
@login_required
def food_like(request):
    food_id = request.POST.get('id')
    action = request.POST.get('action')
    if food_id and action:
        food = Food.objects.get(pk=food_id)
        if action == 'like':
            request.user.foods_liked.add(food)
            request.user.foods_disliked.remove(food)
            create_action(request.user, '喜欢了', food)
        elif action == 'dislike':
            request.user.foods_disliked.add(food)
            request.user.food_like.add(food)
        else:
            return JsonResponse({'status': False})
        return JsonResponse({'status': True})
    return JsonResponse({'status': False}, status=400)

@ajax_required
@require_POST
@login_required
def food_wta(request):
    food_id = request.POST.get('id')
    if food_id:
        food = Food.objects.get(pk=food_id)
        food.users_wta.add(request.user)
        fodd.users_ate.remove(request.user)
        return JsonResponse({'status': 'yes'})
    return JsonResponse({'status': False}, status=400)

@ajax_required
@require_POST
@login_required
def food_ate(request):
    food_id = request.POST.get('id')
    if food_id:
        food = Food.objects.get(pk=food_id)
        food.users_ate.add(request.user)
        fodd.users_wta.remove(request.user)
        return JsonResponse({'status': 'yes'})
    return JsonResponse({'status': False}, status=400)
