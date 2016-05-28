from django.contrib import admin
from django.core.urlresolvers import reverse
from django.utils.html import format_html

from comments.models import FoodComment
from .models import FoodCategory, Food

# Register your models here.
class FoodCategoryAdmin(admin.ModelAdmin):
    model = FoodCategory


class FoodCommentAdmin(admin.TabularInline):
    model = FoodComment


class FoodAdmin(admin.ModelAdmin):
    model = Food
    list_display = ('title', 'category', 'created', 'show_firm_url')

    def show_firm_url(self, obj):
        return format_html("<a href='{url}'>{url}</a>", url=reverse('food:detail', kwargs={'food_id': obj.id}))

    show_firm_url.short_description = '地址'

    inlines = [FoodCommentAdmin]

    class Meta:
        ordering = ('-created',)


admin.site.register(FoodCategory, FoodCategoryAdmin)
admin.site.register(Food, FoodAdmin)