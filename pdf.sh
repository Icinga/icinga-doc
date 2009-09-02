#!/bin/bash

[ ! -d pdf ]&&mkdir pdf
cd en-en/Icinga
ls *xml | while read datei
do
	DATEI=${datei%%.xml}
	xsltproc --xinclude ../../xsl/fo/docbook.xsl $DATEI.xml > ../../pdf/$DATEI.fo
done
exit 0

ls *html | while read datei
do
	mv $datei $datei.tmp
	cat $datei.tmp | sed 's/">the section called/">/' > $datei
	rm $datei.tmp
done
