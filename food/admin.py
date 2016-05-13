from django.contrib import admin

from comments.models import Comment
from .models import FoodCategory, Food

# Register your models here.
class FoodCategoryAdmin(admin.ModelAdmin):
    model = FoodCategory


class FoodAdmin(admin.ModelAdmin):
    model = Food

    class Meta:
        ordering = ('-created',)


admin.site.register(FoodCategory, FoodCategoryAdmin)
admin.site.register(Food, FoodAdmin)