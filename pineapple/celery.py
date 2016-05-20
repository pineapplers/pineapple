import os
from celery import Celery
from django.conf import settings

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'pineapple.settings')

app = Celery('pineapple')

app.config_from_object('django.conf:settings')
app.autodiscover_tasks([])
