from django.contrib import admin

from comments.models import FoodComment
from .models import FoodCategory, Food

# Register your models here.
class FoodCategoryAdmin(admin.ModelAdmin):
    model = FoodCategory


class FoodCommentAdmin(admin.TabularInline):
    model = FoodComment


class FoodAdmin(admin.ModelAdmin):
    model = Food

    inlines = [FoodCommentAdmin]

    class Meta:
        ordering = ('-created',)


admin.site.register(FoodCategory, FoodCategoryAdmin)
admin.site.register(Food, FoodAdmin)