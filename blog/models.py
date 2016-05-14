from django.db import models

from user.models import User

# Create your models here.
class Post(models.Model):
    title = models.CharField(max_length=128, verbose_name='标题')
    user = models.ForeignKey(User, related_name='posts', verbose_name='用户')
    body = models.TextField(verbose_name='内容')
    created = models.DateTimeField(auto_now_add=True, verbose_name='创建日期')

    class Meta:
        verbose_name = '帖子'
        verbose_name_plural = '帖子'
