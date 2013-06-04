# Create your views here.
from django.shortcuts import render
from wells.models import Well

def index(request):
    return render(request, 'index.html')

def wells(request):
    template_vars = {}
    template_vars['error'] = ''

    dep_id = None

    if 'dep_id' in request.GET:
        try:
            dep_id = int(request.GET['dep_id'])
        except ValueError:
            template_vars['error'] = '"{0}" is not a valid dep_id'.format(dep_id)

    if dep_id:
        try:
            well = template_vars['well'] = Well.objects.get(dep_well_id=dep_id)
            template_vars['reports'] = well.waterquality_set.all()

        except Well.DoesNotExist:
            template_vars['error'] = 'Well {0} not found'.format(dep_id)

    return render(request, 'wells.html', template_vars)


