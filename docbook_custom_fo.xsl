<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook" xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">

  <!--
    Pfad-Anpassung an die oXygen-Installation
    Windows: file:///C:/Program Files/Oxygen XML Editor 2x/...
    macOS:   file:///Applications/Oxygen XML Editor/...
  -->
  <xsl:import href="file:///C:/Program Files/Oxygen XML Editor 24/frameworks/docbook/xsl/fo/profile-docbook.xsl"/>
  <xsl:import href="file:///C:/Program Files/Oxygen XML Editor 24/frameworks/docbook/xsl/fo/highlight.xsl"/>
  <xsl:import href="docbook_custom_lists_fo.xsl"/> <!-- darin Anpassungen für d:result -->

  <xsl:template name="graphical.admonition">
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>

    <fo:block id="{$id}" xsl:use-attribute-sets="graphical.admonition.properties">
      <fo:list-block provisional-distance-between-starts="18pt" provisional-label-separation="18pt">
        <fo:list-item>
          <fo:list-item-label end-indent="label-end()">
            <fo:block>
              <fo:external-graphic width="auto" height="auto">
                <xsl:attribute name="src">
                  <xsl:call-template name="admon.graphic"/>
                </xsl:attribute>
              </fo:external-graphic>
            </fo:block>
          </fo:list-item-label>
          <fo:list-item-body start-indent="body-start()">
            <xsl:if test="$admon.textlabel != 0 or d:title or d:info/d:title">
              <fo:block xsl:use-attribute-sets="admonition.title.properties">
                <xsl:apply-templates select="." mode="object.title.markup">
                  <xsl:with-param name="allow-anchors" select="1"/>
                </xsl:apply-templates>
              </fo:block>
            </xsl:if>
            <fo:block xsl:use-attribute-sets="admonition.properties">
              <xsl:apply-templates/>
            </fo:block>
          </fo:list-item-body>
        </fo:list-item>
      </fo:list-block>
    </fo:block>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- Folgende Anpassungen by T. Meinike 04/22 -->

  <!-- result-Element wird in oXygen nicht gerendert | ergänzt: Haken + result-Text -->
  <xsl:template match="d:result">
    <fo:block xsl:use-attribute-sets="normal.para.spacing">
      <fo:inline color="#009900" font-weight="bold" vertical-align="top" padding-right="2pt">&#x2713;</fo:inline> <!-- &#x2713; = Haken | &#x21D2; = Doppelpfeil -->
      <!--<xsl:value-of select="d:para[not(@role='infobox')]"/>-->
      <xsl:if test="d:para[not(@role='infobox')]">
        <xsl:choose>
          <xsl:when test="d:para/d:emphasis[not(@role)] or d:para/d:emphasis[@role='italic']">
            <fo:inline font-style="italic">
              <xsl:value-of select="d:para/d:emphasis"/>
            </fo:inline>
          </xsl:when>
          <xsl:when test="d:para/d:emphasis[@role='bold']">
            <fo:inline font-weight="bold">
              <xsl:value-of select="d:para/d:emphasis"/>
            </fo:inline>
          </xsl:when>
          <xsl:otherwise>
            <fo:inline>
              <xsl:value-of select="d:para"/>
            </fo:inline>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
      <xsl:apply-templates select="d:para[@role='infobox']"/>
      <xsl:apply-templates select="d:mediaobject"/> <!-- Nachtrag, evtl. folgen noch Bilder -->
    </fo:block>
  </xsl:template>

  <!-- globales result-Element nach den step-Elementen -->
  <xsl:template match="d:result[preceding-sibling::d:step]"> <!-- war #009900 -->
    <fo:block xsl:use-attribute-sets="normal.para.spacing">
      <fo:inline color="#0000CC" font-weight="bold" vertical-align="top" padding-right="2pt">&#x21D2;</fo:inline> <!-- &#x2713; = Haken | &#x21D2; = Doppelpfeil -->
      <!--<xsl:value-of select="d:para[not(@role='infobox')]"/>-->
      <xsl:if test="d:para[not(@role='infobox')]">
        <xsl:choose>
          <xsl:when test="d:para/d:emphasis[not(@role)] or d:para/d:emphasis[@role='italic']">
            <fo:inline font-style="italic">
              <xsl:value-of select="d:para/d:emphasis"/>
            </fo:inline>
          </xsl:when>
          <xsl:when test="d:para/d:emphasis[@role='bold']">
            <fo:inline font-weight="bold">
              <xsl:value-of select="d:para/d:emphasis"/>
            </fo:inline>
          </xsl:when>
          <xsl:otherwise>
            <fo:inline>
              <xsl:value-of select="d:para"/>
            </fo:inline>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
      <xsl:apply-templates select="d:para[@role='infobox']"/>
      <xsl:apply-templates select="d:mediaobject"/> <!-- Nachtrag, evtl. folgen noch Bilder -->
    </fo:block>
  </xsl:template>

  <!-- para mit role="infobox soll grauen Hintergrund und mit rotem i im Kreis beginnen -->
  <xsl:template match="d:para[@role='infobox']">
    <fo:block color="black" background-color="#EEEEEE" font-size="8pt" padding="3pt" margin-left="2pt" margin-right="3cm" xsl:use-attribute-sets="normal.para.spacing">
      <fo:inline color="#CC0000" padding-right="3pt" font-weight="bold">&#x24D8;</fo:inline>
      <!--<xsl:value-of select="."/>-->
      <xsl:choose>
        <xsl:when test="d:emphasis[not(@role)] or d:emphasis[@role='italic']">
          <fo:inline font-style="italic">
            <xsl:value-of select="d:emphasis"/>
          </fo:inline>
        </xsl:when>
        <xsl:when test="d:emphasis[@role='bold']">
          <fo:inline font-weight="bold">
            <xsl:value-of select="d:emphasis"/>
          </fo:inline>
        </xsl:when>
        <xsl:otherwise>
          <fo:inline>
            <xsl:value-of select="d:para"/>
          </fo:inline>
        </xsl:otherwise>
      </xsl:choose>
    </fo:block>
  </xsl:template>

  <!-- remark-Element wird in oXygen nicht gerendert | "Anmerkung: " + remark-Text -->
  <xsl:template match="d:remark">
    <fo:block font-style="italic" color="black" xsl:use-attribute-sets="normal.para.spacing">
      <xsl:value-of select="concat('Anmerkung: ', .)"/>
    </fo:block>
  </xsl:template>

  <!-- Kapitel-Titel in Abhängigkeit von der Standardgröße 10pt -->
  <xsl:attribute-set name="component.title.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="concat($body.font.master * 2, 'pt')"/>
    </xsl:attribute>
    <xsl:attribute name="color">#CC0000</xsl:attribute>
  </xsl:attribute-set>

  <!-- Abschnitts-Titel Level 1 in Abhängigkeit von der Standardgröße 10pt -->
  <xsl:attribute-set name="section.title.level1.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="concat($body.font.master * 1.5, 'pt')"/>
    </xsl:attribute>
    <xsl:attribute name="margin-top">0.75cm</xsl:attribute>
    <xsl:attribute name="color">#009900</xsl:attribute>
  </xsl:attribute-set>

  <!-- Abschnitts-Titel Level 2 in Abhängigkeit von der Standardgröße 10pt -->
  <xsl:attribute-set name="section.title.level2.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="concat($body.font.master * 1.2, 'pt')"/>
    </xsl:attribute>
    <xsl:attribute name="margin-top">0.75cm</xsl:attribute>
    <xsl:attribute name="color">#0000CC</xsl:attribute>
  </xsl:attribute-set>

  <!-- Abschnitts-Titel Level 3 in Abhängigkeit von der Standardgröße 10pt -->
  <xsl:attribute-set name="section.title.level3.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="concat($body.font.master * 1.1, 'pt')"/>
    </xsl:attribute>
    <xsl:attribute name="margin-top">0.75cm</xsl:attribute>
    <xsl:attribute name="color">#0099FF</xsl:attribute>
  </xsl:attribute-set>

  <!-- Unterschriften mit zugehörigem Objekt zusammenhalten (z. B. imageobject + caption) -->
  <!-- Codebasis: https://lists.oasis-open.org/archives/docbook-apps/201112/msg00002.html -->
  <xsl:template match="d:caption">
    <fo:block keep-with-previous.within-column="always" keep-together.within-column="always">
      <xsl:if test="@align = 'right' or @align = 'left' or @align = 'center'">
        <xsl:attribute name="text-align">
          <xsl:value-of select="@align"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!-- rote Tabellenzellen mit weißer Schrift, wenn <thead role="redhead"> gesetzt ist -->
  <xsl:template name="table.cell.block.properties">
    <xsl:if test="ancestor::d:thead[@role = 'redhead']">
      <xsl:attribute name="color">#FFF</xsl:attribute>
      <xsl:attribute name="background-color">#FF0000</xsl:attribute>
      <xsl:attribute name="font-family">sans-serif</xsl:attribute>
      <xsl:attribute name="font-weight">bold</xsl:attribute>
      <xsl:attribute name="margin">0</xsl:attribute>
      <xsl:attribute name="padding">0</xsl:attribute>
    </xsl:if>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->

</xsl:stylesheet>