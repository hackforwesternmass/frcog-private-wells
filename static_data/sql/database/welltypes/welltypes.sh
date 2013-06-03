#!/bin/sh

while read p; do
	echo "INSERT INTO wells_types(name, created_by, modified_by) VALUES ('$p',1,1);" >> ../welltypes.sql
done < welltypes.txt
