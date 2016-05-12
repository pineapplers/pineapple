from django.conf.urls import url

from .views import topic_list, topic_detail

urlpatterns = [
    url(r'', topic_list, name='list'),
    url(r'^(?P<topic_id>[\d]+)', topic_detail, name='detail'),
]