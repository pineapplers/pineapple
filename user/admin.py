from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import User, UserProfile, UserSetting

# Register your models here.
class UserProfileAdmin(admin.TabularInline):
    model = UserProfile


class UserSettingAdmin(admin.TabularInline):
    model = UserSetting


class UserAdmin(UserAdmin):
    fieldsets = (
        ('个人信息', {'fields': ('username', 'email', 'password')}),
        ('权限', {'fields': ('is_active', 'is_staff', 'is_superuser')}),
        ('登录信息', {'fields': ('date_joined', 'last_login',)}),
    )
    list_display = ('username', 'email', 'is_active', 'is_staff', 'is_superuser')
    ordering = ('date_joined',)

    inlines = [
        UserProfileAdmin,
        UserSettingAdmin
    ]


admin.site.register(User, UserAdmin)