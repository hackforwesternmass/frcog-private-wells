from django.contrib import admin
from .models import MeasurementType, WaterQuality, WaterQualityMeasurement


class MeasurementTypeAdmin(admin.ModelAdmin):
    list_display = ('name',)
    list_filter = ['created_on', 'modified_on']
admin.site.register(MeasurementType, MeasurementTypeAdmin)


class WaterQualityMeasurementAdminInline(admin.TabularInline):
    model = WaterQualityMeasurement

class WaterQualityAdmin(admin.ModelAdmin):
    list_display = ('__unicode__', 'well')
    list_filter = ['created_on', 'modified_on']
    list_editable = ['well']
    inlines = [
        WaterQualityMeasurementAdminInline
    ]

admin.site.register(WaterQuality, WaterQualityAdmin)

