from django.db import models
from django.contrib.auth.models import User
from django.utils.translation import ugettext_lazy as _
from django.contrib.localflavor.us.us_states import US_STATES

from municipalities.models import Municipality


class WellType(models.Model):
    name = models.CharField(max_length=100)
    created_on = models.DateTimeField(auto_now_add=True)
    created_by = models.ForeignKey(User, related_name='well_type_created_by')
    modified_on = models.DateTimeField(auto_now=True)
    modified_by = models.ForeignKey(User, related_name='well_type_modified_by')

    class Meta:
        db_table = 'wells_types'
        verbose_name = _('Well Type')
        verbose_name_plural = _('Well Types')

    def __unicode__(self):
        return self.name


class Well(models.Model):
    dep_well_id = models.IntegerField()
    owner_name = models.CharField(max_length=100, blank=True)
    owner_street_1 = models.CharField(max_length=100, blank=True)
    owner_street_2 = models.CharField(max_length=100, blank=True)
    owner_city = models.CharField(max_length=100, blank=True)
    owner_state = models.CharField(max_length=2, choices=US_STATES, default='MA', blank=True)
    owner_zip = models.CharField(max_length=10, blank=True)
    well_street_1 = models.CharField(max_length=100, blank=True)
    well_street_2 = models.CharField(max_length=100, blank=True)
    latitude = models.DecimalField(max_digits=11, decimal_places=6)
    longitude = models.DecimalField(max_digits=11, decimal_places=6)
    total_depth = models.IntegerField()
    depth_to_bedrock = models.IntegerField()
    assessors_map = models.CharField(max_length=10, blank=True)
    assessors_lot = models.CharField(max_length=10, blank=True)
    boh_date_issued = models.DateField(null=True, blank=True)
    boh_permit = models.CharField(max_length=10, blank=True)
    comments = models.TextField(blank=True)
    wc_date = models.DateField(null=True, blank=True)
    firm = models.CharField(max_length=100, blank=True)
    supervising_driller = models.CharField(max_length=100, blank=True)
    field_notes = models.TextField(blank=True)
    municipality = models.ForeignKey(Municipality, db_column='municipalities_id')
    well_type = models.ForeignKey(WellType, db_column='well_types_id')
    created_on = models.DateTimeField(auto_now_add=True, db_column='created_on_id')
    created_by = models.ForeignKey(User, related_name='well_created_by')
    modified_on = models.DateTimeField(auto_now=True, db_column='modified_on_id')
    modified_by = models.ForeignKey(User, related_name='well_modified_by')

    class Meta:
        db_table = 'wells'
        verbose_name = _('Well')
        verbose_name_plural = _('Wells')

    def __unicode__(self):
        return unicode(self.dep_well_id)


class WellYield(models.Model):
    date = models.DateField(blank=True, null=True)
    rate = models.FloatField()
    description = models.TextField()
    well = models.ForeignKey('Well')
    created_on = models.DateTimeField(auto_now_add=True)
    created_by = models.ForeignKey(User, related_name='well_yield_created_by')
    modified_on = models.DateTimeField(auto_now=True)
    modified_by = models.ForeignKey(User, related_name='well_yield_modified_by')

    class Meta:
        db_table = 'wells_yields'
        verbose_name = _('Well Yield')
        verbose_name_plural = _('Well Yields')

    def __unicode__(self):
        return '%s: %s - %s' % (self.well, self.date, self.rate)


class WaterQualityReport(models.Model):
    well = models.ForeignKey('Well')
    date = models.DateField()

    class Meta:
      db_table = 'water_quality_reports'

    def __unicode__(self):
        return '%s - %s' % (self.well, self.date)

class WaterQualityMeasurementType(models.Model):
    name = models.CharField(max_length=100)

    class Meta:
      db_table = 'measurements_types'
      
    def __unicode__(self):
        return unicode(self.name)

class WaterQualityMeasurement(models.Model):
    quality_report = models.ForeignKey('WaterQualityReport')
    measurement_type = models.ForeignKey('WaterQualityMeasurementType')
    value = models.CharField(max_length=100) # Could be int or string, this is just the easiest for right now
    class Meta:
      db_table = 'water_quality_reports_measurements'
