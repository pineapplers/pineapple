from django.contrib.auth.decorators import login_required
from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.http import require_POST

from .models import FoodItem, FoodCategory
from utils.decorators import ajax_required
from utils import make_paginator


def food_detail(request, food_id):
    food = FoodItem.objects.get(pk=food_id)
    return render(request, 'food/detail.tpl', {
            'food': food
        })

def food_category(request, category):
    foods = make_paginator(request, FoodItem.objects.filter(category__name=category))
    return render(request, 'food/list.tpl', {
            'foods': foods
        })

def food_tag(request, tag):
    foods = make_paginator(request, FoodItem.objects.filter(tag__name=category))
    return render(request, 'food/list.tpl', {
            'foods': foods
        })

def foods_most_popular(request):
    pass

@ajax_required
@require_POST
@login_required
def food_like(request):
    food_id = request.POST.get('id')
    action = request.POST.get('action')
    if food_id and action:
        food = FoodItem.objects.get(pk=food_id)
        if action == 'like':
            request.user.foods_liked.add(food)
            request.user.foods_disliked.remove(food)
            create_action(request.user, 'like', food)
        elif action == 'dislike':
            request.user.foods_disliked.add(food)
            request.user.food_like.add(food)
        else:
            return JsonResponse({'status': 'no'})
        return JsonResponse({'status': 'yes'})
    return JsonResponse()
