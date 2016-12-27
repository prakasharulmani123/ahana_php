<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>
    <xsl:template match="/">
        <xsl:for-each select="FIELDS/GROUP">
            <table style="margin-bottom:20px;">
                <xsl:for-each select="PANELHEADER">
                    <tr>
                        <td colspan="2">
                            <h4>
                                <xsl:value-of select="VALUE" /> 
                            </h4>
                        </td>
                    </tr>
                </xsl:for-each>
                <xsl:for-each select="PANELBODY">
                    <xsl:for-each select="FIELD">
                        <xsl:choose>
                            <!-- Main Header2-->
                            <xsl:when test="@type='Header2'">
                                <tr class="header2" data-header2="{@class}">
                                    <td colspan="2">
                                        <p>
                                            <b>
                                                <xsl:value-of select="@label" />
                                            </b>
                                        </p>
                                    </td>
                                </tr>
                            </xsl:when>
                            
                            <!-- Main Text Box With DropDownList-->
                            <xsl:when test="@type='TextBoxDDL'">
                                <xsl:if test="PROPERTIES/PROPERTY[@name = 'value' and string(.)]">
                                    <tr class="{@header2Class}">
                                        <td>
                                            <xsl:value-of select="@label" />
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
                            
                            <!-- Main Text Box -->
                            <xsl:when test="@type='TextBox'">
                                <xsl:if test="PROPERTIES/PROPERTY[@name = 'value' and string(.)]">
                                    <tr class="{@header2Class}">
                                        <td>
                                            <xsl:value-of select="@label" />
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
                                        <td>
                                            <xsl:value-of select="@label" />
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
                                    <tr class="{@header2Class}">
                                        <th colspan="2">
                                            <xsl:value-of select="@label" />
                                        </th>
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
                            
                            <!-- Main Radio Button -->                          
                            <xsl:when test="@type='RadioButtonList'">
                                <xsl:if test="boolean(LISTITEMS/LISTITEM/@Selected = 'true')">
                                    <tr class="{@header2Class}">
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
                                </xsl:if>
                            </xsl:when>
                            
                            <!-- Main Checkbox -->
                            <xsl:when test="@type='CheckBoxList'">
                                <xsl:if test="boolean(LISTITEMS/LISTITEM/@Selected = 'true')">
                                    <tr class="{@header2Class}">
                                        <td>
                                            <xsl:value-of select="@label" />
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
                                                                <xsl:value-of select="@label" />&#160;
                                                                <xsl:for-each select="PROPERTIES/PROPERTY">
                                                                    <xsl:if test="@name='value'">
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
                            
                            <!-- Main Grid -->
                            <xsl:when test="@type='RadGrid'">
                                <tr class="form-group RadGrid {@header2Class}" data-radgrid="{@AddButtonTableId}">
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
                                                        <th>
                                                            <xsl:value-of select="current()" />
                                                        </th>
                                                    </xsl:for-each>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <xsl:for-each select="COLUMNS">
                                                    <tr>
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
                                                                                <div>
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
                                                                                        </xsl:choose>
                                                                                    </xsl:for-each>
                                                                                </div>
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
                                                    <h4>
                                                        <xsl:value-of select="@label"></xsl:value-of>
                                                    </h4>
                                                </td>
                                            </tr>
                                            
                                            <xsl:for-each select="FIELD">
                                                <xsl:choose>
                                                    <!-- Main Header2 -->
                                                    <xsl:when test="@type='Header2'">
                                                        <tr class="header2" data-header2="{@class}">
                                                            <td colspan="2">
                                                                <p>
                                                                    <b>
                                                                        <xsl:value-of select="@label" /> 
                                                                    </b>
                                                                </p>
                                                            </td>
                                                        </tr>
                                                    </xsl:when>
                                                    
                                                    <xsl:when test="@type='RadGrid'">
                                                        <tr class="form-group RadGrid {@header2Class}" data-radgrid="{@AddButtonTableId}">
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
                                                                                <th>
                                                                                    <xsl:value-of select="current()" />
                                                                                </th>
                                                                            </xsl:for-each>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <xsl:for-each select="COLUMNS">
                                                                            <tr>
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
                                                                                                        <div>
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
                                                                                                                </xsl:choose>
                                                                                                            </xsl:for-each>
                                                                                                        </div>
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
                                                                <td>
                                                                    <xsl:value-of select="@label" />
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
                                                                <td>
                                                                    <xsl:value-of select="@label" />
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
                                                                <td>
                                                                    <xsl:value-of select="@label" />
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
                                                                                        <xsl:value-of select="@label" />&#160;
                                                                                        <xsl:for-each select="PROPERTIES/PROPERTY">
                                                                                            <xsl:if test="@name='value'">
                                                                                                <xsl:value-of select="current()"></xsl:value-of>
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
                                                                <td>
                                                                    <xsl:value-of select="@label" />
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
            </table>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>