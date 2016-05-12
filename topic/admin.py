from django.contrib import admin

from .models import FoodTopic

# Register your models here.
class FoodTopicAdmin(admin.ModelAdmin):
	model = FoodTopic


admin.site.register(FoodTopic, FoodTopicAdmin)
