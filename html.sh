#!/bin/bash +x

LANG=$1
[ -z "$LANG" ] && exit 99
shift
DIR=html/docs
numbers=""
files="*"
while getopts "f:n" options $OPTS; do
	case $options in
		n)
			numbers='	--stringparam chapter.autolabel 1
				--stringparam section.autolabel 1 
				--stringparam section.label.includes.component.label 1'
		;;
		f)
			files=$OPTARG
		;;
	esac
done

[ ! -d $DIR/$LANG ] && mkdir -p $DIR/$LANG
cd $DIR
rm $LANG/$files.html

if [ "$files" = '*' ]; then
	xsltproc \
   $numbers \
	--xinclude ../../xsl/html-chunked.xsl \
	../../$LANG/Icinga.xml
else
	xsltproc \
   $numbers \
	--xinclude ../../xsl/html-chunked.xsl \
	../../$LANG/$files.xml
fi
cd $LANG
ls $files.html | while read datei
do
	mv $datei $datei.tmp
	cat $datei.tmp | sed '/class="book"/d;/class="section" title=/d' > $datei
	rm $datei.tmp
done
