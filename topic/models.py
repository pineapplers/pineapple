from django.db import models

from comments.models import Comment
from user.models import User

# Create your models here.
class Topic(models.Model):
    title = models.CharField(max_length=32, verbose_name='专题名称')
    user_likes = models.ManyToManyField(User, related_name='topics_liked', blank=True, verbose_name='点赞用户')
    comments = models.ManyToManyField(Comment, blank=True, verbose_name='专题评论')

