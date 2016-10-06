import redis
from django.conf import settings

redis_db = redis.StrictRedis(host=settings.REDIS_HOST,
                      port=settings.REDIS_PORT,
                      db=settings.REDIS_DB,
                      decode_responses=True)
