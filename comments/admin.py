from django.contrib import admin

from .models import FoodComment


class FoodCommentAdmin(admin.ModelAdmin):
    model = FoodComment


admin.site.register(FoodComment)
