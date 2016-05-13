"""pineapple URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.9/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf import settings
from django.conf.urls import url, include
from django.conf.urls.static import static
from django.contrib import admin

from home.views import home

admin.site.site_header = 'Pineapple'
admin.site.site_title = 'Pineapple Admin'

urlpatterns = [
    url(r'^$', home),
    url(r'^admin/', admin.site.urls),
    url(r'^home/', include('home.urls', namespace='home')),
    url(r'^user/', include('user.urls', namespace='user')),
    url(r'^search/', include('search.urls', namespace='search')),
    url(r'^topic/', include('topic.urls', namespace='topic')),
    url(r'^food/', include('food.urls', namespace='food')),
]
# + static('public/static', document_root=settings.STATIC_ROOT)