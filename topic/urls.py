from django.conf.urls import url

from .views import topic_list, topic_detail, topic_collect

urlpatterns = [
    url(r'', topic_list, name='list'),
    url(r'^(?P<topic_id>[\d]+)', topic_detail, name='detail'),
    url(r'^(?P<topic_id>[\d]+)/collect', topic_collect, name='collect'),
]