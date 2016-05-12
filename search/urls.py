from django.conf.urls import url

from .views import search

urlpatterns = [
    url(r'^(?P<query_string>)/$', search, name='search'),
]