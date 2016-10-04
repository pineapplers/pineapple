from django.conf.urls import url

from .views import post_index, delete_post, query_post, update_post

urlpatterns = [
    url(r'^$', post_index, name='index'),
    url(r'^delete/(?P<post_id>[\d]+)/$', delete_post, name='delete'),
    url(r'^query/(?P<post>[\w]+)/$', query_post, name='query'),
    url(r'^update/(?P<post_id>[\d]+)/$', update_post, name='update'),
]