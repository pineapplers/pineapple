from django.shortcuts import render

from .forms import SearchForm

from food.models import FoodItem

from haystack.query import SearchQuerySet

def search(request):
    if 'q' in request.GET:
        form = SearchForm(request.GET)
        if form.is_valid():
            cd = form.cleaned_data
            results = SearchQuerySet().models(FoodItem).filter(content=cd['q']).load_all()
            total_results = results.count()
    return render(request, 'blog/post/search.tpl', {
                'form': form,
                'cd': cd,
                'results': results,
                'total_results': total_results}
             )

