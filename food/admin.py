from django.contrib import admin

from .models import FoodCategory, FoodItem

# Register your models here.
class FoodCategoryAdmin(admin.ModelAdmin):
	model = FoodCategoryAdmin

class FoodItemAdmin(admin.ModelAdmin):
	model = FoodItem

	class Meta:
		ordering = ('-created',)


admin.site.register(FoodCategory, FoodCategoryAdmin)
admin.site.register(FoodItem, FoodItemAdmin)