from django.conf.urls import patterns, include, url

urlpatterns = patterns('',
    url(r'^$', 'wells.views.index'),
    url(r'^wells/$', 'wells.views.wells'),
)
