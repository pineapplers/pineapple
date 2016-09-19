from django.shortcuts import render
from django.views.decorators.cache import cache_page

from actions.models import Action
from search.forms import SearchForm
from topic.models import FoodTopic

# 首页
@cache_page(60)
def home(request):
    form = SearchForm()
    topics = FoodTopic.objects.order_by('-total_collects').all()[:4]
    return render(request, 'home/index.tpl', {
        'search_form': form,
        'topics': topics
    })
