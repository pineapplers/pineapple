from django.conf.urls import url

from .views import food_latest, food_detail, food_rate, food_category, food_tag, explore, hot, food_wta, food_ate

urlpatterns = [
    url(r'^$', food_latest, name='list'),
    url(r'^(?P<food_id>[\d]+)/$', food_detail, name='detail'),
    url(r'^rate/$', food_rate, name='rate'),
    url(r'^food_wta/$', food_wta, name='wta'),
    url(r'^food_ate/$', food_ate, name='ate'),
    url(r'^category/(?P<category>[\w]+)/$', food_category, name='category'),
    url(r'^tag/(?P<tag>[\w]+)/$', food_tag, name='tag'),
    url(r'^explore/$', explore, name='explore'),
    url(r'^explore/hot/$', hot, name='hot'),
]