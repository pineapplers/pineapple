from django.conf.urls import url

from .views import send, pull, attention, user_base_profile, pull_new_msgs

urlpatterns = [
    url(r'^send/$', send, name='send'),
    url(r'^pull/$', pull, name='pull'),
    url(r'^attention/$', attention, name='attention'),
    url(r'^new/$', pull_new_msgs, name='pull_new'),
    url(r'^profile/$', user_base_profile, name='profile'),
]