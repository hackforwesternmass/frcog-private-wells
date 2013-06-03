from django.db import models
from django.contrib.auth.models import User
from django.utils.translation import ugettext_lazy as _


class Municipality(models.Model):
    name = models.CharField(max_length=100)
    created_on = models.DateTimeField(auto_now_add=True)
    created_by = models.ForeignKey(User, related_name='municiplaity_created_by', db_column='created_by')
    modified_on = models.DateTimeField(auto_now=True)
    modified_by = models.ForeignKey(User, related_name='municiplaity_modified_by', db_column='modified_by')

    class Meta:
        db_table = 'municipalities'
        verbose_name = _('Municipality')
        verbose_name_plural = _('Municipalities')

    def __unicode__(self):
        return self.name
