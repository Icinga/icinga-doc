<?xml version="1.0" encoding="euc-kr"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>
	   
<!-- <xsl:import href="http://docbook.sourceforge.net/release/xsl/current/xhtml/chunk.xsl"/> -->

<!-- <xsl:import href="dbk-html-common.xsl"/> -->
<xsl:import href="html/chunk.xsl"/>

<xsl:output method="xml" encoding="utf-8"/>

<!-- encoding (utf8) -->
<xsl:param name="chunker.output.encoding" select="'utf-8'"/>

<xsl:param name="chunk.first.sections" select="'1'"/>

<!-- <xsl:param name="email.nospam" select="'1'"/> -->

<!-- chapter/section ids as filenames -->
<xsl:param name="use.id.as.filename" select="'1'"/>

<!-- images for note, tip, warning,caution and important -->
<xsl:param name="admon.graphics.path">../images/</xsl:param>
<xsl:param name="admon.graphics" select="'1'"/>

<!-- nice navigation icons in header and footer -->
<!-- <xsl:param name="navig.graphics" select="'1'"/> -->

<!-- nicer html output... not all on one line -->
<xsl:param name="chunker.output.indent" select="'yes'"/>

<!-- CSS Stylesheet -->
<xsl:param name="html.stylesheet" select="'../stylesheets/icinga-docs.css'" />

<!-- Hendrik: Copyright Information on each page -->

<xsl:template name="user.header.navigation">
<CENTER><IMG src="../images/logofullsize.png" border="0" alt="Icinga" title="Icinga"/></CENTER>
</xsl:template>

<!-- toc 2 deep -->
<xsl:param name="toc.section.depth">2</xsl:param>

<!-- section numbering -->
<xsl:param name="section.autolabel">1</xsl:param>
<xsl:param name="section.label.includes.component.label">1</xsl:param>


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
  <HR/><P class="copyright">&#x00A9; 2009-2012 Icinga Development Team, http://www.icinga.org</P>
</xsl:template>
-->
<xsl:template name="user.footer.navigation">
  <P class="copyright">&#x00A9; 2009-2012 Icinga Development Team, http://www.icinga.org</P>
</xsl:template>

</xsl:stylesheet>
