#!/bin/sh
#
# First, set up your environment. I did:
#
# ln -s /work/DocTools/docbook-xsl-1.72.0 \
#    /work/DocTools/XSL/docbook
# export DOCBOOK=/work/DocTools
#
# look at http://opensolaris.org/os/community/documentation/files/makepdf

MAINDIR=$1
BASE=`pwd`
PDFDIR=$BASE/$MAINDIR.PDF
echo $PDFDIR
mkdir $PDFDIR
LOG=$PDFDIR/build.log
touch $LOG
DOCBOOK_ROOT=/home/nagios/docbook/xsl
XSL=$DOCBOOK_ROOT/html/docbook.xsl
XSLTPROC=/usr/bin/xsltproc
FOP=/usr/bin/fop
JAVA_HOME=/usr/java	# Must point to a valid Java 1.5 directory
#export JAVA_HOME

process() {
	if ls *.dtd > /dev/null 2>&1
	then
		INCL=`ls *.dtd`
		echo "DTD for $VOLUME is $INCL" >> $LOG

		if grep DOCTYPE $VOLUME > /dev/null 2>&1
		then
			TYPE=`grep DOCTYPE $VOLUME | cut -d \" -f 2`
			echo $TYPE >> $LOG
#			if grep 5 $TYPE > /dev/null 2>&1
#			then
				XSL=$DOCBOOK_ROOT/fo/docbook.xsl
#			else
#				XSL=$DOCBOOK_ROOT/fo/docbook.xsl
#			fi
		else
			TYPE="-//OASIS//DTD DocBook XML//EN"
			XSL=$DOCBOOK_ROOT/fo/docbook.xsl
		fi
		xmlcatalog --noout --create catalog
		xmlcatalog --noout --add 'public' '$TYPE' 'file://work/DocTools/$MAINDIR/$BOOK/$INCL' catalog
		SGML_CATALOG_FILES=$DOCBOOK_ROOT/$MAINDIR/$BOOK/catalog
		export SGML_CATALOG_FILES
		echo "Assigned SGML_CATALOG_FILES" >> $LOG
#		TYPE=`grep DOCTYPE $VOLUME | sed -e 's/\//_/g' | cut -d "_" -f 5`
		$XSLTPROC $XSL --catalogs $INCL --xinclude $VOLUME > $BOOK.fo
		$FOP $BOOK.fo -pdf $PDFDIR/$BOOK.pdf
	else
		echo "DTD for $VOLUME is null" >> $LOG
#		TYPE=`grep DOCTYPE $VOLUME | cut -d \" -f 2`
		TYPE=`grep DOCTYPE $VOLUME | cut -d " " -f 2`
#		if grep 5 $TYPE > /dev/null 2>&1
#		then
			XSL=$DOCBOOK_ROOT/fo/docbook.xsl
#		else
#			XSL=$DOCBOOK_ROOT/fo/docbook.xsl
#		fi
		xmlcatalog --noout --create catalog
		xmlcatalog --noout --add 'public' '$TYPE' catalog
		SGML_CATALOG_FILES=$DOCBOOK_ROOT/$MAINDIR/$BOOK/catalog
		export SGML_CATALOG_FILES
#		TYPE=`grep DOCTYPE $VOLUME | sed -e 's/\//_/g' | cut -d "_" -f 5`
		echo $TYPE >> $LOG
#		$XSLTPROC $XSL --catalogs --xinclude $VOLUME > $BOOK.fo
		$XSLTPROC $XSL --xinclude $VOLUME > $BOOK.fo
		$FOP $BOOK.fo -pdf $PDFDIR/$BOOK.pdf
	fi
	echo "Finished $BOOK" >> $LOG
	}

cd $MAINDIR
for BOOK in `ls`
do
	if [ -d $BOOK ]; then
		cd $BOOK
		echo "Current book is $BOOK" >> $LOG
		if ls $BOOK.xml > /dev/null 2>&1
		then
			VOLUME=$BOOK.xml
			echo "Volume is $VOLUME" >> $LOG
			process $VOLUME
		elif ls $BOOK.book > /dev/null 2>&1
		then
			VOLUME=$BOOK.book
			echo "Volume is $VOLUME" >> $LOG
			process $VOLUME
		else
			echo "What is the master book for $BOOK?" >> $LOG
		fi
		cd ..
	fi
done

