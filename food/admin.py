from django.contrib import admin

from comments.models import Comment
from .models import FoodCategory, FoodItem

# Register your models here.
class FoodCategoryAdmin(admin.ModelAdmin):
	model = FoodCategoryAdmin


class FoodCommentAdmin(admin.TabularInline):
    model = Comment


class FoodItemAdmin(admin.ModelAdmin):
	model = FoodItem

    inlines = [
        FoodCommentAdmin,
    ]

	class Meta:
		ordering = ('-created',)


admin.site.register(FoodCategory, FoodCategoryAdmin)
admin.site.register(FoodItem, FoodItemAdmin)