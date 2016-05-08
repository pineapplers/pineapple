from django.contrib import admin
from .models import Province, City


# Register your models here.
class CityAdmin(admin.TabularInline):
    model = City


class ProvinceAdmin(admin.ModelAdmin):
    model = Province

    inlines = [
        CityAdmin,
    ]


admin.site.register(Province, ProvinceAdmin)