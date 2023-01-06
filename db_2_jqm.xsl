<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fn="http://www.w3.org/2005/xpath-functions"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns="http://www.w3.org/1999/xhtml"
  xpath-default-namespace="http://docbook.org/ns/docbook"
  exclude-result-prefixes="#all">

  <!-- Umsetzung einer jQuery-Mobile-Ausgabe einer Anleitung via DocBook | by T. Meinike 11/19 … 10/22 -->

  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>

  <!-- Vorgaben -->
  <xsl:variable name="maintitle" select="fn:normalize-space(/book/title)" as="xs:string"/>
  <xsl:variable name="webapptitle" select="fn:normalize-space(/book/titleabbrev)" as="xs:string"/>
  <xsl:variable name="header" select="fn:normalize-space(/book/subtitle)" as="xs:string"/>
  <xsl:variable name="footer" select="/book/info/abstract/simpara" as="xs:string"/>
  <xsl:variable name="webappicon" select="'bookicon.png'" as="xs:string"/>
  <xsl:variable name="stylesheet" select="'custom_jqm.css'" as="xs:string"/>
  <xsl:variable name="javascript" select="'custom_jqm.js'" as="xs:string"/>
  <xsl:variable name="cachemanifest" select="'cache.manifest'" as="xs:string"/>
  <xsl:variable name="webmanifest" select="'manifest.webmanifest'" as="xs:string"/>
  <xsl:variable name="description" select="fn:concat('Mobile Web-Anwendung zu ', $webapptitle)" as="xs:string"/>
  <xsl:variable name="logoimage" select="/book/title/inlinemediaobject/imageobject/imagedata/@fileref" as="xs:string"/>
  <xsl:variable name="keywords" select="fn:count(/book//indexterm)" as="xs:integer"/>
  <xsl:variable name="iconsize" select="'192x192'" as="xs:string"/>
  <xsl:variable name="lf" select="'&#xA;'" as="xs:string"/> <!-- Zeilenumbruch ASCII 10 (line feed) -->

  <!-- jQM-Ressourcen offline -->
  <xsl:variable name="jqm_css" select="'jqm/jquery.mobile-1.4.5.min.css'" as="xs:string"/>
  <xsl:variable name="jqm_js" select="'jqm/jquery.mobile-1.4.5.min.js'" as="xs:string"/>
  <xsl:variable name="jquery" select="'jqm/jquery-1.12.4.min.js'" as="xs:string"/>

  <!-- jQM-Ressourcen online -->
  <!--<xsl:variable name="jqm_css" select="'https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css'" as="xs:string"/>
  <xsl:variable name="jqm_js" select="'https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js'" as="xs:string"/>
  <xsl:variable name="jquery" select="'https://code.jquery.com/jquery-1.12.4.min.js'" as="xs:string"/>-->

  <!-- Haupttemplate -->
  <xsl:template match="book">
    <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;&#xA;</xsl:text>

    <!-- HTML-Singlepage -->
    <html lang="de" manifest="{$cachemanifest}">
      <head>
        <meta charset="UTF-8"/>
        <meta name="generator" content="db_2_jqm.xsl"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <meta name="description" content="{$description}"/>
        <meta name="mobile-web-app-capable" content="yes"/>
        <meta name="apple-mobile-web-app-capable" content="yes"/>
        <meta name="apple-mobile-web-app-title" content="{$webapptitle}"/>
        <meta name="apple-mobile-web-app-status-bar-style" content="black"/> <!-- default | black | black-translucent -->
        <meta name="application-name" content="{$webapptitle}"/>
        <meta name="theme-color" content="black"/>
        <link rel="icon" sizes="{$iconsize}" href="{$webappicon}"/>
        <link rel="apple-touch-icon" href="{$webappicon}"/>
        <link rel="apple-touch-startup-image" href="{$logoimage}"/>
        <link rel="manifest" href="{$webmanifest}"/>
        <link rel="stylesheet" href="{$stylesheet}" type="text/css"/>
        <style type="text/css"><xsl:text disable-output-escaping="yes">nav[data-role="navbar"] > ul > li { width: </xsl:text><xsl:value-of select="fn:substring(xs:string(100 div fn:count(//chapter)), 1, 5)"/><xsl:text disable-output-escaping="yes">% !important; clear: none !important; }</xsl:text></style>
        <!-- jQM -->
        <xsl:value-of select="fn:concat($lf,
          '      &lt;link rel=&quot;stylesheet&quot; href=&quot;', $jqm_css, '&quot; type=&quot;text/css&quot;/&gt;')" disable-output-escaping="yes"/>
        <xsl:value-of select="fn:concat($lf,
          '      &lt;script src=&quot;', $jquery, '&quot; type=&quot;text/javascript&quot;&gt;&lt;/script&gt;')" disable-output-escaping="yes"/>
        <xsl:value-of select="fn:concat($lf,
          '      &lt;script src=&quot;', $javascript, '&quot; type=&quot;text/javascript&quot;&gt;&lt;/script&gt;')" disable-output-escaping="yes"/>
        <xsl:value-of select="fn:concat($lf,
          '      &lt;script src=&quot;', $jqm_js, '&quot; type=&quot;text/javascript&quot;&gt;&lt;/script&gt;', $lf, '      ')" disable-output-escaping="yes"/>
        <!-- /jQM -->
        <xsl:value-of select="fn:concat('&lt;!--[if IE]&gt;&lt;meta http-equiv=&quot;X-UA-Compatible&quot; content=&quot;IE=edge&quot;/>&lt;![endif]--&gt;', $lf, '      ')" disable-output-escaping="yes"/>
        <title><xsl:value-of select="$header"/></title>
      </head>
      <body>
        <!-- jQM-Startseite -->
        <article data-role="page" id="start" data-title="Inhaltsverzeichnis">

          <!-- Header-Bereich -->
          <header data-role="header" data-position="fixed" data-tap-toggle="false" data-hide-during-focus="false" data-theme="b">
            <h1><xsl:value-of select="$header"/></h1>
            <a class="ui-btn ui-btn-active ui-icon-home ui-btn-icon-left ui-corner-all">Start</a>
            <a href="#info" class="ui-btn ui-icon-info ui-btn-icon-left ui-corner-all">Info</a>
            <nav data-role="navbar" data-iconpos="top">
              <ul>
                <xsl:for-each select="chapter">
                  <xsl:variable name="pos" select="fn:position()" as="xs:integer"/>
                  <li>
                    <a href="#kap{$pos}" data-icon="action"><xsl:value-of select="title"/></a> 
                    <!--Alt: <a href="#kap{$pos}" data-icon="action"><xsl:value-of select="fn:concat('Kapitel ', $pos)"/></a>-->
                  </li>
                </xsl:for-each>
              </ul>
            </nav>
          </header>
          <!-- /Header-Bereich -->

          <!-- Main-Bereich -->
          <main data-role="main" class="ui-content">
            <div id="logo">
              <xsl:if test="$maintitle != ''">
                <h1><xsl:value-of select="$maintitle"/></h1>
              </xsl:if>
              <p>
                <img src="{$logoimage}" alt="{$webapptitle}-Logo"/>
              </p>
            </div>
            <h2>Inhaltsverzeichnis</h2>
            <ul data-role="listview" data-inset="true">
              <xsl:for-each select="chapter">
                <xsl:variable name="chapos" select="fn:position()" as="xs:integer"/>
                <li>
                  <a href="#kap{$chapos}"><xsl:value-of select="fn:concat('Kapitel ', $chapos, ': ', title)"/></a>
                </li>
              </xsl:for-each>
              <xsl:if test="$keywords > 0">
                <li>
                  <a href="#index">Stichwortverzeichnis</a>
                </li>
              </xsl:if>
            </ul>
          </main>
          <!-- /Main-Bereich -->

          <!-- Footer-Bereich -->
          <footer data-role="footer" data-position="fixed" data-tap-toggle="false" data-hide-during-focus="false" data-theme="b">
            <h1><xsl:value-of select="$footer"/></h1>
          </footer>
          <!-- /Footer-Bereich -->

        </article>
        <!-- /jQM-Startseite -->

        <!-- jQM-Infoseite -->
        <article data-role="page" id="info" data-title="Informationen">

          <!-- Header-Bereich -->
          <header data-role="header" data-position="fixed" data-tap-toggle="false" data-hide-during-focus="false" data-theme="b">
            <h1><xsl:value-of select="$header"/></h1>
            <a href="#start" class="ui-btn ui-icon-home ui-btn-icon-left ui-corner-all">Start</a>
            <a class="ui-btn ui-btn-active ui-icon-info ui-btn-icon-left ui-corner-all">Info</a>
            <nav data-role="navbar" data-iconpos="top">
              <ul>
                <xsl:for-each select="chapter">
                  <xsl:variable name="pos" select="fn:position()" as="xs:integer"/>
                  <li>
                    <a href="#kap{$pos}" data-icon="action"><xsl:value-of select="title"/></a>
                    <!--Alt: fn:concat('Kapitel ', $pos)-->
                  </li>
                </xsl:for-each>
              </ul>
            </nav>
          </header>
          <!-- /Header-Bereich -->

          <!-- Main-Bereich -->
          <main data-role="main" class="ui-content">
            <h2>Impressum</h2>
            <h3>Material und Umsetzung</h3>
            <xsl:if test="info/abstract/para">
              <p><xsl:value-of select="info/abstract/para"/></p>
            </xsl:if>
            <xsl:if test="info/author/orgname">
              <p><xsl:value-of select="info/author/orgname"/></p>
            </xsl:if>
            <xsl:if test="info/copyright/year and info/copyright/holder">
              <p><xsl:value-of select="fn:concat('© ', info/copyright/year, ' ', info/copyright/holder)"/></p>
            </xsl:if>
            <h3>Kontakt</h3>
            <xsl:if test="fn:count(info/address/*) > 0">
              <address>
                <xsl:if test="info/address/orgname[1]">
                  <p><xsl:value-of select="info/address/orgname[1]"/></p>
                </xsl:if>
                <xsl:if test="info/address/orgname[2]">
                  <p><xsl:value-of select="info/address/orgname[2]"/></p>
                </xsl:if>
                <xsl:if test="info/address/personname">
                  <p><xsl:value-of select="info/address/personname"/></p>
                </xsl:if>
                <xsl:if test="info/address/street">
                  <p><xsl:value-of select="info/address/street"/></p>
                </xsl:if>
                <xsl:if test="info/address/postcode and info/address/city">
                  <p><xsl:value-of select="fn:concat(info/address/postcode, ' ', info/address/city)"/></p>
                </xsl:if>
                <xsl:if test="info/address/country">
                  <p><xsl:value-of select="info/address/country"/></p>
                </xsl:if>
                <xsl:if test="info/address/phone[1]">
                  <p><xsl:text disable-output-escaping="yes">&amp;#x260E; </xsl:text><xsl:value-of select="info/address/phone[1]"/></p>
                </xsl:if>
                <xsl:if test="info/address/phone[2]">
                  <p><xsl:text disable-output-escaping="yes">&amp;#x260E; </xsl:text><xsl:value-of select="info/address/phone[2]"/></p>
                </xsl:if>
                <xsl:if test="info/address/email[1]">
                  <p><xsl:text disable-output-escaping="yes">&amp;#x1F4E7; </xsl:text><a href="mailto:{info/address/email}"><xsl:value-of select="info/address/email[1]"/></a></p>
                </xsl:if>
                <xsl:if test="info/address/email[2]">
                  <p><xsl:text disable-output-escaping="yes">&amp;#x1F4E7; </xsl:text><a href="mailto:{info/address/email}"><xsl:value-of select="info/address/email[2]"/></a></p>
                </xsl:if>
              </address>
            </xsl:if>
            <h3>Stand</h3>
            <p><xsl:value-of select="fn:format-date(fn:current-date(), '[D01].[M01].[Y0001]')"/></p>
          </main>
          <!-- /Main-Bereich -->

          <!-- Footer-Bereich -->
          <footer data-role="footer" data-position="fixed" data-tap-toggle="false" data-hide-during-focus="false" data-theme="b">
            <h1><xsl:value-of select="$footer"/></h1>
          </footer>
          <!-- /Footer-Bereich -->

        </article>
        <!-- /jQM-Infoseite -->

        <!-- Stichwortverzeichnis -->
        <xsl:if test="$keywords > 0">
          <article data-role="page" id="index" data-title="Index">

            <!-- Header-Bereich -->
            <header data-role="header" data-position="fixed" data-tap-toggle="false" data-hide-during-focus="false" data-theme="b">
              <h1><xsl:value-of select="$header"/></h1>
              <a href="#start" class="ui-btn ui-icon-back ui-btn-icon-left">Start</a>
              <a href="#info" class="ui-btn ui-icon-info ui-btn-icon-left">Info</a>
              <nav data-role="navbar" data-iconpos="top">
                <ul>
                  <xsl:for-each select="chapter">
                    <xsl:variable name="pos" select="fn:position()" as="xs:integer"/>
                    <li>
                      <a href="#kap{$pos}" data-icon="action"><xsl:value-of select="title"/></a>
                    </li>
                  </xsl:for-each>
                </ul>
              </nav>
            </header>
            <!-- /Header-Bereich -->

            <!-- Main-Bereich -->
            <main data-role="main" class="ui-content">
              <h2>Stichwortverzeichnis (<xsl:value-of select="$keywords"/>)</h2>
              <form class="ui-filterable">
                <input id="indexsearch" data-type="search" placeholder="Begriffe suchen …"/>
              </form>
              <ul data-role="listview" id="keywords" data-filter="true" data-input="#indexsearch" data-autodividers="true" data-inset="true">
                <xsl:for-each select="//indexterm[parent::para]">
                  <xsl:sort select="primary" data-type="text" order="ascending"/>
                  <li>
                    <a href="#{fn:replace(primary, ' ', '_')}"><xsl:value-of select="primary"/></a>
                  </li>
                </xsl:for-each>
              </ul>
            </main>
            <!-- /Main-Bereich -->

            <!-- Footer-Bereich -->
            <footer data-role="footer" data-position="fixed" data-tap-toggle="false" data-hide-during-focus="false" data-theme="b">
              <h1><xsl:value-of select="$footer"/></h1>
            </footer>
            <!-- /Footer-Bereich -->

          </article>
        </xsl:if>
        <!-- /Stichwortverzeichnis -->

        <!-- chapter verarbeiten -->
        <xsl:apply-templates select="chapter"/>
      </body>
    </html>
    <!-- /HTML-Singlepage -->

    <!-- Offline-Cache-Manifest -->
    <xsl:result-document href="{$cachemanifest}" method="text" media-type="text/plain" encoding="UTF-8">
      <!-- Basisvorgaben (1) -->
      <xsl:value-of select="fn:concat('CACHE MANIFEST', $lf)"/>
      <xsl:value-of select="fn:concat('# ', fn:format-date(fn:current-date(), '[Y0001]-[M01]-[D01]'), ' ', fn:format-time(fn:current-time(), '[H01]:[m01]'), ' V 1.0',  $lf, $lf)"/>
      <xsl:value-of select="fn:concat('CACHE:', $lf)"/>

      <!-- HTML, CSS, JS -->
      <xsl:value-of select="fn:concat('index.html', $lf)"/>
      <xsl:value-of select="fn:concat($stylesheet, $lf)"/>
      <xsl:value-of select="fn:concat($javascript, $lf)"/>
      <xsl:value-of select="fn:concat($jqm_css, $lf)"/>
      <xsl:value-of select="fn:concat($jqm_js, $lf)"/>
      <xsl:value-of select="fn:concat($jquery, $lf)"/>

      <!-- Bilder -->
      <xsl:value-of select="fn:concat($webappicon, $lf)"/>
      <xsl:for-each select="fn:distinct-values(//imagedata/@fileref)">
        <xsl:sort select="." order="ascending" data-type="text"/>
        <xsl:value-of select="fn:concat(., $lf)"/>
      </xsl:for-each>

      <!-- Basisvorgaben (2) -->
      <xsl:value-of select="fn:concat($lf, 'NETWORK:', $lf, '*', $lf)"/>
      <xsl:value-of select="fn:concat($lf, 'FALLBACK:', $lf)"/>
    </xsl:result-document>
    <!-- /Offline-Cache-Manifest -->

    <!-- Web App Manifest -->
    <xsl:result-document href="{$webmanifest}">
      <!-- Teilmap für Icon(s) (als Array in der folgenden Map) -->
      <xsl:variable name="icons" select="map{'src': $webappicon, 'sizes': $iconsize, 'type': 'image/png', 'density': '1.0'}" as="map(*)"/>

      <!-- Hauptmap -->
      <xsl:variable name="manifest" as="map(*)">
        <xsl:map>
          <xsl:map-entry key="'description'" select="$description"/>
          <xsl:map-entry key="'display'" select="'standalone'"/>
          <xsl:map-entry key="'lang'" select="'de'"/>
          <xsl:map-entry key="'name'" select="if($maintitle != '') then $maintitle else $webapptitle"/>
          <xsl:map-entry key="'orientation'" select="'portrait-primary'"/>
          <xsl:map-entry key="'short_name'" select="$webapptitle"/>
          <xsl:map-entry key="'start_url'" select="'index.html'"/>
          <xsl:map-entry key="'icons'" select="array{$icons}"/>
        </xsl:map>
      </xsl:variable>

      <!-- Map-Serialisierung als JSON und Ausgabe -->
      <xsl:variable name="options" select="map{'encoding': 'UTF-8', 'method': 'json', 'indent': fn:true(), 'use-character-maps': map{'/': '/'}}" as="map(*)"/>
      <xsl:variable name="serialout" select="fn:serialize($manifest, $options)"/>
      <xsl:copy-of select="fn:replace(fn:replace($serialout, '(\s\s)(\{|\}|\[|\])', '$2'), '  ', ' ')"/>
    </xsl:result-document>
    <!-- /Web App Manifest -->
  </xsl:template>
  <!-- /Haupttemplate -->

  <!-- chapter-Template -->
  <xsl:template match="chapter">
    <xsl:variable name="aktchapos" select="fn:position()" as="xs:integer"/>
    <xsl:variable name="chapcount" select="fn:count(/book/chapter)"/>

    <!-- jQM-Unterseite -->
    <article data-role="page" id="kap{$aktchapos}" data-title="{title}">

      <!-- Header-Bereich -->
      <header data-role="header" data-position="fixed" data-tap-toggle="false" data-hide-during-focus="false" data-theme="b">
        <h1><xsl:value-of select="$header"/></h1>
        <a href="#start" class="ui-btn ui-icon-back ui-btn-icon-left">Start</a>
        <a href="#info" class="ui-btn ui-icon-info ui-btn-icon-left">Info</a>
        <nav data-role="navbar" data-iconpos="top">
          <ul>
            <xsl:for-each select="/book/chapter">
              <xsl:variable name="chapos" select="fn:position()" as="xs:integer"/>
              <xsl:choose>
                <xsl:when test="$chapos = $aktchapos">
                  <li>
                    <a class="ui-btn-active ui-state-persist" data-icon="eye"><xsl:value-of select="title"/></a>
                  </li>
                </xsl:when>
                <xsl:otherwise>
                  <li>
                    <a href="#kap{$chapos}" data-icon="action"><xsl:value-of select="title"/></a>
                  </li>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </ul>
        </nav>
      </header>
      <!-- /Header-Bereich -->

      <!-- Main-Bereich -->
      <main data-role="main" class="ui-content">
        <!--<h1><xsl:value-of select="title"/></h1> | aus title-Template -->
        <section data-role="collapsibleset" data-collapsed-icon="arrow-d" data-expanded-icon="arrow-u"> <!-- Vorgabe ist "plus" bzw. "minus" -->
          <xsl:apply-templates/>
        </section>
      </main>
      <!-- /Main-Bereich -->

      <!-- Footer-Bereich -->
      <footer data-role="footer" data-position="fixed" data-tap-toggle="false" data-hide-during-focus="false" data-theme="b">
        <h1><xsl:value-of select="$footer"/></h1>
        <xsl:if test="$aktchapos gt 1">
          <a href="#kap{$aktchapos - 1}" class="ui-btn ui-btn-left ui-btn-icon-left ui-icon-back">
            <xsl:value-of select="fn:concat('Kap ', $aktchapos - 1)"/>
          </a>
        </xsl:if>
        <xsl:if test="$aktchapos lt $chapcount">
          <a href="#kap{$aktchapos + 1}" class="ui-btn ui-btn-right ui-btn-icon-right ui-icon-forward">
            <xsl:value-of select="fn:concat('Kap ', $aktchapos + 1)"/>
          </a>
        </xsl:if>
      </footer>
      <!-- /Footer-Bereich -->

    </article>
    <!-- /jQM-Unterseite -->
  </xsl:template>
  <!-- /chapter-Template -->

  <!-- weitere Templates für die DocBook-Verarbeitung -->
  <xsl:template match="section">
    <section data-role="collapsible">
      <xsl:apply-templates/>
    </section>
  </xsl:template>

  <xsl:template match="para">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <!-- neu, falls procedure im para oder simplelist im para (dann kein nicht erlaubtes p/ol oder p/ul erzeugen) -->
  <xsl:template match="para[procedure]|para[simplelist]">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- neu, falls mediaobject im para (dann kein p/p erzeugen) -->
  <xsl:template match="para[mediaobject]">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="mediaobject">
    <p>
      <img src="{imageobject/imagedata/@fileref}" alt="{caption/para}">
        <xsl:if test="imageobject/imagedata/@width > 0">
          <xsl:attribute name="width" select="imageobject/imagedata/@width"/>
        </xsl:if>
      </img>
    </p>
    <xsl:if test="caption">
      <xsl:apply-templates select="caption"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="caption">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="inlinemediaobject">
    <img class="inline" src="{imageobject/imagedata/@fileref}" alt="">
      <xsl:if test="imageobject/imagedata/@width > 0">
        <xsl:attribute name="width" select="imageobject/imagedata/@width"/>
      </xsl:if>
    </img>
  </xsl:template>

  <xsl:template match="itemizedlist">
    <xsl:if test="title">
      <h3>
        <em>
          <xsl:value-of select="title"/>
        </em>
      </h3>
    </xsl:if>
    <ul data-role="listview" data-inset="true">
      <xsl:apply-templates select="listitem"/>
    </ul>
  </xsl:template>

  <xsl:template match="orderedlist">
    <xsl:if test="title">
      <h3>
        <em>
          <xsl:value-of select="title"/>
        </em>
      </h3>
    </xsl:if>
    <ol data-role="listview" data-inset="true">
      <xsl:apply-templates select="listitem"/>
    </ol>
  </xsl:template>

  <xsl:template match="listitem">
    <li>
      <xsl:apply-templates select="para"/>
    </li>
  </xsl:template>

  <xsl:template match="simplelist">
    <ul data-role="listview" data-inset="true">
      <xsl:for-each select="member">
        <li>
          <span><xsl:apply-templates/></span>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>

  <xsl:template match="title[parent::chapter or parent::section]">
    <!-- falls title Kind von chapter ergibt fn:count(ancestor::section) = 0,
         ansonsten >= 1 für die section-Anzahl, über $h_level entsteht hx -->
    <xsl:variable name="s_count" select="fn:count(ancestor::section)" as="xs:integer"/>
    <xsl:variable name="h_level" select="if($s_count lt 6) then $s_count + 1 else 6" as="xs:integer"/>

    <!-- $autonum fn:true() / fn:false() schaltet automatische Nummerierung ein / aus -->
    <xsl:variable name="autonum" select="fn:false()" as="xs:boolean"/>
    <xsl:variable name="num_str" as="xs:string*">
      <xsl:choose>
        <xsl:when test="$h_level = 1">
          <xsl:number format="1" from="book" count="chapter" level="single"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:number format="1." from="book" count="chapter" level="single"/>
          <xsl:number format="1.1" from="chapter" count="section" level="multiple"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- Überschrift mit oder ohne Nummerierung ausgeben -->
    <xsl:element name="h{$h_level}">
      <xsl:value-of select="if($autonum) then fn:concat(fn:string-join($num_str, ''), ' ', .) else ."/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="procedure">
    <ol>
      <xsl:for-each select="step">
        <li>
          <xsl:apply-templates/>
        </li>
      </xsl:for-each>
    </ol>
    <xsl:if test="result">
      <xsl:apply-templates select="result"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="substeps">
    <ol>
      <xsl:for-each select="step">
        <li>
          <xsl:apply-templates/>
        </li>
      </xsl:for-each>
    </ol>
  </xsl:template>

  <xsl:template match="result">
    <div class="{if(parent::step) then 'stepresult' else 'result'}">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!-- neu, subtitle auswerten -->
  <xsl:template match="subtitle">
    <strong><xsl:value-of select="."/></strong>
  </xsl:template>

  <xsl:template match="para[@role = 'infobox']">
    <p class="infobox">
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="emphasis">
    <em>
      <xsl:apply-templates/>
    </em>
  </xsl:template>

  <xsl:template match="emphasis[@role = 'bold']">
    <strong>
      <xsl:apply-templates/>
    </strong>
  </xsl:template>

  <xsl:template match="emphasis[@role = 'aktion']">
    <strong class="aktion">
      <xsl:apply-templates/>
    </strong>
  </xsl:template>

  <xsl:template match="emphasis[@role = 'posnum']">
    <span class="posnum">
      <xsl:value-of select="fn:substring(., 2, fn:string-length(.) - 2)"/> <!-- (1) ergibt 1 und (10) ergibt 10 -->
    </span>
  </xsl:template>

  <xsl:template match="emphasis[@role = 'posnr']">
    <span class="posnr">
      <xsl:value-of select="."/>
    </span>
  </xsl:template>

  <xsl:template match="qandaset">
    <ol data-role="listview" data-inset="true">
      <xsl:apply-templates/>
    </ol>
  </xsl:template>

  <xsl:template match="qandaentry">
    <li>
      <xsl:apply-templates select="question"/>
      <section data-role="collapsible" data-mini="true">
        <h2>Antwort</h2>
        <xsl:apply-templates select="answer"/>
      </section>
    </li>
  </xsl:template>

  <xsl:template match="question">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="answer">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="bibliography">
    <ol data-role="listview" data-inset="true">
      <xsl:apply-templates/>
    </ol>
  </xsl:template>

  <xsl:template match="biblioentry">
    <li>
      <!--<p>-->
        <strong><xsl:value-of select="fn:concat(author/personname/surname, ', ', author/personname/firstname)"/></strong>
        <xsl:value-of select="fn:concat(' (', copyright/year, '). ', title, '. ', if(subtitle) then fn:concat(subtitle, '. ') else(),
          publisher/publishername, '.', if(pagenums) then fn:concat(' S. ', pagenums, '.') else())"/>
      <!--</p>-->
    </li>
  </xsl:template>

  <xsl:template match="table">
    <xsl:if test="@label">
      <h3>
        <em>
          <xsl:value-of select="@label"/>
        </em>
      </h3>
    </xsl:if>
    <table data-role="table" class="ui-responsive">
      <xsl:apply-templates select="tgroup"/>
    </table>
    <xsl:if test="title">
      <p>
        <xsl:value-of select="title"/>
      </p>
    </xsl:if>
  </xsl:template>

  <xsl:template match="informaltable">
    <xsl:if test="@label">
      <h3>
        <em>
          <xsl:value-of select="@label"/>
        </em>
      </h3>
    </xsl:if>
    <table data-role="table" class="ui-responsive">
      <xsl:apply-templates/>
    </table>
    <xsl:if test="@title">
      <p>
        <xsl:value-of select="@title"/>
      </p>
    </xsl:if>
  </xsl:template>

  <xsl:template match="informaltable[@class='simple']">
    <table class="simple">
      <xsl:apply-templates/>
    </table>
  </xsl:template>

  <xsl:template match="tgroup">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="thead|tfoot|tbody">
    <xsl:element name="{fn:local-name()}">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="row|tr">
    <tr>
      <xsl:apply-templates/>
    </tr>
  </xsl:template>

  <xsl:template match="entry[ancestor::thead or ancestor::tfoot]|th">
    <th>
      <xsl:apply-templates/>
    </th>
  </xsl:template>

  <xsl:template match="entry[ancestor::tbody]|td">
    <td>
      <xsl:apply-templates/>
    </td>
  </xsl:template>

  <xsl:template match="caution|important|note|tip|warning">
    <div class="warnblock">
      <h3 class="{fn:local-name()}">
        <xsl:value-of select="title"/>
      </h3>
      <xsl:apply-templates select="title//following-sibling::*"/>
    </div>
  </xsl:template>

  <xsl:template match="note[@role='intro']">
    <div class="intro">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="note[@role='infopin']">
    <div class="infopin">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="link">
    <a href="{@xlink:href}" target="extern">
      <xsl:value-of select="."/>
    </a>
  </xsl:template>

  <xsl:template match="formalpara">
    <h4>
      <xsl:value-of select="title"/>
    </h4>
    <p>
      <xsl:value-of select="para"/>
    </p>
  </xsl:template>

  <xsl:template match="variablelist">
    <dl>
      <xsl:for-each select="varlistentry">
        <dt>
          <xsl:value-of select="term"/>
        </dt>
        <dd>
          <xsl:apply-templates select="listitem"/>
        </dd>
      </xsl:for-each>
    </dl>
  </xsl:template>

  <xsl:template match="listitem[parent::varlistentry]">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="section[@role='grid']">
    <section data-role="collapsible">
      <xsl:apply-templates select="title"/>
      <div class="ui-grid-a">
        <xsl:apply-templates select="simplesect"/>
      </div>
    </section>
  </xsl:template>

  <xsl:template match="simplesect">
    <xsl:if test="fn:position() = 1">
      <div class="ui-block-a">
        <xsl:apply-templates select="para|mediaobject"/>
      </div>
    </xsl:if>
    <xsl:if test="fn:position() = 2">
      <div class="ui-block-b">
        <xsl:apply-templates select="para|mediaobject"/>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="indexterm[parent::para]">
    <span data-keyword="{fn:replace(primary, ' ', '_')}"><xsl:value-of select="primary"/></span>
  </xsl:template>
  <!-- /weitere Templates für die DocBook-Verarbeitung -->

</xsl:stylesheet>