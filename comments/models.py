from django.db import models

from user.models import User

# Create your models here.
class Comment(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name='评论用户')
    content = models.CharField(max_length=512, verbose_name='评论内容')
    created = models.DateTimeField(auto_now_add=True, verbose_name='评论时间')

    class Meta:
        verbose_name = '评论'
        verbose_name_plural = '评论'
