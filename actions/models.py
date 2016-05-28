from django.db import models
from django.contrib.contenttypes.models import ContentType
from django.contrib.contenttypes.fields import GenericForeignKey

from user.models import User


action_classes = {
  '分享了': 'fa-share-alt',
  '喜欢了': 'fa-thumbs-up',
  '收藏了': 'fa-bookmark',
  '关注了': 'fa-eye',
  '评论了': 'fa-comment',
  '想吃': 'fa-cutlery',
  '吃过': 'fa-hand-peace-o',
}

# Create your models here.
class Action(models.Model):
    user = models.ForeignKey(User,
                             related_name='actions',
                             db_index=True, verbose_name='用户')
    verb = models.CharField(max_length=255, verbose_name='活动描述')
    target_ct = models.ForeignKey(ContentType,
                                  blank=True,
                                  null=True,
                                  related_name='target_obj', verbose_name='活动对象类型')
    target_id = models.PositiveIntegerField(null=True,
                                            blank=True,
                                            db_index=True, verbose_name='活动对象id')
    target = GenericForeignKey('target_ct', 'target_id')
    created = models.DateTimeField(auto_now_add=True,
                                   db_index=True, verbose_name='活动时间')

    def __str__(self):
        return self.user.username + self.verb + self.target_ct.app_label

    def get_action_class(self):
        return action_classes.get(self.verb, "")

    class Meta:
        ordering = ('-created',)
        verbose_name = '活动'
        verbose_name_plural = '活动描述'