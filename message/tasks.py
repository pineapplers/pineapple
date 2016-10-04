from celery import task
from constants import *

from ext import redis_db as rds
from time import time

@task
def send_msg(sender, receiver, text):
    msg = json.dumps({
        'from': sender,
        'msg': text,
        'time': time()
    })
    key_exists = True
    receiver_key = REDIS_MESSAGES_KEY.format(receiver)
    if not rds.exists(receiver_key):
        # 新key设置超时
        key_exists = False
    rds.incr(REDIS_MESSAGES_UNREAD_KEY.format(receiver), 1)
    rds.lpush(receiver_key, msg)
    rds.ltrim(receiver_key, 0, MAX_MESSAGES_COUNT)
    if not key_exists:
        rds.expire(receiver_key, MESSAGES_TIMEOUT)
    return True
