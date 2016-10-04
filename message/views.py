from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.http import JsonResponse

from constants import *
from ext import redis_db as rds
from .tasks import send_msg

# Create your views here.
@login_required
def send(request):
    text = request.POST.get('msg')
    receiver = request.POST.get('user')
    if len(text) > MAX_MESSAGE_LENGTH:
        # 限制消息长度
        return JsonResponse(JSON_FAIL(MAX_MESSAGE_LENGTH_REACH))
    sender = request.user.id
    # 交给celery完成
    send_msg.delay(sender, receiver, text)
    return JsonResponse(JSON_SUCCESS)

@login_required
def pull(request):
    receiver = request.user.id
    rds.set(REDIS_MESSAGES_UNREAD_KEY.format(receiver), 0)
    messages = rds.lrange(REDIS_MESSAGES_KEY(receiver), 0, MAX_MESSAGES_COUNT)
    return JSON_SUCCESS_WITH_DATA({'data': messages})

@login_required
def attention(request):
    receiver = request.user.id
    msg_count = rds.get(REDIS_MESSAGES_UNREAD_KEY.format(receiver))
    if not msg_count:
        msg_count = 0
    return JSON_SUCCESS_WITH_DATA({'count': msg_count})
