<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" encoding="UTF-8"/>
    <xsl:template match="/">
        <xsl:for-each select="FIELDS/GROUP">
<!--            <table style="margin-bottom:20px;">-->
                <table>
                <xsl:for-each select="PANELHEADER">
                    <tr>
                        <td colspan="2"><div class="heading-label">
                            <h1>
                                <xsl:value-of select="VALUE" />
                            </h1></div>
                        </td>
                    </tr>
                    
                </xsl:for-each>
                <xsl:for-each select="PANELBODY">
                    <xsl:for-each select="FIELD">
                        <xsl:choose>
                            <!-- TherapistName Text Box -->
                            <xsl:when test="@type='TextBox' and @id='TherapistName'">
                                <xsl:if test="PROPERTIES/PROPERTY[@name = 'value' and string(.)]">
                                    <tr>
                                        <td colspan="2" align="right" valign="top">
                                                <xsl:for-each select="PROPERTIES/PROPERTY">
                                                    <xsl:if test="@name='value'">
                                                        <strong>
                                                        <xsl:value-of select="current()"></xsl:value-of>
                                                        <xsl:value-of select="../../@Backtext"></xsl:value-of>
                                                        </strong> <br/>
                                                        <span id="date_name"></span> | <span id="time"></span> 
                                                    </xsl:if>
                                                </xsl:for-each>
                                            
                                        </td>
                                    </tr>
                                </xsl:if>
                            </xsl:when>
                            
                            <!-- Main Header2-->
                            <xsl:when test="@type='Header2'">
                                <tr class="header2" data-header2="{@class}">
                                    <td colspan="2">
                                        <h2>
                                                <xsl:value-of select="@label" />
                                        </h2>
                                    </td>
                                </tr>
                            </xsl:when>
                            
                            <!-- Main Text Box With DropDownList-->
                            <xsl:when test="@type='TextBoxDDL'">
                                <xsl:if test="PROPERTIES/PROPERTY[@name = 'value' and string(.)]">
                                    <tr class="{@header2Class}">
                                        <td width="125">
                                            <strong>
                                                <xsl:value-of select="@label" />
                                            </strong>
                                        </td>
                                        <td>
                                            <xsl:for-each select="PROPERTIES/PROPERTY">
                                                <xsl:if test="@name='value'">
                                                    <xsl:value-of select="current()"></xsl:value-of>
                                                </xsl:if>
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
                                </xsl:if>
                            </xsl:when>
                            
                            <!-- Main DropDownList-->
                            <xsl:when test="@type='DropDownList'">
                                <tr class="{@header2Class}">
                                    <td width="125">
                                            <strong>
                                                <xsl:value-of select="@label" />
                                            </strong>
                                        </td>
                                    <td>
                                        <xsl:for-each select="LISTITEMS/LISTITEM">
                                            <xsl:if test="@Selected = 'true'">
                                                <xsl:value-of select="@value"></xsl:value-of>
                                            </xsl:if>
                                        </xsl:for-each>
                                    </td>
                                </tr>
                            </xsl:when>
                            
                            <!-- Main Text Box -->
                            <xsl:when test="@type='TextBox'">
                                <xsl:if test="PROPERTIES/PROPERTY[@name = 'value' and string(.)]">
                                    <tr class="{@header2Class}">
                                        <td width="125">
                                            <strong>
                                                <xsl:value-of select="@label" />
                                            </strong>
                                        </td>
                                        <td>
                                            <xsl:for-each select="PROPERTIES/PROPERTY">
                                                <xsl:if test="@name='value'">
                                                    <xsl:value-of select="current()"></xsl:value-of>
                                                    <xsl:value-of select="../../@Backtext"></xsl:value-of>
                                                </xsl:if>
                                            </xsl:for-each>
                                        </td>
                                    </tr>
                                </xsl:if>
                            </xsl:when>
                            
                            <!-- Main Text Area-->
                            <xsl:when test="@type='TextArea'">
                                <xsl:if test="VALUE and VALUE!=''">
                                    <tr class="{@header2Class}">
                                        <td width="125">
                                            <strong>
                                                <xsl:value-of select="@label" />
                                            </strong>
                                        </td>
                                        <td>
                                            <xsl:value-of select="VALUE"></xsl:value-of>
                                        </td>
                                    </tr>
                                </xsl:if>
                            </xsl:when>
                            
                            <!-- Main Textarea Full -->
                            <xsl:when test="@type='textareaFull'">
                                <xsl:if test="VALUE and VALUE!=''">
