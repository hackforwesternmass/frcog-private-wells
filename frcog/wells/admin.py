from django.contrib import admin
from .models import (
    WellType, Well, WellYield,
    WaterQualityReport, WaterQualityMeasurement, WaterQualityMeasurementType
)


class WellAdmin(admin.ModelAdmin):
    list_display = ('dep_well_id', 'well_type', 'municipality', 'latitude', 'longitude')
    list_filter = ['created_on', 'modified_on', 'well_type', 'municipality']
    list_editable = ['well_type', 'municipality']
admin.site.register(Well, WellAdmin)


class WellTypeAdmin(admin.ModelAdmin):
    list_display = ('__unicode__',)
    list_filter = ['created_on', 'modified_on']
admin.site.register(WellType, WellTypeAdmin)


class WellYieldAdmin(admin.ModelAdmin):
    list_display = ('__unicode__', 'date', 'rate', 'well')
    list_filter = ['created_on', 'modified_on', 'date']
    list_editable = ['date', 'rate', 'well']
admin.site.register(WellYield, WellYieldAdmin)

class WaterQualityMeasurementTypeAdmin(admin.ModelAdmin):
    pass
admin.site.register(WaterQualityMeasurementType, WaterQualityMeasurementTypeAdmin)

class WaterQualityMeasurementReportAdminInline(admin.TabularInline):
    model = WaterQualityMeasurement

class WaterQualityReportAdmin(admin.ModelAdmin):
    inlines = [
        WaterQualityMeasurementReportAdminInline
    ]

admin.site.register(WaterQualityReport, WaterQualityReportAdmin)

