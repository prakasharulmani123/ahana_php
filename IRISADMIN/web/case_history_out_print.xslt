<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>
    <xsl:template match="/">
        <xsl:for-each select="FIELDS/GROUP">
            <table>
                <xsl:for-each select="PANELHEADER">
                    <tr>
                        <td colspan="2">
                            <h3>
                                <xsl:value-of select="VALUE" /> 
                            </h3>
                        </td>
                    </tr>
                </xsl:for-each>
                
                <xsl:for-each select="PANELBODY">
                    <xsl:for-each select="FIELD">
                        <xsl:choose>
                            <!-- Main Header2-->
                            <xsl:when test="@type='Header2'">
                                <tr>
                                    <td colspan="2">
                                        <h4>
                                            <xsl:value-of select="@label" /> 
                                        </h4>
                                    </td>
                                </tr>
                            </xsl:when>
                            
                            <!-- Main Text Box With DropDownList-->
                            <xsl:when test="@type='TextBoxDDL'">
                                <tr>
                                    <td>
                                        <xsl:value-of select="@label" />
                                    </td>
                                    <td>
                                        <xsl:for-each select="PROPERTIES/PROPERTY">
                                            <xsl:if test="@name='value'">
                                                <xsl:value-of select="current()"></xsl:value-of>
                                            </xsl:if>
                                            <xsl:value-of select="@Backtext"></xsl:value-of>
                                        </xsl:for-each>
                                        &#160;
                                        <xsl:for-each select="FIELD/LISTITEMS/LISTITEM">
                                            <xsl:if test="@Selected = 'true'">
                                                                        &#160;
                                                <xsl:value-of select="@value"></xsl:value-of>
                                            </xsl:if>
                                        </xsl:for-each>
                                    </td>
                                </tr>
                            </xsl:when>
                            
                            <!-- Main Text Box -->
                            <xsl:when test="@type='TextBox'">
                                <tr>
                                    <td>
                                        <xsl:value-of select="@label" />
                                    </td>
                                    <td>
                                        <xsl:for-each select="PROPERTIES/PROPERTY">
                                            <xsl:if test="@name='value'">
                                                <xsl:value-of select="current()"></xsl:value-of>
                                            </xsl:if>
                                            <xsl:value-of select="@Backtext"></xsl:value-of>
                                        </xsl:for-each>
                                        <xsl:if test="FIELD">
                                            <xsl:for-each select="FIELD">
                                                <xsl:choose>
                                                    <xsl:when test="@type='DropDownList'">
                                                        <xsl:for-each select="LISTITEMS/LISTITEM">
                                                            <xsl:if test="@Selected = 'true'">
                                                                        &#160;
                                                                <xsl:value-of select="@value"></xsl:value-of>
                                                            </xsl:if>
                                                        </xsl:for-each>
                                                    </xsl:when>
                                                </xsl:choose>
                                            </xsl:for-each>
                                        </xsl:if>
                                    </td>
                                </tr>
                            </xsl:when>
                            
                            <!-- Main Text Area-->
                            <xsl:when test="@type='TextArea'">
                                <tr>
                                    <td>
                                        <xsl:value-of select="@label" />
                                    </td>
                                    <td>
                                        <xsl:value-of select="VALUE"></xsl:value-of>
                                    </td>
                                </tr>
                            </xsl:when>
                            
                            <!-- Main Textarea Full -->
                            <xsl:when test="@type='textareaFull'">
                                <tr>
                                    <td>
                                        <xsl:value-of select="@label" />
                                    </td>
                                    <td>
                                        <xsl:value-of select="VALUE"></xsl:value-of>
                                    </td>
                                </tr>
                            </xsl:when>
                            
                            <!-- Main Radio Button -->                          
                            <xsl:when test="@type='RadioButtonList'">
                                <tr>
                                    <td>
                                        <xsl:value-of select="@label" />
                                    </td>
                                    <td>
                                        <xsl:for-each select="LISTITEMS/LISTITEM">
                                            <xsl:if test="@Selected = 'true'">
                                                <xsl:value-of select="current()"></xsl:value-of>
                                            </xsl:if>
                                        </xsl:for-each>
                                        <xsl:if test="FIELD">
                                            <span>
                                                <xsl:attribute name="id">
                                                    <xsl:value-of select="@Backdivid"></xsl:value-of>
                                                </xsl:attribute>
                                                <xsl:attribute name="class">
                                                    <xsl:value-of select="@Backcontrols"></xsl:value-of>
                                                </xsl:attribute>
                                                <xsl:for-each select="FIELD">
                                                    <xsl:choose>
                                                        <xsl:when test="@type='TextBox'">
                                                            <xsl:value-of select="@label" />&#160;
                                                            <xsl:for-each select="PROPERTIES/PROPERTY">
                                                                <xsl:if test="@name='value'">
                                                                    <xsl:value-of select="current()"></xsl:value-of>
                                                                </xsl:if>
                                                            </xsl:for-each>
                                                        </xsl:when>
                                                            
                                                        <xsl:when test="@type='RadioButtonList'">
                                                            <xsl:value-of select="@label" />&#160;
                                                            <xsl:for-each select="LISTITEMS/LISTITEM">
                                                                <xsl:if test="@Selected = 'true'">
                                                                    <xsl:value-of select="current()"></xsl:value-of>
                                                                </xsl:if>
                                                            </xsl:for-each>
                                                        </xsl:when>
                                                            
                                                        <xsl:when test="@type='DropDownList'">
                                                            <xsl:value-of select="@label" />
                                                            <xsl:for-each select="LISTITEMS/LISTITEM">
                                                                <xsl:if test="@Selected = 'true'">
                                                                        &#160;
                                                                    <xsl:value-of select="@value"></xsl:value-of>
                                                                </xsl:if>
                                                            </xsl:for-each>
                                                        </xsl:when>
                                                    </xsl:choose>
                                                </xsl:for-each>
                                            </span>
                                        </xsl:if>
                                    </td>
                                </tr>
                            </xsl:when>
                            
                            <!-- Main Checkbox TO BE CONTINUE-->
                        </xsl:choose>
                    </xsl:for-each>
                </xsl:for-each>
            </table>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>