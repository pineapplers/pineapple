from django.db import models

from food.models import FoodItem
from user.models import User

# Create your models here.
class Comment(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name='评论用户')
    content = models.CharField(max_length=512, verbose_name='评论内容')
    food = models.ForeignKey(FoodItem, related_name='comments', verbose_name='所属美食')
    created = models.DateTimeField(auto_now_add=True, verbose_name='评论时间')