

all:
	@echo ""
	@echo "Please type what you want"
	@echo "make en-en"
	@echo ""

wn:
	xsltproc --xinclude ../../xsl/html-chunked.xsl Icinga.xml

en-pdf:
	xsltproc --xinclude -o ../Icinga.fo ../../xsl/fo.xsl ./Icinga.xml
	fop ../Icinga.fo ../../Icinga-en.pdf
	rm -f ../Icinga.fo

