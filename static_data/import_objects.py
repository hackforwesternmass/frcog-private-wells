#!/usr/bin/env python

from wells.models import Well, WellType
from municipalities.models import Municipality

import csv

#dataList = list(csv.reader(open("../static_data/welltypes.csv"), delimiter=','))
dataList = list(csv.reader(open("../static_data/hjw.munis.csv"), delimiter=','))

col_names = dataList.pop(0)
col_names = [s.lstrip() for s in col_names]
col_names = [s.rstrip() for s in col_names]


for row in dataList:
  new_type=Municipality()
  for i, field_name in enumerate(col_names):
    new_type.__setattr__(field_name,row[i])
  new_type.save()


