from django.conf.urls import url

from .views import send, pull, attention

urlpatterns = [
    url(r'^send/(?P<user_id>[\d]+)/$', send, name='send'),
    url(r'^pull/$', pull, name='pull'),
    url(r'^attention/$', attention, name='attention'),
]