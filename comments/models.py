from django.db import models

from forum.models import ForumPost
from blog.models import Post as BlogPost
from food.models import Food
from topic.models import FoodTopic
from user.models import User

# Create your models here.
class Comment(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name='评论用户')
    content = models.TextField(max_length=512, verbose_name='评论内容')
    created = models.DateTimeField(auto_now_add=True, verbose_name='评论时间')

    def __str__(self):
        return "{}: {}".format(self.user, self.content)

    class Meta:
        abstract = True
        verbose_name = '评论'
        verbose_name_plural = '评论'


class FoodComment(Comment):
    food = models.ForeignKey(Food, on_delete=models.CASCADE, related_name='comments', verbose_name='美食')

    class Meta:
        verbose_name = '美食评论'
        verbose_name_plural = '美食评论'


class TopicComment(Comment):
    topic = models.ForeignKey(FoodTopic, on_delete=models.CASCADE, related_name='comments', verbose_name='专题')

    class Meta:
        verbose_name = '专题评论'
        verbose_name_plural = '专题评论'


class ForumPostComment(Comment):
    post = models.ForeignKey(ForumPost, on_delete=models.CASCADE, related_name='comments', verbose_name='帖子')

    class Meta:
        verbose_name = '帖子评论'
        verbose_name_plural = '帖子评论'


class PostComment(Comment):
    post = models.ForeignKey(BlogPost, on_delete=models.CASCADE, related_name='comments', verbose_name='帖子')

    class Meta:
        verbose_name = '博客评论'
        verbose_name_plural = '博客评论'
