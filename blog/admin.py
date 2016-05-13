from django.contrib import admin

from .models import Post

# Register your models here.
class PostAdmin(admin.ModelAdmin):
    model = Post


admin.site.register(Post, PostAdmin)
