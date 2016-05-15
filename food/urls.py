from django.conf.urls import url

from .views import food_detail, food_like, food_category, food_tag, explore, food_wta, food_ate

urlpatterns = [
    url(r'^(?P<food_id>[\d]+)/$', food_detail, name='detail'),
    url(r'^food_like/$', food_like, name='like'),
    url(r'^food_wta/$', food_wta, name='wta'),
    url(r'^food_ate/$', food_ate, name='ate'),
    url(r'^category/(?P<category>[\w]+)/$', food_category, name='category'),
    url(r'^tag/(?P<tag>)/$', food_tag, name='tag'),
    url(r'^explore/$', explore, name='explore'),
]