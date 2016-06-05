from django.conf import settings
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render

from .forms import SearchForm

from food.models import Food

from haystack.query import SearchQuerySet

categorys = Food.get_food_categorys()

def search(request):
    form = SearchForm(request.POST)
    if form.is_valid():
        cd = form.cleaned_data
        if settings.FULLTEXT_SEARCH is True:
            foods = SearchQuerySet().models(Food).filter(content=cd['q']).load_all()
            total_results = foods.count()
        else:
            foods = Food.objects.filter(title__contains=cd['q'])
        return render(request, 'food/list.tpl', {
                    'foods': foods,
                    'categorys': categorys
                })
    return HttpResponse(status=400)

