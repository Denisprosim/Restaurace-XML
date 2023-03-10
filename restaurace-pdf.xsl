<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:r="urn:xmisd01:restaurant" exclude-result-prefixes="xs" version="2.0">

    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">
        <fo:root>

            <fo:layout-master-set>

                <fo:simple-page-master margin-bottom="2cm" margin-left="3cm" margin-right="2cm"
                    margin-top="2.5cm" master-name="my-master">
                    <fo:region-body/>
                </fo:simple-page-master>

            </fo:layout-master-set>

            <fo:page-sequence master-reference="my-master">
                <fo:flow flow-name="xsl-region-body" font-family="Arial" font-size="12pt">
                    <fo:block>
                        <fo:external-graphic src="food_patter_icon_150227.png" content-width="3cm" width="100%" display-align="before" text-align="center"/> 
                    </fo:block>
                    <fo:block>
                        <xsl:apply-templates/>
                    </fo:block>
                    
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template match="r:restaurant">
        <fo:block font-size="250%" text-align="center">
            <xsl:value-of select="r:restaurant_name"/>
        </fo:block>
        <fo:block margin-bottom="2cm" text-align="center">
            <xsl:value-of select="r:adress"/>
            <xsl:text>, </xsl:text>
            <xsl:value-of select="r:city"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="r:zip"/>
            <xsl:text>, </xsl:text>
            <xsl:value-of select="r:tel_number"/>
        </fo:block>

        <xsl:apply-templates select="r:menu" mode="obsah"/>
        
        <xsl:apply-templates select="r:menu"/>
       
    </xsl:template>

    <xsl:template match="r:menu" mode="obsah">
        <fo:table>
            <fo:table-header>
                <fo:table-row border-bottom="2px solid black" font-weight="bold">
                    <fo:table-cell width="3cm">
                        <fo:block>
                            <xsl:value-of select="@day"/> 
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell width="9cm">
                        <fo:block>
                            Jídlo:
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            Cena:
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-header>
            <fo:table-body>
                <xsl:apply-templates select="r:course" mode="obsah"/>
            </fo:table-body>
        </fo:table>
        <fo:block><xsl:value-of select="r:chef"/></fo:block>
    </xsl:template>

    <xsl:template match="r:course" mode="obsah">
        <fo:table-row>
            <fo:table-cell>
                <fo:block>
                    <xsl:value-of select="@type"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell>
            <xsl:apply-templates select="r:food" mode="obsah"/>
            </fo:table-cell>
            <fo:table-cell>
                <xsl:apply-templates select="r:food/r:price" mode="obsah"/>
            </fo:table-cell>
        </fo:table-row>
    
    </xsl:template>

    <xsl:template match="r:food" mode="obsah">
            <fo:block>
                <fo:basic-link internal-destination="{generate-id()}">
                    <xsl:value-of select="r:name"/>
                </fo:basic-link>
                
            </fo:block>
    </xsl:template>
    
    <xsl:template match="r:food">
        <xsl:apply-templates select="r:name"/>
        <fo:block>
            <xsl:value-of select="r:description"/>
        </fo:block>
        <fo:block>
            Kalorie: <xsl:value-of select="r:calories"/>
        </fo:block>
        <fo:block>
            Obsahuje: <xsl:value-of select="r:alergens"/>
        </fo:block>
        <fo:block>
            Cena: <xsl:value-of select="r:price"/> <xsl:value-of select="r:price/@currency"/>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="r:food/r:name">
        <fo:block id="{generate-id(..)}" page-break-before="always">
            <xsl:value-of select="."/>
        </fo:block>
        
    </xsl:template>
    
    <xsl:template match="r:price" mode="obsah">
        <fo:block>
            <xsl:value-of select="."/> <xsl:value-of select="./@currency"/>
        </fo:block>
    </xsl:template>
    
    
    
   


</xsl:stylesheet>