<!--                                    <tr class="{@header2Class}">
                                        <th colspan="2">
                                            <xsl:value-of select="@label" />
                                        </th>
                                    </tr>-->
                                    <tr class="{@header2Class}">
                                        <td colspan="2">
                                            <span id="{@id}">
                                                <xsl:attribute name="class">
                                                    <xsl:for-each select="PROPERTIES/PROPERTY">
                                                        <xsl:if test="@name='class'">
                                                            <xsl:value-of select="current()"></xsl:value-of>
                                                        </xsl:if>
                                                    </xsl:for-each>
                                                </xsl:attribute>
                                                <xsl:value-of select="VALUE" ></xsl:value-of>
                                            </span>
                                        </td>
                                    </tr>
                                </xsl:if>
                            </xsl:when>
                            
                            <!-- Main Radio Button -->                          
                            <xsl:when test="@type='RadioButtonList'">
                                <xsl:if test="boolean(LISTITEMS/LISTITEM/@Selected = 'true')">
                                    <tr class="{@header2Class}">
                                        <td width="125">
                                            <strong>
                                                <xsl:value-of select="@label" />
                                            </strong>
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
                                                                <br/><xsl:value-of select="@label" />&#160;
                                                                <xsl:for-each select="PROPERTIES/PROPERTY">
                                                                    <xsl:if test="@name='value'">
                                                                        <span id="sub_textbox">
                                                                            <xsl:value-of select="current()"></xsl:value-of>
                                                                        </span>
                                                                    </xsl:if>
                                                                </xsl:for-each>
                                                            </xsl:when>
                                                            
                                                            <xsl:when test="@type='RadioButtonList'">
                                                                <br/><xsl:value-of select="@label" />&#160;
                                                                <xsl:for-each select="LISTITEMS/LISTITEM">
                                                                    <xsl:if test="@Selected = 'true'">
                                                                        <span id="sub_textbox">
                                                                        <xsl:value-of select="current()"></xsl:value-of>
                                                                        </span>
                                                                    </xsl:if>
                                                                </xsl:for-each>
                                                            </xsl:when>
                                                            
                                                            <xsl:when test="@type='DropDownList'">
                                                                <br/><xsl:value-of select="@label" />&#160;
                                                                <xsl:for-each select="LISTITEMS/LISTITEM">
                                                                    <span id="sub_textbox">
                                                                    <xsl:if test="@Selected = 'true'">
                                                                      <xsl:value-of select="@value"></xsl:value-of>
                                                                    </xsl:if>
                                                                    </span>
                                                                </xsl:for-each>
                                                            </xsl:when>
                                                        </xsl:choose>
                                                    </xsl:for-each>
                                                </span>
                                            </xsl:if>
                                        </td>
                                    </tr>
                                </xsl:if>
                            </xsl:when>
                            
                            <!-- Main Checkbox -->
                            <xsl:when test="@type='CheckBoxList'">
                                <xsl:if test="boolean(LISTITEMS/LISTITEM/@Selected = 'true')">
                                    <tr class="{@header2Class}">
                                        <td width="125">
                                            <strong>
                                                <xsl:value-of select="@label" />
                                            </strong>
                                        </td>
                                        <td>
                                            <xsl:for-each select="LISTITEMS/LISTITEM">
                                                <xsl:if test="@Selected = 'true'">
                                                    <xsl:value-of select="concat(' ' , @value)" />
                                                    <xsl:if test="not(position() = last())">,</xsl:if>
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
                                                                <br/><xsl:value-of select="@label" />&#160;
                                                                <xsl:for-each select="PROPERTIES/PROPERTY">
                                                                    <xsl:if test="@name='value'">
                                                                        <span id="sub_textbox">
                                                                            <xsl:value-of select="current()"></xsl:value-of>
                                                                        </span>
                                                                    </xsl:if>
                                                                </xsl:for-each>
                                                            </xsl:when>
                                                        </xsl:choose>
                                                    </xsl:for-each>
                                                </span>
                                            </xsl:if>
                                        </td>
                                    </tr>
                                </xsl:if>
                            </xsl:when>
                            
                            <!-- Main Grid -->
                            <xsl:when test="@type='RadGrid'">
                                <tr class="RadGrid {@header2Class}" data-radgrid="{@AddButtonTableId}">
                                    <td colspan="2">
                                        <table>
                                            <xsl:for-each select="PROPERTIES/PROPERTY">
                                                <xsl:attribute name="{@name}">
                                                    <xsl:value-of select="current()"></xsl:value-of>
                                                </xsl:attribute>
                                            </xsl:for-each>
                                            <thead>
                                                <tr>
                                                    <xsl:for-each select="HEADER/TH">
                                                        
                                                        <xsl:if test="HEADER/TH[. = 'Complaints']">
                                                            <xsl:text> </xsl:text>
                                                        </xsl:if>
                                                        
                                                        <xsl:if test="HEADER/TH[. != 'Complaints']">
                                                            <td class="grey-row">
                                                            <xsl:value-of select="current()" />
                                                            </td>
                                                        </xsl:if>
                                                    </xsl:for-each>
