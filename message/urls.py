from django.conf.urls import url

from .views import send, pull, attention, user_base_profile

urlpatterns = [
    url(r'^send/(?P<user_id>[\d]+)/$', send, name='send'),
    url(r'^pull/$', pull, name='pull'),
    url(r'^attention/$', attention, name='attention'),
    url(r'^profile/$', user_base_profile, name='profile'),
]