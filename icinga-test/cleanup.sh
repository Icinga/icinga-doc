ls *html | while read datei
do
	mv $datei $datei.tmp
	cat $datei.tmp | sed 's/">the section called/">/' > $datei
	rm $datei.tmp
done
