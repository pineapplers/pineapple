from django.conf.urls import url

from .views import post_index, delete_post, query_post, update_post, post_detail, post_like

urlpatterns = [
    url(r'^$', post_index, name='index'),
    url(r'^post/(?P<post_id>[\d]+)/$', post_detail, name='detail'),
    url(r'^post/(?P<post_id>[\d]+)/like/$', post_like, name='like'),
    url(r'^delete/(?P<post_id>[\d]+)/$', delete_post, name='delete'),
    url(r'^query/$', query_post, name='query'),
    url(r'^update/(?P<post_id>[\d]+)/$', update_post, name='update'),
]