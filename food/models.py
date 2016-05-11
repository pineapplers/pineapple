from django.db import models

from comments.models import Comment
from user.models import User

# Create your models here.
class FoodCategory(models.Model):
    name = models.CharField(max_length=16, verbose_name='分类名称')

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = '美食分类'
        verbose_name_plural = '美食分类'


class FoodItem(models.Model):
    title = models.CharField(max_length=128, verbose_name='标题')
    description = models.TextField(verbose_name='描述')
    cover_image = models.ImageField(upload_to='items/cover/%Y/%m/%d', verbose_name='封面图片')
    users_like = models.ManyToManyField(User, related_name='foods_liked', blank=True, verbose_name='喜欢的用户')
    users_dislike = models.ManyToManyField(User, related_name='foods_disliked', blank=True, verbose_name='不喜欢的用户')
    link = models.URLField(blank=True, verbose_name='相关链接')
    comments = models.ManyToManyField(Comment, blank=True, verbose_name='评论')
    category = models.ForeignKey(FoodCategory, related_name='foods', verbose_name='分类')
    user = models.ForeignKey(User, related_name='foods_shared', verbose_name='创建用户')
    created = models.DateTimeField(auto_now_add=True, verbose_name='添加日期')


    def __str__(self):
        return self.title

    class Meta:
        verbose_name = '美食'
        verbose_name_plural = '美食'
