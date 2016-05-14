from django.contrib import admin

from comments.models import PostComment
from .models import Post

# Register your models here.
class PostCommentAdmin(admin.TabularInline):
    model = PostComment


class PostAdmin(admin.ModelAdmin):
    model = Post

    inlines = [PostCommentAdmin]


admin.site.register(Post, PostAdmin)
