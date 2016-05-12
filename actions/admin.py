from django.contrib import admin

from .models import Action

# Register your models here.
class ActionAdmin(admin.ModelAdmin):
    model = Action


admin.site.register(Action, ActionAdmin)
