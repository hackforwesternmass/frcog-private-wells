from django.contrib import admin
from .models import MeasurementType, WaterQuality, WaterQualityMeasurement


class MeasurementTypeAdmin(admin.ModelAdmin):
    list_display = ('name',)
    list_filter = ['created_on', 'modified_on']

    exclude = ['created_by', 'modified_by']

    def save_model(self, request, obj, form, change):
        if not change:
            obj.created_by = request.user

        obj.modified_by = request.user
        obj.save()

admin.site.register(MeasurementType, MeasurementTypeAdmin)


class WaterQualityMeasurementAdminInline(admin.TabularInline):
    model = WaterQualityMeasurement

class WaterQualityAdmin(admin.ModelAdmin):
    list_display = ('__unicode__', 'well')
    list_filter = ['created_on', 'modified_on']
    list_editable = ['well']
    exclude = ['created_by', 'modified_by']
    inlines = [
        WaterQualityMeasurementAdminInline
    ]

    def save_model(self, request, obj, form, change):
        if not change:
            obj.created_by = request.user

        obj.modified_by = request.user
        obj.save()

admin.site.register(WaterQuality, WaterQualityAdmin)

