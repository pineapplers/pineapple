from django.contrib.auth.models import User
from django.db import models

# Create your models here.
class Contact(models.Model):
    user_from = models.ForeignKey(User, related_name='rel_from_set', on_delete=models.CASCADE)
    user_to = models.ForeignKey(User, related_name='rel_to_set', on_delete=models.CASCADE)

    class Meta:
        verbose_name = '用户联系'
        verbose_name_plural = '用户联系'


class UserSetting(models.Model):
    user = models.OneToOneField(User)

    def __str__(self):
        return "{}的设置".format(self.user.username)

    class Meta:
        verbose_name = '用户设置'
        verbose_name_plural = '用户设置'


class UserProfile(models.Model):
    user = models.OneToOneField(User)
    location = models.CharField
    introduction = models.CharField(max_length=1024, verbose_name='个人简介')
    sex = models.CharField(max_length=2, choices=[('m', '男'), ('f', '女')], null=True, blank=True, verbose_name='性别')
    date_of_birth = models.DateField(blank=True, null=True, verbose_name='出生日期')
    avatar = models.ImageField(upload_to='users/avatar/%Y/%m/%d', blank=True, verbose_name='头像')

    def __str__(self):
        return '{}的档案'.format(self.user.username)

    class Meta:
        verbose_name = '用户档案'
        verbose_name_plural = '用户档案'


User.add_to_class('following',
                  models.ManyToManyField('self',
                     through=Contact,
                     related_name='followers',
                     symmetrical=False))
