!/bin/bash


[ ! -d html ]&&mkdir html
cd html
xsltproc --xinclude ../xsl/html-chunked.xsl ../en-de/Icinga.xml

ls *html | while read datei
do
	mv $datei $datei.tmp
	cat $datei.tmp | sed 's/">the section called/">/;"' > $datei
	rm $datei.tmp
done