<!--                                                    <xsl:for-each select="HEADER/TH">
                                                        <td class="grey-row">
                                                            <xsl:value-of select="current()" />
                                                            </td>
                                                        </xsl:for-each>-->
                                                    
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <xsl:for-each select="COLUMNS">
                                                    <xsl:variable name="rColor">
                                                        <xsl:choose>
                                                            <xsl:when test="position() mod 2 = 1">
                                                                <xsl:text> </xsl:text>
                                                            </xsl:when>
                                                            <xsl:otherwise>grey-row</xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:variable>
                                                    <tr class="{$rColor}">
                                                    
                                                        <xsl:for-each select="FIELD">
                                                            <td>
                                                                <xsl:choose>
                                                                    <!-- Text Box -->
                                                                    <xsl:when test="@type='TextBox'">
                                                                        <xsl:if test="PROPERTIES/PROPERTY[@name = 'value' and string(.)]">
                                                                            <xsl:for-each select="PROPERTIES/PROPERTY">
                                                                                <xsl:if test="@name='value'">
                                                                                    <xsl:value-of select="current()"></xsl:value-of>
                                                                                </xsl:if>
                                                                            </xsl:for-each>
                                                                        </xsl:if>
                                                                    </xsl:when>
                                                                        
                                                                    <!-- Main Text Box With DropDownList-->
                                                                    <xsl:when test="@type='TextBoxDDL'">
                                                                        <xsl:if test="PROPERTIES/PROPERTY[@name = 'value' and string(.)]">
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
                                                                        </xsl:if>
                                                                    </xsl:when>
                                                                        
                                                                    <!-- Drop Down List -->
                                                                    <xsl:when test="@type='DropDownList'">
                                                                        <xsl:if test="boolean(LISTITEMS/LISTITEM/@Selected = 'true')">
                                                                            <xsl:for-each select="LISTITEMS/LISTITEM">
                                                                                <xsl:if test="@Selected = 'true'">
                                                                                        &#160;
                                                                                    <xsl:value-of select="@value"></xsl:value-of>
                                                                                </xsl:if>
                                                                            </xsl:for-each>
                                                                        </xsl:if>
                                                                    </xsl:when>
                                                                    
                                                                    <!-- Radio Button -->
                                                                    <xsl:when test="@type='RadioButtonList'">
                                                                        <xsl:if test="boolean(LISTITEMS/LISTITEM/@Selected = 'true')">
                                                                                &#160;
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
                                                                                                <br/><xsl:value-of select="@label" />&#160;
                                                                                                <xsl:for-each select="PROPERTIES/PROPERTY">
                                                                                                    <xsl:if test="@name='value'">
                                                                                                        <span id="sub_textbox">
                                                                                                        <xsl:value-of select="current()"></xsl:value-of>
                                                                                                        </span>
                                                                                                    </xsl:if>
                                                                                                </xsl:for-each>
                                                                                            </xsl:when>
                                                                                        </xsl:choose>
                                                                                    </xsl:for-each>
                                                                                </span>
                                                                            </xsl:if>
                                                                        </xsl:if>
                                                                    </xsl:when>
                                                                </xsl:choose>
                                                            </td>
                                                        </xsl:for-each>
                                                    </tr>
                                                </xsl:for-each>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                                
                            </xsl:when>
                            
                            <!-- Main Panel Bar -->
                            <xsl:when test="@type='PanelBar'">
                                <tr class="PanelBar">
                                    <td colspan="2">
                                        <table>
                                            <tr>
                                                <td colspan="2">
                                                    <h2>
                                                        <xsl:value-of select="@label"></xsl:value-of> 
                                                    </h2>
                                                </td>
                                            </tr>
                                            
                                            <xsl:for-each select="FIELD">
                                                <xsl:choose>
                                                    <!-- Main Header2 -->
                                                    <xsl:when test="@type='Header2'">
                                                        <tr class="header2" data-header2="{@class}">
                                                            <td colspan="2">
                                                                <h2>
                                                                        <xsl:value-of select="@label" /> 
                                                                </h2>
                                                            </td>
                                                        </tr>
                                                    </xsl:when>
                                                    
                                                    <xsl:when test="@type='RadGrid'">
                                                        <tr class="RadGrid {@header2Class}" data-radgrid="{@AddButtonTableId}">
                                                            <td colspan="2">
                                                                <table>
                                                                    <xsl:for-each select="PROPERTIES/PROPERTY">
                                                                        <xsl:attribute name="{@name}">
                                                                            <xsl:value-of select="current()"></xsl:value-of>
                                                                        </xsl:attribute>
                                                                    </xsl:for-each>
                                                                    <thead>
                                                                        <tr>
                                                                            <xsl:for-each select="HEADER/TH">
                                                                                <td class="grey-row">
                                                                                    <xsl:value-of select="current()" />
                                                                                </td>
                                                                            </xsl:for-each>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <xsl:for-each select="COLUMNS">
                                                                            
                                                                            
                                                                            <xsl:variable name="vColor">
                                                                                <xsl:choose>
                                                                                  <xsl:when test="position() mod 2 = 1">
                                                                                    <xsl:text> </xsl:text>
                                                                                  </xsl:when>
                                                                                  <xsl:otherwise>grey-row</xsl:otherwise>
                                                                                </xsl:choose>
                                                                            </xsl:variable>
                                                                            <tr class="{$vColor}">
                                                                           
                                                                                <xsl:for-each select="FIELD">
                                                                                    <td>
                                                                                        <xsl:choose>
                                                                                            <xsl:when test="@type='TextBox'">
                                                                                                <xsl:if test="PROPERTIES/PROPERTY[@name = 'value' and string(.)]">
                                                                                                    <xsl:for-each select="PROPERTIES/PROPERTY">
                                                                                                        <xsl:if test="@name='value'">
                                                                                                            <xsl:value-of select="current()"></xsl:value-of>
                                                                                                        </xsl:if>
                                                                                                    </xsl:for-each>
                                                                                                </xsl:if>
                                                                                            </xsl:when>
                                                                                            
                                                                                            <!-- Main Text Box With DropDownList-->
                                                                                            <xsl:when test="@type='TextBoxDDL'">
                                                                                                <xsl:if test="PROPERTIES/PROPERTY[@name = 'value' and string(.)]">
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
                                                                                                </xsl:if>
                                                                                            </xsl:when>
                                                                    
                                                                                            <xsl:when test="@type='DropDownList'">
                                                                                                <xsl:if test="boolean(LISTITEMS/LISTITEM/@Selected = 'true')">
                                                                                                    <xsl:for-each select="LISTITEMS/LISTITEM">
                                                                                                        <xsl:if test="@Selected = 'true'">
                                                                                                            &#160;
                                                                                                            <xsl:value-of select="@value"></xsl:value-of>
                                                                                                        </xsl:if>
                                                                                                    </xsl:for-each>
                                                                                                </xsl:if>
                                                                                            </xsl:when>
                                                                    
                                                                                            <xsl:when test="@type='RadioButtonList'">
                                                                                                <xsl:if test="boolean(LISTITEMS/LISTITEM/@Selected = 'true')">
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
                                                                                                                    
                                                                                                                    <xsl:when test="@type='DropDownList'">
                                                                                                                        <xsl:if test="boolean(LISTITEMS/LISTITEM/@Selected = 'true')">
                                                                                                                            <xsl:for-each select="LISTITEMS/LISTITEM">
                                                                                                                                <xsl:if test="@Selected = 'true'">
                                                                                                            &#160;
                                                                                                                                   <span id="sub_textbox"> <xsl:value-of select="@value">                                                                                                                                                              
                                                                                                                                   </xsl:value-of> 
                                                                                                                                   </span>
                                                                                                                                </xsl:if>
                                                                                                                            </xsl:for-each>
                                                                                                                        </xsl:if>
                                                                                                                    </xsl:when>
                                                                                                                </xsl:choose>
                                                                                                            </xsl:for-each>
                                                                                                        </span>
                                                                                                    </xsl:if>
                                                                                                </xsl:if>
                                                                                            </xsl:when>
                                                                                                
                                                                                            <xsl:when test="@type='CheckBoxList'">
                                                                                                <xsl:if test="boolean(LISTITEMS/LISTITEM/@Selected = 'true')">
                                                                                                    <xsl:for-each select="LISTITEMS/LISTITEM">
                                                                                                        <xsl:if test="@Selected = 'true'">
                                                                                                            <xsl:value-of select="concat(' ' , @value)" />
                                                                                                            <xsl:if test="not(position() = last())">,</xsl:if>
                                                                                                        </xsl:if>
                                                                                                    </xsl:for-each>
                                                                                                </xsl:if>
                                                                                            </xsl:when>
                                                                                        </xsl:choose>
                                                                                    </td>
                                                                                </xsl:for-each>
                                                                            </tr>
                                                                        </xsl:for-each>
                                                                         
                                                                    </tbody>
                                                                    
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </xsl:when>
                                                    
                                                    <xsl:when test="@type='RadioButtonList'">
                                                        <xsl:if test="boolean(LISTITEMS/LISTITEM/@Selected = 'true')">
                                                            <tr class="{@header2Class}">
                                                                <td width="125">
                                                                    <strong>
                                                                        <xsl:value-of select="@label" />
                                                                    </strong>
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
                                                                                    <xsl:when test="@type='DropDownList'">
                                                                                        <span>
                                                                                            <xsl:value-of select="@label" />&#160;
                                                                                            <xsl:for-each select="LISTITEMS/LISTITEM">
                                                                                                <xsl:if test="@Selected = 'true'">
                                                                                                    <xsl:value-of select="@value"></xsl:value-of>
                                                                                                </xsl:if>
                                                                                            </xsl:for-each>
                                                                                        </span>
                                                                                    </xsl:when>
                                                                                    
                                                                                    <xsl:when test="@type='TextBox'">
                                                                                        <span>
                                                                                            <xsl:value-of select="@label" />&#160;
                                                                                            <xsl:for-each select="PROPERTIES/PROPERTY">
                                                                                                <xsl:if test="@name='value'">
                                                                                                    <xsl:value-of select="current()"></xsl:value-of>
                                                                                                </xsl:if>
                                                                                            </xsl:for-each>
                                                                                        </span>
                                                                                    </xsl:when>
                                                                                    
                                                                                    <xsl:when test="@type='RadioButtonList'">
                                                                                        <span>
                                                                                            <xsl:value-of select="@label" />
                                                                                            <xsl:for-each select="LISTITEMS/LISTITEM">
                                                                                                <xsl:if test="@Selected = 'true'">
                                                                                                    <xsl:value-of select="current()"></xsl:value-of>
                                                                                                </xsl:if>
                                                                                            </xsl:for-each>
                                                                                        </span>
                                                                                    </xsl:when>
                                                                                    
                                                                                    <xsl:when test="@type='CheckBoxList'">
                                                                                        <xsl:value-of select="@label" />
                                                                                        <span>
                                                                                            <xsl:for-each select="LISTITEMS/LISTITEM">
                                                                                                <xsl:if test="@Selected = 'true'">
                                                                                                    <xsl:value-of select="concat(' ' , @value)" />
                                                                                                    <xsl:if test="not(position() = last())">,</xsl:if>
                                                                                                </xsl:if>
                                                                                            </xsl:for-each>
                                                                                        </span>
                                                                                    </xsl:when>
                                                                                </xsl:choose>
                                                                            </xsl:for-each>
                                                                        </span>
                                                                    </xsl:if>
                                                                </td>
                                                            </tr>
                                                        </xsl:if>
                                                    </xsl:when>
                                                    
                                                    <xsl:when test="@type='TextBoxDDL'">
                                                        <xsl:if test="PROPERTIES/PROPERTY[@name = 'value' and string(.)]">
                                                            <tr class="{@header2Class}">
                                                                <td width="125">
                                                                    <strong>
                                                                        <xsl:value-of select="@label" />
                                                                    </strong>
                                                                </td>
                                                                <td>
                                                                    <xsl:for-each select="PROPERTIES/PROPERTY">
                                                                        <xsl:if test="@name='value'">
                                                                            <xsl:value-of select="current()"></xsl:value-of>
                                                                        </xsl:if>
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
                                                        </xsl:if>
                                                    </xsl:when>
                                                    
                                                    <xsl:when test="@type='TextBox'">
                                                        <xsl:if test="PROPERTIES/PROPERTY[@name = 'value' and string(.)]">
                                                            <tr class="{@header2Class}">
                                                                <td width="125">
                                                                    <strong>
                                                                        <xsl:value-of select="@label" />
                                                                    </strong>
                                                                </td>
                                                                <td>
                                                                    <xsl:for-each select="PROPERTIES/PROPERTY">
                                                                        <xsl:if test="@name='value'">
                                                                            <xsl:value-of select="current()"></xsl:value-of>
                                                                        </xsl:if>
                                                                    </xsl:for-each>
                                                                </td>
                                                            </tr>
                                                        </xsl:if>
                                                    </xsl:when>
                                                    
                                                    <!-- Main Text Area-->
                                                    <xsl:when test="@type='TextArea'">
                                                        <xsl:if test="VALUE and VALUE!=''">
                                                            <tr class="{@header2Class}">
                                                                <td width="125">
                                                                    <strong>
                                                                        <xsl:value-of select="@label" />
                                                                    </strong>
                                                                </td>
                                                                <td>
                                                                    <xsl:value-of select="VALUE"></xsl:value-of>
                                                                </td>
                                                            </tr>
                                                        </xsl:if>
                                                    </xsl:when>
                                                    
                                                    <xsl:when test="@type='textareaFull'">
                                                        <xsl:if test="VALUE and VALUE!=''">
                                                            <tr class="{@header2Class}">
                                                                <td colspan="2">
                                                                    <xsl:value-of select="@label" />
                                                                </td>
                                                            </tr>
                                                            <tr class="{@header2Class}">
                                                                <td colspan="2">
                                                                    <span id="{@id}">
                                                                        <xsl:attribute name="class">
                                                                            <xsl:for-each select="PROPERTIES/PROPERTY">
                                                                                <xsl:if test="@name='class'">
                                                                                    <xsl:value-of select="current()"></xsl:value-of>
                                                                                </xsl:if>
                                                                            </xsl:for-each>
                                                                        </xsl:attribute>
                                                                        <xsl:value-of select="VALUE" ></xsl:value-of>
                                                                    </span>
                                                                </td>
                                                            </tr>
                                                        </xsl:if>
                                                    </xsl:when>
                                                    
                                                    <xsl:when test="@type='CheckBoxList'">
                                                        <xsl:if test="boolean(LISTITEMS/LISTITEM/@Selected = 'true')">
                                                            <tr class="{@header2Class}">
                                                                <td width="125">
                                                                    <strong>
                                                                        <xsl:value-of select="@label" />
                                                                    </strong>
                                                                </td>
                                                                <td>
                                                                    <xsl:for-each select="LISTITEMS/LISTITEM">
                                                                        <xsl:if test="@Selected = 'true'">
                                                                            <xsl:value-of select="concat(' ' , @value)" />
                                                                            <xsl:if test="not(position() = last())">,</xsl:if>
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
                                                                                        <br/><xsl:value-of select="@label" />&#160;
                                                                                        <xsl:for-each select="PROPERTIES/PROPERTY">
                                                                                            <xsl:if test="@name='value'">
                                                                                                 <span id="sub_textbox">
                                                                                                    <xsl:value-of select="current()"></xsl:value-of>
                                                                                                 </span>
                                                                                            </xsl:if>
                                                                                        </xsl:for-each>
                                                                                    </xsl:when>
                                                                                
                                                                                    <xsl:when test="@type='RadioButtonList'">
                                                                                        <xsl:value-of select="@label" />&#160;&#160;
                                                                                        <xsl:for-each select="LISTITEMS/LISTITEM">
                                                                                            <xsl:if test="@Selected = 'true'">
                                                                                                <xsl:value-of select="current()"></xsl:value-of>
                                                                                            </xsl:if>
                                                                                        </xsl:for-each>
                                                                                    </xsl:when>
                                                                                </xsl:choose>
                                                                            </xsl:for-each>
                                                                        </span>
                                                                    </xsl:if>
                                                                </td>
                                                            </tr>
                                                        </xsl:if>
                                                    </xsl:when>
                                                    
                                                    <xsl:when test="@type='DropDownList'">
                                                        <xsl:if test="boolean(LISTITEMS/LISTITEM/@Selected = 'true')">
                                                            <tr class="{@header2Class}">
                                                                <td width="125">
                                                                    <strong>
                                                                        <xsl:value-of select="@label" />
                                                                    </strong>
                                                                </td>
                                                                <td>
                                                                    <xsl:for-each select="LISTITEMS/LISTITEM">
                                                                        <xsl:if test="@Selected = 'true'">
                                                                            &#160;
                                                                            <xsl:value-of select="@value"></xsl:value-of>
                                                                        </xsl:if>
                                                                    </xsl:for-each>
                                                                    <xsl:value-of select="@Backtext"></xsl:value-of>
                                                                </td>
                                                            </tr>
                                                        </xsl:if>
                                                    </xsl:when>
                                                </xsl:choose>
                                            </xsl:for-each>
                                        </table>
                                        
                                    </td>
                                </tr>
                                
                            </xsl:when>
                        </xsl:choose>
                    </xsl:for-each>
                   
                </xsl:for-each>
               <tr>
                        <td colspan="2" align="left" valign="top" class="spe-line"> 
                            <span id='hide_span'>Hiding text</span>
                        </td>
                    </tr>
            </table>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>