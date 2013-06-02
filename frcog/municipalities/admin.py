from django.contrib import admin
from .models import Municipality


class MunicipalityAdmin(admin.ModelAdmin):
    list_display = ('__unicode__',)
    list_filter = ['created_on', 'modified_on']
admin.site.register(Municipality, MunicipalityAdmin)

