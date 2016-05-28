from django.contrib import admin
from django.core.urlresolvers import reverse
from django.utils.html import format_html

from comments.models import TopicComment
from .models import FoodTopic

# Register your models here.
class TopicCommentAdmin(admin.TabularInline):
    model = TopicComment


class FoodTopicAdmin(admin.ModelAdmin):
    model = FoodTopic

    list_display = ('title', 'show_firm_url')

    def show_firm_url(self, obj):
        return format_html("<a href='{url}'>{url}</a>", url=reverse('topic:detail', kwargs={'topic_id': obj.id}))

    show_firm_url.short_description = '地址'

    inlines = [TopicCommentAdmin]


admin.site.register(FoodTopic, FoodTopicAdmin)
