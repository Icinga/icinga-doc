#!/bin/bash

cd en-en
[ ! -d html ]&&mkdir html
cd html
xsltproc --xinclude ../../xsl/html-chunked.xsl ../docbook/Icinga.xml

ls *html | while read datei
do
	mv $datei $datei.tmp
	cat $datei.tmp | sed 's/">the section called/">/;s#"../images/#"images/#g' > $datei
	rm $datei.tmp
done
