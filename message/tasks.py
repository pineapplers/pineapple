from celery import task
from constants import *

from ext import redis_db as rds
from time import time

import json

@task
def send_msg(sender, receiver, text):
    msg = json.dumps({
        'from': sender,
        'to': receiver,
        'msg': text,
        'time': time()
    })
    receiver_key_exists = True
    sender_key_exists = True
    receiver_key = REDIS_MESSAGES_KEY.format(receiver)
    sender_key = REDIS_MESSAGES_KEY.format(sender)
    if not rds.exists(receiver_key):
        # 新key设置超时
        receiver_key_exists = False
    if not rds.exists(sender_key):
        sender_key_exists = False
    rds.incr(REDIS_MESSAGES_UNREAD_KEY.format(receiver), 1)
    rds.lpush(receiver_key, msg)
    rds.ltrim(receiver_key, 0, MAX_MESSAGES_COUNT)
    rds.lpush(sender_key, msg)
    rds.ltrim(sender_key, 0, MAX_MESSAGES_COUNT)
    if not receiver_key_exists:
        rds.expire(receiver_key, MESSAGES_TIMEOUT)
    if not sender_key_exists:
        rds.expire(sender_key, MESSAGES_TIMEOUT)
    return True
