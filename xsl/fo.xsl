<?xml version="1.0" encoding="euc-kr"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>
	   

<xsl:import href="fo/docbook.xsl"/>
<xsl:include href="titlepage.xsl"/>

<!-- fop extensions -->
<xsl:param name="use.extensions" select="'1'"></xsl:param>
<xsl:param name="tablecolumns.extension" select="0"></xsl:param>


<xsl:output method="xml" encoding="utf-8"/>


<xsl:param name="paper.type" select="'A4'" />

<xsl:param name="ignore.image.scaling" select="0" />
<xsl:param name="default.image.width" select="200" />

<xsl:param name="admon.graphics" select="'1'" />

</xsl:stylesheet>
