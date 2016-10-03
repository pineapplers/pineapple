from django.db import models

from user.models import User

# Create your models here.
class Board(models.Model):
    creator = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name='创建者')
    name = models.CharField(max_length=32, verbose_name='名称')
    created = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')


class ForumPost(models.Model):
    title = models.CharField(max_length=64, verbose_name='帖子标题')
    content = models.TextField(max_length=5096, verbose_name='帖子内容')
    creator = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name='创建者')
    board = models.ForeignKey(Board, blank=True, null=True, verbose_name='所属板块')
    created = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')
    updated = models.DateTimeField(auto_now=True, verbose_name='更新时间')
    users_like = models.ManyToManyField(User, related_name='forumposts_liked', blank=True, verbose_name='推荐的用户')
    total_likes = models.PositiveIntegerField(default=0, verbose_name='推荐数')
