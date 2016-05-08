from django.db import models

# Create your models here.
class Province(models.Model):
    name = models.CharField(max_length=32, verbose_name='省份名称')

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = '省份'
        verbose_name_plural = '省份'


class City(models.Model):
    name = models.CharField(max_length=32, verbose_name='城市名称')
    province = models.ForeignKey(Province, verbose_name='省份')

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = '城市'
        verbose_name_plural = '城市'
