from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.http import JsonResponse

from constants import *
from ext import redis_db as rds

from time import time
from datetime import datetime

# Create your views here.
@login_required
def send(request, user_id):
	text = request.POST.get('msg')
	if len(text) > MAX_MESSAGE_LENGTH:
		# 限制消息长度
		return JsonResponse(JSON_FAIL(MAX_MESSAGE_LENGTH_REACH))
	receiver = user_id
	sender = request.user.id
	msg = json.dumps({
		'from': sender,
		'msg': text,
		'time': time()
	})
	rds.incr(REDIS_MESSAGES_UNREAD_KEY.format(receiver), 1)
	rds.lpush(REDIS_MESSAGES_KEY.format(receiver), msg)
	rds.ltrim(REDIS_MESSAGES_KEY.format(receiver), 0, MAX_MESSAGES_COUNT)
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
	return JSON_SUCCESS_WITH_DATA({'count': msg_count})