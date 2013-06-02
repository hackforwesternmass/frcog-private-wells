from django.contrib import admin
from .models import Municipality


class MunicipalityAdmin(admin.ModelAdmin):
    list_display = ('__unicode__',)
    list_filter = ['created_on', 'modified_on']
    exclude = ['created_by', 'modified_by']

    def save_model(self, request, obj, form, change):
        if not change:
            obj.created_by = request.user
            obj.modified_by = request.user
            obj.save()
admin.site.register(Municipality, MunicipalityAdmin)

