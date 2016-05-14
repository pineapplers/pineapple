from django.contrib.auth.models import AbstractUser
from django.core.urlresolvers import reverse
from django.db import models
from django.db.models.signals import post_save
from django.dispatch import receiver

from location.models import City

# Create your models here.
class User(AbstractUser):
    following = models.ManyToManyField('self', blank=True, related_name='followers', symmetrical=False)

    def __str__(self):
        return self.username

    def get_absolute_url(self):
        return reverse('user:home', args=[self.id])


class UserSetting(models.Model):
    user = models.OneToOneField(User, related_name='settings', on_delete=models.CASCADE)
    background_img = models.ImageField(upload_to='users/background/%Y/%m/%d', blank=True, verbose_name='主页背景')

    def __str__(self):
        return "{}的设置".format(self.user.username)

    class Meta:
        verbose_name = '用户设置'
        verbose_name_plural = '用户设置'


class UserProfile(models.Model):
    user = models.OneToOneField(User, related_name='profile', on_delete=models.CASCADE)
    location = models.ForeignKey(City, null=True, blank=True, verbose_name='居住城市')
    introduction = models.CharField(max_length=1024, verbose_name='个人简介')
    sex = models.CharField(max_length=2, choices=[('m', '男'), ('f', '女')], null=True, blank=True, verbose_name='性别')
    date_of_birth = models.DateField(blank=True, null=True, verbose_name='出生日期')
    avatar = models.ImageField(upload_to='users/avatar/%Y/%m/%d', blank=True, verbose_name='头像')

    def __str__(self):
        return '{}的档案'.format(self.user.username)

    class Meta:
        verbose_name = '用户档案'
        verbose_name_plural = '用户档案'


@receiver(post_save, sender=User)
def user_post_save_handler(sender, instance, created, **kwargs):
    if created is True and not kwargs.get('raw', False):
        UserSetting.objects.create(user=instance)
        UserProfile.objects.create(user=instance)
        instance.save()
