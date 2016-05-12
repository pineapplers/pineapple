from django.core.urlresolvers import reverse
from django.db import models

from comments.models import Comment
from food.models import FoodItem
from user.models import User

# Create your models here.
class FoodTopic(models.Model):
    title = models.CharField(max_length=32, verbose_name='专题名称')
    users_like = models.ManyToManyField(User, related_name='topics_liked', blank=True, verbose_name='点赞用户')
    users_collect = models.ManyToManyField(User, related_name='topics_collected', blank=True, verbose_name='收藏的用户')
    comments = models.ManyToManyField(Comment, blank=True, verbose_name='专题评论')
    foods = models.ManyToManyField(FoodItem, verbose_name='美食') 

    def __str__(self):
        return self.title

    def get_absolute_url(self):
        return reverse('topic:detail', args=[self.id])

    class Meta:
        verbose_name = '美食专题'
        verbose_name_plural = '美食专题'
