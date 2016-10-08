from django.contrib import messages
from django.contrib.contenttypes.models import ContentType
from django.core.urlresolvers import reverse
from django.contrib.auth.decorators import login_required
from django.db.models import Count
from django.shortcuts import render, get_object_or_404
from django.http import HttpResponseRedirect, JsonResponse
from django.views.decorators.http import require_POST
from django.views.decorators.cache import cache_page
from django.views.decorators.csrf import csrf_exempt

from .forms import FoodForm
from .models import Food

from actions.utils import create_action
from comments.models import Comment
from comments.forms import FoodCommentForm
from constants import *
from utils import make_paginator
from utils.decorators import ajax_required, tab
from updown.views import AddRatingFromModel
from updown.models import Vote

from ext import redis_db as rds

categorys = Food.get_food_categorys()

@login_required
@cache_page(60)
def food_create(request):
    if request.method == 'POST':
        form = FoodForm(request.POST, request.FILES)
        if form.is_valid():
            food = form.save(commit=False)
            food.user = request.user
            food.save()
            form.save_m2m()
            create_action(request.user, SHARE, food)
            return HttpResponseRedirect(reverse('food:detail', kwargs={'food_id': food.id}))
    else:
        form = FoodForm()
    return render(request, 'food/create.tpl', {
            'form': form,
            'categorys': categorys
        })


def food_latest(request):
    foods = Food.objects.all()
    return render(request, 'food/list.tpl', {
            'foods': foods,
            'categorys': categorys
        })


def food_detail(request, food_id):
    user = request.user
    user_authenticated = user.is_authenticated()
    food = get_object_or_404(Food.objects.prefetch_related('comments').select_related('user__profile'), pk=food_id)
    comments = make_paginator(request, food.comments.order_by('-created').all())
    if request.method == 'POST':
        comment_form = FoodCommentForm(request.POST)
        if user_authenticated:
            if comment_form.is_valid():
                comment = comment_form.save(commit=False)
                comment.user = user
                comment.food = food
                comment.save()
                messages.success(request, COMMENT_SUCCESS)
                return HttpResponseRedirect(reverse('food:detail', kwargs={'food_id': food_id}))
            else:
                messages.error(request, COMMENT_FAIL)
        else:
            messages.error(request, COMMENT_AFTER_LOGIN)
    else:
        comment_form = FoodCommentForm()
    food_tags_ids = food.tags.values_list('id')
    similar_foods = Food.objects.filter(tags__in=food_tags_ids).exclude(id=food.id)
    similar_foods = similar_foods.annotate(same_tags=Count('tags')).order_by('-same_tags')[:4]
    total_views = rds.incr(REDIS_FOOD_VIEWS_KEY.format(food.id))
    rds.zincrby(REDIS_FOOD_RANKING_KEY, food.id, 1)
    context = {
        'food': food,
        'comments': comments,
        'comment_form': comment_form,
        'similar_foods': similar_foods,
        'total_views': total_views,
        'score': 0
    }
    if user_authenticated:
        rating = Vote.objects.filter(user=user, object_id=food.id, 
            content_type=ContentType.objects.get_for_model(model=Food)).only('score').first()
        context['score'] = rating.score if rating else 0
        context['is_wta'] = user.foods_wta.filter(pk=food.id).exists()
        context['is_ate'] = user.foods_ate.filter(pk=food.id).exists()
    return render(request, 'food/detail.tpl', context)

def food_category(request, category):
    foods = make_paginator(request, Food.objects.filter(category__name=category))
    return render(request, 'food/list.tpl', {
            'foods': foods,
            'categorys': categorys,
            'section': category
        })

def food_tag(request, tag):
    foods = make_paginator(request, Food.objects.filter(tags__name=tag))
    return render(request, 'food/list.tpl', {
            'foods': foods,
            'categorys': categorys
        })

@tab('explore', sub_tab='new')
def explore(request):
    foods = make_paginator(request, Food.objects.all()[:50])
    return render(request, 'food/explore.tpl', {
                   'foods': foods
                })

@tab('explore', sub_tab='hot')
def hot(request):
    food_ranking = rds.zrange(REDIS_FOOD_RANKING_KEY, 0, MAX_HOT_DISPLAY_COUNT, desc=True)
    food_ranking_ids = [int(id) for id in food_ranking]

    most_viewed = list(Food.objects.filter(id__in=food_ranking_ids))

    return render(request, 'food/explore.tpl', {
                   'foods': most_viewed
                })

@ajax_required
@require_POST
@login_required
def food_rate(request):
    food_id = request.POST.get('id')
    action = request.POST.get('action')
    view = AddRatingFromModel()
    if action == 'like':
        score = 1
        food = Food.objects.get(pk=food_id)
        if food:
            create_action(request.user, LIKE, food)
    else:
        score = -1
    resp = view(request,
        app_label='food',
        model='Food',
        field_name='rating',
        object_id=int(food_id),
        score=score
    )
    return JsonResponse({'status': resp.status_code==200}, status=resp.status_code)

@ajax_required
@require_POST
@login_required
def food_wta(request):
    food_id = request.POST.get('id')
    action = request.POST.get('action')
    if food_id and action:
        food = Food.objects.get(pk=food_id)
        if action == 'wta':
            create_action(request.user, WTA, food)
            food.users_wta.add(request.user)
        else:
            food.users_wta.remove(request.user)
        return JsonResponse({'status': True})
    return JsonResponse({'status': False}, status=400)

@ajax_required
@require_POST
@login_required
def food_ate(request):
    food_id = request.POST.get('id')
    action = request.POST.get('action')
    if food_id and action:
        food = Food.objects.get(pk=food_id)
        if action == 'ate':
            create_action(request.user, ATE, food)
            food.users_ate.add(request.user)
        else:
            food.users_ate.remove(request.user)
        return JsonResponse(JSON_SUCCESS)
    return JsonResponse(JSON_FAIL(STATUS_INVALID_ARGUMENTS), status=400)
