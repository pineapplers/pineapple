from django.shortcuts import render

from .models import FoodTopic
from utils import make_paginator

# Create your views here.
def topic_list(request):
    topics = make_paginator(request, topic.objects.all())
    if request.is_ajax():
        return render(request, 'topic/list_ajax.tpl',
                      {'topics': topics})
    return render(request, 'topic/list.tpl', topics=topics)


def topic_detail(request, topic_id):
    topic = FoodTopic.objects.get(pk=topic_id)
    foods = make_paginator(request, topic.foods.all())
    return render(request, 'topic/detail.tpl', foods=foods)
