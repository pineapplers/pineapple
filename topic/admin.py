from django.contrib import admin

from comments.models import TopicComment
from .models import FoodTopic

# Register your models here.
class TopicCommentAdmin(admin.TabularInline):
    model = TopicComment


class FoodTopicAdmin(admin.ModelAdmin):
    model = FoodTopic

    inlines = [TopicCommentAdmin]


admin.site.register(FoodTopic, FoodTopicAdmin)
