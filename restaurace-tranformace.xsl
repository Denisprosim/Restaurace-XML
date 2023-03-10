<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:r="urn:xmisd01:restaurant"
    exclude-result-prefixes="xs r" version="2.0">

    <xsl:output method="html" version="5"/>
    <xsl:output method="html" version="5" name="html5"/>
 
    <xsl:variable name="today" select="number(translate(format-time(current-time(), '[H01]:[m01]:[s01]'),':',''))"/>
    
    <xsl:template match="/">
        <head>
            <link href="restaurace-style.css" rel="stylesheet" type="text/css"/>
            <title>
                <xsl:value-of select="r:restaurant/r:restaurant_name"/>
            </title>
        </head>
        <body>
            <main>
                <xsl:apply-templates/>
            </main>
        </body>
    </xsl:template>

    <xsl:template match="r:restaurant">
        <h1>
            <xsl:value-of select="r:restaurant_name"/>
        </h1>    

        <div class="contact">
            <h2>Kontaktní údaje</h2>
            <ul>
                <li>
                    <xsl:value-of select="r:adress"/>
                </li>
                <li>
                    <xsl:value-of select="r:city"/>
                </li>
                <li>
                    <xsl:value-of select="r:zip"/>
                </li>
                <li>
                    <a href="tel:{r:tel_number}"><xsl:value-of select="r:tel_number"/></a>                        
                </li>
                <li>
                    <xsl:value-of select="r:opening_time"/>-<xsl:value-of select="r:closing_time"/>
                </li>
            </ul>
        </div>
        
        <xsl:variable name="openinig" select="number(translate(r:opening_time,':',''))"/>
        <xsl:variable name="closing" select="number(translate(r:closing_time,':',''))"/>
        
        <div class="datetime">
            <xsl:choose>
                <xsl:when test="$openinig &lt; $today and $closing &gt; $today">
                    OTEVŘENO
                </xsl:when>
                <xsl:otherwise>
                    ZAVŘENO
                </xsl:otherwise>
            </xsl:choose>
        </div>
        <div class="choose-day">
        <ul>
            <xsl:apply-templates select="r:menu" mode="toc"/>
        </ul>
        </div>
        
        
        
       
    </xsl:template>
    
    <xsl:template match="r:restaurant/r:menu" mode="toc">
            <li>
                <a href="{generate-id(.)}.html">
                    <xsl:value-of select="@day"/>
                </a>
            </li>   
    </xsl:template>

    <xsl:template match="r:menu">
        <xsl:result-document href="{generate-id(.)}.html" format="html5">
            <html lang="cs">
                <head>
                    <link href="restaurace-style.css" rel="stylesheet" type="text/css"/>
                    <title>
                        <xsl:value-of select="@day"/>
                    </title>
                </head>
                <body>
                    <div class="container-menu">
                        <div class="menu">                     
                            <h3>Nabídka na den: <xsl:value-of select="@day"/></h3>
                            <div class="menu-content">
                                <strong>Kuchař dne:</strong>
                                <xsl:value-of select="r:chef"/>
                                <xsl:apply-templates select="r:course"/>
                            </div>
                        </div>
                    </div>
                 </body>
            </html>
        </xsl:result-document>

    </xsl:template>

    <xsl:template match="r:course">
        <h4>
            <xsl:value-of select="@type"/>
        </h4>

        <xsl:apply-templates select="r:food"/>

    </xsl:template>

    <xsl:template match="r:food">
        <div class="food">
            <strong>
                <xsl:value-of select="r:name"/>
            </strong>
            <br/>
            <p>
                <xsl:value-of select="r:description"/>
            </p> Kalorie: <xsl:value-of select="r:calories"/>
            <br/> Alergeny: <xsl:value-of select="r:alergens/r:alergen/@number"/>
            <br/> Cena: <xsl:value-of select="r:price"/>
            <xsl:value-of select="r:price/@currency"/>
            <br/>
        </div>
    </xsl:template>

    <xsl:template match="r:list_of_alergens">
        <table>
            <xsl:apply-templates select="r:alergens"/>
        </table>
    </xsl:template>

    <xsl:template match="r:alergens">
        <tr>
            <xsl:apply-templates select="r:alergen"/>
        </tr>
    </xsl:template>

    <xsl:template match="r:alergen">

        <th>
            <xsl:value-of select="@number"/>
        </th>

        <td>
            <xsl:value-of select="r:contains"/>
        </td>

    </xsl:template>


</xsl:stylesheet>
