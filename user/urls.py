from django.conf.urls import url
from django.contrib.auth.views import (password_change, password_change_done,
    password_reset, password_reset_done, password_reset_complete, password_reset_confirm)

from .views import (home, get_user_id, user_login, user_logout, user_register, user_follow, user_followers, user_following, user_posts,
    user_confirm, user_settings, user_profile, user_moments, user_shared, user_wants_to_eat, user_ate, topics_collection, get_cities)

urlpatterns = [
    url(r'^(?P<user_id>[\d]+)/$', home, name='home'),
    url(r'^whoami/$', get_user_id, name='userid'),

    url(r'^login/$', user_login, name='login'),
    url(r'^logout/$', user_logout, name='logout'),
    url(r'^register/$', user_register, name='register'),
    url(r'^confirm/(?P<token>.+)/$', user_confirm, name='confirm'),

    url(r'^password-change/$', password_change, name='password_change'),
    url(r'^password-change/done/$', password_change_done, name='password_change_done'),

    url(r'^password-reset/$', password_reset, name='password_reset'),
    url(r'^password-reset/done/$', password_reset_done, name='password_reset_done'),
    url(r'^password-reset/confirm/(?P<uidb64>[-\w]+)/(?P<token>[-\w]+)/$', password_reset_confirm, name='password_reset_confirm'),
    url(r'^password-reset/complete/$', password_reset_complete, name='password_reset_complete'),

    url(r'^settings/$', user_settings, name='settings'),
    url(r'^profile/$', user_profile, name='profile'),
    url(r'^moments/$', user_moments, name='moments'),

    url(r'^(?P<user_id>[\d]+)/shared/$', user_shared, name='share'),
    url(r'^(?P<user_id>[\d]+)/following/$', user_following, name='following'),
    url(r'^(?P<user_id>[\d]+)/followers/$', user_followers, name='followers'),
    url(r'^(?P<user_id>[\d]+)/wta/$', user_wants_to_eat, name='wta'),
    url(r'^(?P<user_id>[\d]+)/ate/$', user_ate, name='ate'),
    url(r'^(?P<user_id>[\d]+)/posts/$', user_posts, name='posts'),
    url(r'^(?P<user_id>[\d]+)/topic-collection', topics_collection, name='topic-collection'),

    url(r'^follow/$', user_follow, name='follow'),
    url(r'^get_cities/$', get_cities, name='get_cities'),
]