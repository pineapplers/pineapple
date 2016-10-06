from celery import task
from celery.decorators import periodic_task
from constants import *

from ext import redis_db as rds
from time import time

import datetime
import json

@task
def send_msg(sender, receiver, text):
    t = time()
    msg = json.dumps({
        'from': sender,
        'to': receiver,
        'msg': text,
        't': t
    })
    receiver_key = REDIS_MESSAGES_KEY.format(receiver)
    sender_key = REDIS_MESSAGES_KEY.format(sender)
    rds.incr(REDIS_MESSAGES_UNREAD_KEY.format(receiver), 1)
    rds.lpush(receiver_key, msg)
    rds.ltrim(receiver_key, 0, MAX_MESSAGES_COUNT)
    rds.lpush(sender_key, msg)
    rds.ltrim(sender_key, 0, MAX_MESSAGES_COUNT)
    # 添加到最近活动集合
    rds.zadd(REDIS_MESSAGE_USERS_KEY, t, receiver)
    rds.zadd(REDIS_MESSAGE_USERS_KEY, t, sender)
    return True


# 清理不活跃的key
@periodic_task(run_every=datetime.timedelta(days=7))
def clean_inactive_msg():
    now_time = time()
    user_ids = rds.zrangebyscore(REDIS_MESSAGE_USERS_KEY, 0, now_time - 1)
    for uid in user_ids:
        key = REDIS_MESSAGES_KEY.format(uid)
        rds.delete(key)
    rds.zremrangebyscore(REDIS_MESSAGE_USERS_KEY, 0, now_time - 1)
