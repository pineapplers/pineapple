from django.conf.urls import url

from .views import food_detail, food_like, food_category

urlpatterns = [
    url(r'^(?P<food_id>)$', food_detail, name='detail'),
    url(r'^food_like/$', food_like, name='like'),
    url(r'^category/(?P<category>)/$', food_category, name='category'),
]