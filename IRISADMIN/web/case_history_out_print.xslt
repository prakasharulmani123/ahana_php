<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>
    <xsl:template match="/">
        <xsl:for-each select="FIELDS/GROUP">
            <table>
                <xsl:for-each select="PANELHEADER">
                    <tr>
                        <td>
                            <b> 
                                <xsl:value-of select="VALUE" /> 
                            </b>
                        </td>
                    </tr>
                </xsl:for-each>
            </table>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>