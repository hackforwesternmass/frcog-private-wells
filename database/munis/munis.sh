#!/bin/sh

while read p; do
	echo "INSERT INTO municipalities(name, created_by,modified_by) VALUES ('$p',1,1);" >> ../munis.sql
done < municipalities.txt
