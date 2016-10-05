from celery import task
from celery.decorators import periodic_task
from constants import *

from ext import redis_db as rds
from time import time

import datetime
import json

@task
def send_msg(sender, receiver, text):
    msg = json.dumps({
        'from': sender,
        'to': receiver,
        'msg': text,
        'time': time()
    })
    receiver_key = REDIS_MESSAGES_KEY.format(receiver)
    sender_key = REDIS_MESSAGES_KEY.format(sender)
    rds.incr(REDIS_MESSAGES_UNREAD_KEY.format(receiver), 1)
    rds.lpush(receiver_key, msg)
    rds.ltrim(receiver_key, 0, MAX_MESSAGES_COUNT)
    rds.lpush(sender_key, msg)
    rds.ltrim(sender_key, 0, MAX_MESSAGES_COUNT)
    # 添加到最近活动集合
    rds.sadd(REDIS_MESSAGE_USERS_KEY, receiver)
    rds.sadd(REDIS_MESSAGE_USERS_KEY, sender)
    return True


# 清理不活跃的key
@periodic_task(run_every=datetime.timedelta(days=7))
def clean_inactive_msg():
    now_time = time()
    user_ids = rds.smembers(REDIS_MESSAGE_USERS_KEY)
    for uid in user_ids:
        key = REDIS_MESSAGES_KEY.format(uid.decode())
        msg = rds.lindex(key, 0)
        if not msg:
            rds.srem(REDIS_MESSAGE_USERS_KEY, uid)
            continue
        try:
            msg = json.loads(msg)
        except:
            continue
        if now_time - float(msg['time']) > MESSAGES_TIMEOUT:
            rds.srem(REDIS_MESSAGE_USERS_KEY, uid)
            rds.delete(key)
