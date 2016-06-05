from django.core.urlresolvers import reverse
from django.db import models

from taggit.managers import TaggableManager
from user.models import User
from updown.fields import RatingField


# Create your models here.
class FoodCategory(models.Model):
    name = models.CharField(max_length=16, verbose_name='分类名称')

    def __str__(self):
        return self.name

    def get_absolute_url(self):
        return reverse('food:category', kwargs={'category': self.name})

    class Meta:
        verbose_name = '食品分类'
        verbose_name_plural = '食品分类'


class Food(models.Model):
    title = models.CharField(max_length=128, verbose_name='标题')
    description = models.TextField(verbose_name='描述')
    cover_image = models.ImageField(upload_to='foods/cover/%Y/%m/%d', verbose_name='封面图片')
    rating = RatingField(can_change_vote=True)
    users_wta = models.ManyToManyField(User, related_name='foods_wta', blank=True, verbose_name='想吃的用户')
    users_ate = models.ManyToManyField(User, related_name='foods_ate', blank=True, verbose_name='吃过的用户')
    link = models.URLField(blank=True, verbose_name='相关链接')
    category = models.ForeignKey(FoodCategory, related_name='foods', verbose_name='分类')
    user = models.ForeignKey(User, related_name='foods_shared', verbose_name='创建用户')
    created = models.DateTimeField(auto_now_add=True, verbose_name='添加日期')
    tags = TaggableManager(blank=True, help_text='多个标签以逗号分隔', verbose_name="标签")

    @classmethod
    def get_food_categorys(self):
        return FoodCategory.objects.all()

    def get_absolute_url(self):
        return reverse('food:detail', kwargs={'food_id': self.id})

    def __str__(self):
        return self.title

    class Meta:
        verbose_name = '食品'
        verbose_name_plural = '食品'
        ordering = ('-created', )

