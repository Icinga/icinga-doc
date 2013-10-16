<?xml version="1.0" encoding="euc-kr"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>
	   
<xsl:import href="html/chunk.xsl"/>

<xsl:output method="xml" encoding="utf-8"/>

<!-- include our javascript -->
<xsl:template name="user.head.content">
	<script src="../js/jquery-min.js" type="text/javascript"></script>
	<script src="../js/icinga-docs.js" type="text/javascript"></script>
</xsl:template>

<!-- copyright information on each page -->
<xsl:template name="user.header.navigation">
<CENTER><IMG src="../images/logofullsize.png" border="0" alt="Icinga" title="Icinga"/></CENTER>
</xsl:template>

<!-- css stylesheet -->
<xsl:param name="html.stylesheet" select="'../stylesheets/icinga-docs.css'" />

<!-- encoding (utf8) -->
<xsl:param name="chunker.output.encoding" select="'utf-8'"/>

<xsl:param name="chunk.first.sections" select="'1'"/>

<!-- chapter/section ids as filenames -->
<xsl:param name="use.id.as.filename" select="'1'"/>

<!-- images for note, tip, warning,caution and important -->
<xsl:param name="admon.graphics.path">../images/</xsl:param>
<xsl:param name="admon.graphics" select="'1'"/>

<!-- nicer html output... not all on one line -->
<xsl:param name="chunker.output.indent" select="'yes'"/>

<!-- do not wrap url into number labels -->
<xsl:param name="autotoc.label.in.hyperlink" select="0"/>

<!-- toc 2 deep -->
<xsl:param name="toc.section.depth">2</xsl:param>

<!-- section toc 2 deep -->
<xsl:param name="generate.section.toc.level">2</xsl:param>

<!-- section numbering -->
<xsl:param name="section.autolabel">1</xsl:param>
<xsl:param name="section.label.includes.component.label">1</xsl:param>

<!-- define some types -->
<xsl:param name="html.script"/>
<xsl:param name="html.script.type">text/javascript</xsl:param>
<xsl:param name="html.stylesheet"/>
<xsl:param name="html.stylesheet.type">text/css</xsl:param>

<!-- don't use any extensions -->
<xsl:param name="use.extensions" select="0"/>


<!-- change display of some elements -->
<xsl:template match="productname">
	<xsl:call-template name="inline.charseq"/>
</xsl:template>
<xsl:template match="structfield">
	<xsl:call-template name="inline.monoseq"/>
</xsl:template>
<xsl:template match="structname">
	<xsl:call-template name="inline.monoseq"/>
</xsl:template>
<xsl:template match="symbol">
	<xsl:call-template name="inline.monoseq"/>
</xsl:template>
<xsl:template match="systemitem">
	<xsl:call-template name="inline.charseq"/>
</xsl:template>
<xsl:template match="token">
	<xsl:call-template name="inline.monoseq"/>
</xsl:template>
<xsl:template match="type">
	<xsl:call-template name="inline.monoseq"/>
</xsl:template>
<xsl:template match="programlisting/emphasis">
	<xsl:call-template name="inline.boldseq"/>
</xsl:template>

<!--
<xsl:template name="user.footer.content">
  <HR/><P class="copyright">&#x00A9; 2009-2013 Icinga Development Team, http://www.icinga.org</P>
</xsl:template>
-->
<xsl:template name="user.footer.navigation">
  <P class="copyright">&#x00A9; 1999-2009 Ethan Galstad, 2009-2013 Icinga Development Team, http://www.icinga.org</P>
</xsl:template>

</xsl:stylesheet>
