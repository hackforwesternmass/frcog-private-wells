from django.db import models
from django.contrib.auth.models import User
from django.utils.translation import ugettext_lazy as _
from wells.models import Well


class MeasurementType(models.Model):
    name = models.CharField(max_length=100)
    created_on = models.DateTimeField(auto_now_add=True)
    created_by = models.ForeignKey(User, related_name='measurement_type_created_by')
    modified_on = models.DateTimeField(auto_now=True)
    modified_by = models.ForeignKey(User, related_name='measurement_type_modified_by')

    class Meta:
        verbose_name = _('Measurement Type')
        verbose_name_plural = _('Measurement Types')

    def __unicode__(self):
        return self.name


class WaterQuality(models.Model):
    well = models.ForeignKey(Well)
    created_on = models.DateTimeField(auto_now_add=True)
    created_by = models.ForeignKey(User, related_name='water_quality_created_by')
    modified_on = models.DateTimeField(auto_now=True)
    modified_by = models.ForeignKey(User, related_name='water_quality_modified_by')

    class Meta:
        verbose_name = _('Water Quality')
        verbose_name_plural = _('Water Quality')

    def __unicode__(self):
        return self.well


class WaterQualityMeasurement(models.Model):
    measurement_type = models.ForeignKey(MeasurementType)
    water_quality_report = models.ForeignKey(WaterQuality)
    created_on = models.DateTimeField(auto_now_add=True)
    created_by = models.ForeignKey(User, related_name='water_quality_measurement_created_by')
    modified_on = models.DateTimeField(auto_now=True)
    modified_by = models.ForeignKey(User, related_name='water_quality_measurement_modified_by')

    class Meta:
        verbose_name = _('Water Quality')
        verbose_name_plural = _('Water Quality')

    def __unicode__(self):
        return self.well
