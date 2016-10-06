from django.contrib import admin

# Register your models here.
from comments.models import ForumPostComment
from .models import ForumPost, Board

# Register your models here.
class BoardAdmin(admin.ModelAdmin):
    model = Board

class ForumPostCommentAdmin(admin.TabularInline):
    model = ForumPostComment


class ForumPostAdmin(admin.ModelAdmin):
    model = ForumPost

    inlines = [ForumPostCommentAdmin]


admin.site.register(ForumPost, ForumPostAdmin)
admin.site.register(Board, BoardAdmin)
