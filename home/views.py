from django.shortcuts import render
from django.views.decorators.cache import cache_page

from actions.models import Action

from search.forms import SearchForm

# 首页
# @cache_page(60)
def home(request):
    form = SearchForm()
    if request.user.is_authenticated():
        actions = Action.objects.all().exclude(user=request.user)
        following_ids = request.user.following.values_list('id', flat=True)
        if following_ids:
            actions = actions.filter(user_id__in=following_ids).select_related('user', 'user__profile').prefetch_related('target')
        actions = actions[:10]

        return render(request, 'home/index.tpl', {
                'search_form': form,
                'actions': actions
           })
    return render(request, 'home/index.tpl', {
        'search_form': form,
    })
