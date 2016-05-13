<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#x00A0;">
]>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxml="urn:schemas-microsoft-com:xslt"
  xmlns:umbraco.library="urn:umbraco.library"
  xmlns:Exslt.ExsltCommon="urn:Exslt.ExsltCommon"
  xmlns:ViewCount="urn:ViewCount"
  exclude-result-prefixes="msxml umbraco.library Exslt.ExsltCommon ViewCount ">


  <xsl:output method="xml" omit-xml-declaration="yes"/>

  <xsl:param name="currentPage"/>

  <xsl:template match="/">
    <ul>
      <xsl:for-each select="$currentPage//* [@isDoc ]">
        <xsl:sort select="ViewCount:GetViews(number(@id))//@count" order="descending"/>
        <xsl:variable name="counter" select="ViewCount:GetViews(number(@id))" />
        <li>
          Node: <xsl:value-of select="$counter//@nodeId" /><br />
          Count: <xsl:value-of select="$counter//@count" /><br />
          Last Viewed: <xsl:value-of select="$counter//@lastViewed" /><br />
          Category: <xsl:value-of select="$counter//@category" /><br />
          hide Counter: <xsl:value-of select="$counter//@hideCounter" /><br />
          enable History: <xsl:value-of select="$counter//@enableHistory" />
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>

</xsl:stylesheet>