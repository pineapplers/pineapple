from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.db.models import F
from django.http import JsonResponse

from constants import *
from ext import redis_db as rds
from user.models import User, UserProfile
from .tasks import send_msg

import json

# Create your views here.
@login_required
def send(request):
    text = request.POST.get('msg')
    receiver = int(request.POST.get('user'))
    if len(text) > MAX_MESSAGE_LENGTH:
        # 限制消息长度
        return JsonResponse(JSON_FAIL(MAX_MESSAGE_LENGTH_REACH))
    sender = request.user.id
    send_msg(sender, receiver, text)
    # send_msg.delay(sender, receiver, text) # 交给celery完成
    return JsonResponse(JSON_SUCCESS)

@login_required
def pull(request):
    receiver = request.user.id
    rds.set(REDIS_MESSAGES_UNREAD_KEY.format(receiver), 0)
    messages = rds.lrange(REDIS_MESSAGES_KEY.format(receiver), 0, MAX_MESSAGES_COUNT)
    messages = [json.loads(msg.decode()) for msg in messages]
    return JsonResponse(JSON_SUCCESS_WITH_DATA({'data': messages}), safe=False)

@login_required
def attention(request):
    receiver = request.user.id
    msg_count = rds.get(REDIS_MESSAGES_UNREAD_KEY.format(receiver))
    if not msg_count:
        msg_count = 0
    return JsonResponse(JSON_SUCCESS_WITH_DATA({'count': int(msg_count)}))

@login_required
def pull_new_msgs(request):
    last_time = float(request.GET.get('time', -1))
    if last_time < 0:
        return JsonResponse(JSON_FAIL(INVALID_TIMESTAMP))
    receiver = request.user.id
    messages = rds.lrange(REDIS_MESSAGES_KEY.format(receiver), 0, MAX_MESSAGES_COUNT)
    new_msgs = []
    for msg in messages:
        msg = json.loads(msg.decode())
        if float(msg['time']) <= float(last_time):
            break
        new_msgs.append(msg)
    return JsonResponse(JSON_SUCCESS_WITH_DATA({'data': new_msgs}), safe=False)


@login_required
def user_base_profile(request):
    ids = json.loads(request.POST.get('ids', '[]'))
    if len(ids) > MAX_CONTACT_COUNT:
        return JsonResponse(JSON_FAIL(MAX_CONTACT_COUNT_REACH))
    if not ids:
        profiles = []
    else:
        profiles = list(UserProfile.objects.filter(user__in=ids).annotate(name=F('user__username')).values('user', 'name', 'avatar'))
    return JsonResponse(JSON_SUCCESS_WITH_DATA({'data': profiles}), safe=False)


