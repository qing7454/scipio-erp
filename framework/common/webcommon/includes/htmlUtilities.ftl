<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->


<#--
* 
* A set of utility macros to be used for page rendering.
* Automatically included at all times
*
-->
<#include "component://widget/templates/htmlFormMacroLibrary.ftl"/>
<#include StringUtil.wrapString("component://widget/templates/htmlScreenMacroLibrary.ftl") /> 
<#include StringUtil.wrapString("component://widget/templates/htmlMenuMacroLibrary.ftl") />

<#-- 
*************
* label function
************
Returns empty string if no label is found
-->
<#function label value="">
  <#if value?has_content>
      <#assign var="${uiLabelMap[value]}" />
      <#if var!=value>
        <#return var>
        <#else>
        <#return "">
      </#if>
  <#else>
      <#return ""> 
  </#if>
</#function>
 
<#-- 
******************
* UTILITY MACROS *
******************
-->
<#-- 
*************
* Field Macro
************ 
    Usage example:  
    <@field attr="" />
    
    * General Attributes *
    type            = form element of type [input,textarea,datetime,select,checkbox,radio]
    label           = form label
    columns         = int value for columns for field (overrides classes)
    tooltip         = Small field description - to be displayed to the customer
    name            = field name
    value           = field value
    class           = css classes
    maxlength       = maxLength
    id              = field id
    onClick           = JS Event
    disabled        = field disabled
    placeholder     = field placeholder
    alert           = adds additional css alert class
    mask            = toggles jQuery mask plugin
    size            = size attribute (default: 20)
    collapse        = should the field be collapsing? (default: false)
    norows          = render without the rows-container
    norows          = render without the cells-container
        
    * input *
    autoCompleteUrl = if autocomplete function exists, specification of url will make it available
    postfix          = if set to true, attach submit button (default:false)
    
    * textArea *
    readonly        = readonly
    rows            = number of rows
    cols            = number of columns
    
    * dateTime *
    dateType        = type of datetime [date,time] (default: date)
    
    * select *
    multiple        = allow multiple select true/false
    currentValue    = currently selected value
    
    * lookup *
    formName        = The name of the form that contains the lookup field.
    fieldForName    = Contains the lookup window form name.
    
    * Checkbox *
    currentValue    = Y/N
    checked      = checked (true/false)
    
-->
<#macro field type="" label="" name="" value="" class="${style_grid_large!}12" size=20 maxlength="" id="" onClick="" 
        disabled=false placeholder="" autoCompleteUrl="" mask=false alert="false" readonly=false rows="4" 
        cols="50" dateType="date" multiple="" checked=false collapse=false tooltip="" columns="" norows=false nocells=false
        fieldFormName="" formName="" postfix=false>

<#-- fieldIdNum will always increment throughout the page -->
<#global fieldIdNum=(fieldIdNum!0)+1 />

<#if !id?has_content>
    <#assign id="field_id_${fieldIdNum!0}">
</#if>
<#assign classes = class/>
<#assign columnspostfix=0/>
<#if postfix>
    <#assign columnspostfix=1/>
    <#local collapse=true/>
    <#assign classes="${style_grid_small!}${12-columnspostfix}"/>
</#if>


<@row collapse=collapse!false norows=norows>
    <#if label?has_content>
        <#assign subclasses="${style_grid_small!}3 ${style_grid_large!}2"/>
        <#assign classes="${style_grid_small!}${9-columnspostfix} ${style_grid_large!}${10-columnspostfix}"/>
        
        <#if columns?has_content>
            <#assign subclasses="${style_grid_small!}${12-columns+1} ${style_grid_large!}${12-columns}"/>
            <#assign classes="${style_grid_small!}${columns-columnspostfix-1} ${style_grid_large!}${columns-columnspostfix}"/>
        </#if>
        
        <#if type!="radio">
        <@cell class=subclasses nocells=nocells>
                <#if type=="checkbox" || collapse==false>
                    <label class="" for="${id}">${label}</label>
                <#else>
                    <span class="prefix">${label}</span>
                </#if>           
        </@cell>
        </#if>
    </#if>
    <@cell class="${classes!}" nocells=nocells>
        <#switch type>
          <#case "input">
                <@renderTextField name=name 
                                  className=class 
                                  alert=alert 
                                  value=value 
                                  textSize=size 
                                  maxlength=maxlength 
                                  id=id 
                                  event="onCLick" 
                                  action=onCLick 
                                  disabled=disabled 
                                  clientAutocomplete="" 
                                  ajaxUrl=autoCompleteUrl 
                                  ajaxEnabled="" 
                                  mask=mask 
                                  placeholder=placeholder 
                                  tooltip=tooltip/>
            <#break>
          <#case "textarea">
            <@renderTextareaField name=name 
                                  className=class 
                                  alert=alert 
                                  cols=cols 
                                  rows=rows 
                                  id=id 
                                  readonly=readonly 
                                  value=value 
                                  tooltip=tooltip/>
            <#break>
          <#case "datetime">
            <#if dateType == "date"><#assign shortDateInput=true/><#else><#assign shortDateInput=false/></#if>
            <@renderDateTimeField name=name 
                                  className=class 
                                  alert=alert 
                                  title=label 
                                  value=value 
                                  size=size 
                                  maxlength=maxlength 
                                  id=id 
                                  dateType=dateType 
                                  shortDateInput=shortDateInput 
                                  timeDropdownParamName="" 
                                  defaultDateTimeString="" 
                                  localizedIconTitle="" 
                                  timeDropdown="" 
                                  timeHourName="" 
                                  classString="" 
                                  hour1="" 
                                  hour2="" 
                                  timeMinutesName="" 
                                  minutes="" 
                                  isTwelveHour="" 
                                  ampmName="" 
                                  amSelected="" 
                                  pmSelected="" 
                                  compositeType="" 
                                  formName=""
                                  tooltip=tooltip/>                
            <#break>
          <#case "select">
            <@renderDropDownField name=name
                                    className=class 
                                    alert=alert 
                                    id=id 
                                    multiple=multiple
                                    formName=""
                                    otherFieldName="" 
                                    event="onClick" 
                                    action=onCLick  
                                    size=size
                                    firstInList="" 
                                    currentValue="" 
                                    explicitDescription="" 
                                    allowEmpty=""
                                    options=[]
                                    fieldName=name
                                    otherFieldName="" 
                                    otherValue="" 
                                    otherFieldSize=0 
                                    dDFCurrent=""
                                    ajaxEnabled=false
                                    noCurrentSelectedKey=""
                                    ajaxOptions=""
                                    frequency=""
                                    minChars=""
                                    choices="" 
                                    autoSelect=""
                                    partialSearch=""
                                    partialChars=""
                                    ignoreCase=""
                                    fullSearch=""
                                    tooltip=tooltip><#nested></@renderDropDownField>
            <#break>
          <#case "lookup">
            <@renderLookupField name=name formName=formName fieldFormName=fieldFormName className=class alert="false" value=value size=size?string maxlength=maxlength id=id event="onClick" action=onClick />
          <#break>
          <#case "checkbox">
                <@renderCheckBox id=id currentValue=value checked=checked name=name action=action />
            <#break>
          <#case "radio">
            <#assign items=[{"key":value, "description":label!""}]/>
                <@renderRadioField items=items className=class alert=alert currentValue=(checked?string(value,"")) noCurrentSelectedKey="" name=name event="" action="" tooltip=tooltip />
            
            <#break>
          <#default>
            <#if value?has_content>
                <@renderField text=value/>
            <#else>
                <#nested />
            </#if>
        </#switch>
     </@cell>
     <#if postfix && !nocells>
         <@cell class="${style_grid_small!}1">
                <span class="postfix"><input type="submit" class="fa fa-button" value="&#xf085;"/</span>
         </@cell>
     </#if>
</@row>
</#macro>

<#-- 
*************
* Fieldset Macro
************
    Usage example:  
    <@fieldset title="">
        Inner Content
    </@fieldset>            
                    
   * General Attributes *
    class           = css classes
    id              = set id
    title           = fieldset-title
    collapsed       = show/hide the fieldset
-->
<#macro fieldset id="" title="" class="" collapsed=false>
    <@renderFieldGroupOpen style=class id=id title=title collapsed=collapsed collapsibleAreaId="" collapsible=false expandToolTip="" collapseToolTip=""/>
        <#nested />
    <@renderFieldGroupClose style="" id="" title=""/>
</#macro>


<#--
*************
* Row Macro
************
    Usage example:  
    <@row attr="" >
        <@cell attr=""/>
    </@row>              
                    
   * General Attributes *
    class           = css classes
-->
<#macro row class="" id="" collapse=false norows=false>
    <#if !norows>
    <div class="${style_grid_row!} <#if class?has_content> ${class!}</#if><#if collapse> collapse</#if>"<#if id?has_content> id="${id}"</#if>><#rt/>
    </#if>
        <#nested />
    <#if !norows>    
    </div>
    </#if>    
</#macro>


<#-- 
*************
* Cell Macro
************
    Usage example:  
    <@row attr="" >
        <@cell attr="">
            cell content goes in here!
        </@cell>
    </@row>              
                    
   * General Attributes *
    class           = css classes
    columns         = expected number of columns to be rendered (default 12)
    offset          = offset in number of columns
-->
<#macro cell columns=12 offset=0 class="" id="" collapse=false nocells=false>
    <#if !nocells><div class="<#if class?has_content>${class!}<#else>${style_grid_large!}${columns!12}</#if><#if offset&gt;0>${style_grid_offset!}${offset!}</#if> ${style_grid_cell!}" <#if id?has_content> id="${id}"</#if>><#rt/></#if>
        <#nested />
    <#if !nocells></div></#if>
</#macro>



<#-- 
*************
* Section Macro
************
    Usage example:  
    <@section attr="">
        Inner Content
    </@section>            
                    
   * General Attributes *
    class           = css classes
    id              = set id
    padded          = 
-->
<#macro section id="" title="" classes="" padded=false>
    <@renderScreenletBegin id=id title=title classes=classes padded=padded/>
        <#nested />
    <@renderScreenletEnd />
</#macro>


<#-- 
*************
* Modal Macro
************
    Usage example:  
    <@modal id="dsadsa" attr="" >
    modal Content 
    </@modal>                
   * General Attributes *
    id              = set id (required)
    label           = set anchor text (required)
-->
<#macro modal id label href="">
    <a href="#" data-reveal-id="${id}_modal" <#if href?has_content>data-reveal-ajax="${href!}"</#if>>${label}</a>
    <div id="${id}_modal" class="${style_modal_wrap!}" data-reveal>
        <#nested>
        <a class="close-reveal-modal">&#215;</a>
    </div>
</#macro>


<#-- 
*************
* Pagination Macro
************
    Usage example:  
    <@paginate >            
                    
   * General Attributes *
   url             = Base Url to be used for pagination
   class           = css classes
   listSize        = size of the list in total
   viewIndex       = page currently displayed
   viewSize        = maximum number of items displayed
   altParam        = Use viewIndex/viewSize as parameters, instead of VIEW_INDEX / VIEW_SIZE
-->
<#macro paginate url="" class="nav-pager" viewIndex=0 listSize=0 viewSize=1 altParam=false>
    <#local viewIndexLast = ((listSize/viewSize)?ceiling)>
    <#if altParam>
        <#local viewIndexString = "viewIndex">
        <#local viewSizeString = "viewSize">
    <#else>
        <#local viewIndexString = "VIEW_INDEX">
        <#local viewSizeString = "VIEW_SIZE">
    </#if>
    <#if (viewIndexLast > (viewIndex))>
        <#local viewIndexNext = (viewIndex+1)>
    <#else>
        <#local viewIndexNext = viewIndex>
    </#if>
    <#if (viewIndex > 0)>
        <#local viewIndexPrevious = (viewIndex-1)>
    <#else>
        <#local viewIndexPrevious = viewIndex>
    </#if>
    <#if (url?has_content)>
        <#if (!firstUrl?has_content)>
            <#local firstUrl=url+"?${viewSizeString}=${viewSize}&amp;${viewIndexString}=0"/>
        </#if>
        <#if (!previousUrl?has_content)>
             <#local previousUrl=url+"?${viewSizeString}=${viewSize}&amp;${viewIndexString}=${viewIndexPrevious}"/>
        </#if>
        <#if (!nextUrl?has_content)>
            <#local nextUrl=url+"?${viewSizeString}=${viewSize}&amp;${viewIndexString}=${viewIndexNext}"/>
        </#if>
        <#if (!lastUrl?has_content)>
            <#local lastUrl=url+"?${viewSizeString}=${viewSize}&amp;${viewIndexString}=${viewIndexLast}"/>
        </#if>
        <#if (!selectUrl?has_content)>
            <#local selectUrl=url+"?${viewSizeString}=${viewSize}&amp;${viewIndexString}="/>
        </#if>
        <#if (!selectSizeUrl?has_content)>
            <#local selectSizeUrl=url+"?${viewSizeString}='+this.value+'&amp;${viewIndexString}=0"/>
        </#if>
    </#if>
    <@renderNextPrev ajaxEnabled=false javaScriptEnabled=true paginateStyle="nav-pager" paginateFirstStyle="nav-first" viewIndex=viewIndex highIndex=0 listSize=listSize viewSize=viewSize ajaxFirstUrl="" firstUrl=firstUrl paginateFirstLabel=uiLabelMap.CommonFirst paginatePreviousStyle="nav-previous" ajaxPreviousUrl="" previousUrl=previousUrl paginatePreviousLabel=uiLabelMap.CommonPrevious pageLabel="" ajaxSelectUrl="" selectUrl=selectUrl ajaxSelectSizeUrl="" selectSizeUrl=selectSizeUrl commonDisplaying="" paginateNextStyle="nav-next" ajaxNextUrl="" nextUrl=nextUrl paginateNextLabel=uiLabelMap.CommonNext paginateLastStyle="nav-last" ajaxLastUrl="" lastUrl=lastUrl paginateLastLabel=uiLabelMap.CommonLast paginateViewSizeLabel=""/>
</#macro>


<#-- 
*************
* alert box
************
    Usage example:  
    <@alert type="">
        <#nested>
    </@alert>            
                    
   * General Attributes *
    type           = (info|success|warning|secondary|alert)
    
-->
<#macro alert type="">
<div class="${style_grid_row!}">
        <div class="${style_grid_large!}12 ${style_grid_cell!}">
        <div data-alert class="${style_alert_wrap!} ${style_alert_prefix_type!}${type}">
           <div class="${style_grid_row!}">
              <div class="${style_grid_large!}12 ${style_grid_cell!}">
                  <#nested>
                  <a href="#" class="close">&times;</a>
                </div>
          </div>
        </div>
      </div>
    </div>
</#macro>

<#--
*************
* panel box
************
    Usage example:  
    <@panel type="">
        <#nested>
    </@panel>            
                    
   * General Attributes *
    type           = (callout|) default:empty
    title          = Title
-->
<#macro panel type="" title="">
<div class="${style_panel_wrap!} ${type}">
  <div class="${style_panel_head!}"><#if title?has_content><h5 class="${style_panel_title!}">${title!}</h5></#if></div>
  <div class="${style_panel_body!}"><p><#nested></p></div>
</div>
</#macro>


<#-- 
*************
* pricing table
************
Since this is very foundation specific, this function may be dropped in future installations

    Usage example:  
    <@pul >
        <#pli>Text or <a href="">Anchor</a></#pli>
    </@pul>            
                    
   * General Attributes *
    title           = fieldset-title
    
-->

<#macro pul title="">
          <ul class="${style_pricing_wrap!}">
              <@pli type="title">${title!}</@pli>
              <#nested>
          </ul>
</#macro>

<#macro pli type="">
    <#switch type>
          <#case "price">
              <li class="${style_pricing_price!}"><#nested></li>
          <#break>
          <#case "description">
              <li class="${style_pricing_description!}"><#nested></li>
          <#break>
          <#case "title">
              <li class="${style_pricing_title!}"><#nested></li>
          <#break>
          <#case "button">
              <li class="${style_pricing_cta!}"><#nested></li>
          <#break>        
          <#default>
              <li class="${style_pricing_bullet!}"><#nested></li>
          <#break>
    </#switch>
</#macro>

<#-- 
*************
* Grid list
************
Since this is very foundation specific, this function may be dropped in future installations

    Usage example:  
    <@grid>
        <li>Text or <a href="">Anchor</a></li>
    </@grid>            
                    
   * General Attributes *
    class           = Adds classes - please use "(small|medium|large)-${style_grid_block!}#"
    columns         = Number of columns (default 5)
    type            = (tiles|) default:empty
    
-->
<#macro grid type="" class="" columns=4>
    <#if type=="tiles" || type="freetiles">
        <#global freewallNum="${(freewallNum!0)+1}" />
        <#assign id="freewall_id_${freewallNum!0}">
        <div class="${style_tile_container!}" id="${id!}">
            <#nested>
        </div>
        <script>
         $(function() {
            $('#${id}').freetile({
                selector: '.${style_tile_wrap!}'
            });
            <#--
            Alternative implementation of gridster.js
            $('#${id}').gridster({
                widget_selector: '.${style_tile_wrap!}',
                min_cols:${columns},
                autogenerate_stylesheet:false
            }).disable();
            -->
         });
        </script>
    <#else>
        <#assign defaultClass="${style_grid_small!}${style_grid_block!}2 ${style_grid_medium!}${style_grid_block!}4 ${style_grid_large!}${style_grid_block!}5">
            <#if columns-2 &gt; 0>
                <#local class="${style_grid_small!}${style_grid_block!}${columns-2} ${style_grid_medium!}${style_grid_block!}${columns-1} ${style_grid_large!}${style_grid_block!}${columns}"/>
            <#else>
                <#local class="${style_grid_large!}${style_grid_block!}${columns}"/>
            </#if>
          <ul class="${class!defaultClass!}">
              <#nested>
          </ul>
    </#if>
</#macro>


<#-- 
*************
* Nav list
************
Since this is very foundation specific, this function may be dropped in future installations

    Usage example:  
    <@nav type="">
        <li>Text or <a href="">Anchor</a></li>
    </@nav>
    
    Or:
    <@nav type="magellan">
        <@mli arrival="MyTargetAnchor">Text or <a href="">Anchor</a></@mli>
    </@nav>
    
    <h3 ${mtarget("id")}>Jump Destination</h3>           
                    
   * General Attributes *
    type            = (inline|magellan|breadcrumbs) (default:inline)
    class           = Adds classes - please use "(small|medium|large)-block-grid-#"    
-->
<#macro nav type="inline">
    <#switch type>
        <#case "magellan">
            <div data-magellan-expedition="fixed">
              <dl class="sub-nav">
                <#nested>
              </dl>
            </div>
        <#break>
        <#case "breadcrumbs">
            <ul class="${style_nav_breadcrumbs!}">
                <#nested>
            </ul>
        <#break>
        <#default>
            <ul class="${style_list_inline!} ${style_nav_subnav!}">
              <#nested>
            </ul>
        <#break>
    </#switch>
</#macro>

<#macro mli arrival="">
    <dd data-magellan-arrival="${arrival!}"><#nested></dd>
</#macro>

<#function mtarget id>
  <#assign returnValue="data-magellan-destination=\"${id}\""/>
  <#return returnValue>
</#function>


<#-- 
*************
* Code Block
************
Creates a very basic wrapper for code blocks
    Usage example:  
    <@code type="java">
       //Some java content
    </@code>
                    
   * General Attributes *
    type            = (html|java|css|javascript|log) (default:html) 
-->
<#macro code type="html">
    <pre><code data-language="${type!}"><#compress>
    <#nested>
    </#compress>
    </code></pre>
</#macro>

<#-- 
*************
* Tile
************
Creates a very basic wrapper for tiles (can be used in metro designs).
Please be aware that this is neither based on standard bootstrap, nor foundation. 
It is loosely based on http://metroui.org.ua/tiles.html 

    Usage example:  
    <@tile type="small">
       // content
    </@tile>
                    
   * General Attributes *
    type            = (small|normal|wide|large|big|super) (default:normal)
    title           = Title
    class           = css classes
    link            = Link URL
    id              = field id
    color           = (0|1|2|3|4|5|6|7) defaul:0 (empty)   
    icon            = Set icon code (http://zurb.com/playground/foundation-icon-fonts-3)
    image           = Set a background image-url (icon won't be shown if not empty)
-->
<#macro tile type="normal" title="" class="" id="" link="" color=0 icon="" image="">
    <#assign nested><#nested></#assign>
    <div class="${style_tile_wrap!} ${style_tile_wrap!}-${type!}<#if class?has_content> ${class!}</#if> ${style_tile_color!}${color!}"<#if id?has_content> id="${id!}"</#if> data-sizex="${calcTileSize("x",type!)}" data-sizey="${calcTileSize("y",type!)}">
        <#if image?has_content><div class="${style_tile_image!}" style="background-image: url(${image!})"></div></#if>
        <div class="${style_tile_content!}">
            <#if link?has_content><a href="${link!}"></#if>
            <#if icon?has_content && !icon?starts_with("AdminTileIcon") && !image?has_content><span class="${style_tile_icon!}"><i class="${icon!}"></i></span></#if>
            <#if nested?has_content><span class="${style_tile_overlay!}"><#nested></span></#if>
            <#if title?has_content><span class="${style_tile_title!}">${title!}</span></#if>
            <#if link?has_content></a></#if>
        </div>
    </div>  
</#macro>

<#function calcTileSize type="x" value="normal">
    <#assign tileSizeX={"small":0,"normal":1,"wide":2,"large":2,"big":3,"super":4}/>
    <#assign tileSizeY={"small":0,"normal":1,"wide":1,"large":2,"big":3,"super":4}/>
    <#if type="x">
        <#return tileSizeX[value]/>
    <#else>
        <#return tileSizeY[value]/>
    </#if>
</#function>

<#-- 
*************
* Chart Macro
************
! The implementation is still experimental and requires the proper includes to actually work.

http://zurb.com/playground/pizza-amore-charts-and-graphs

    Usage example:  
    <@chart type="bar" >
        <@chartdata value="36" title="Peperoni"/> 
    </@chart>              
                    
   * General Attributes *
    type           = (pie|bar|line) (default:pie)
    library        = (foundation|chart) (default:chart)
    title          = Data Title  (default:empty)
-->

<#macro chart type="pie" library="chart" title="">
    <#global fieldIdNum=(fieldIdNum!0)+1 />
    <#global chartLibrary = library!/>
    <#if library=="foundation">
        <@row>
        <@cell columns=3>    
        <ul data-${type!}-id="chart_${fieldIdNum!}" class="${style_chart_legend!}">
            <#nested/>
        </ul>
        </@cell>
        <@cell columns=9><div id="chart_${fieldIdNum!}" style="min-height:150px;"></div></@cell>
        </@row>
    <#else>
        <#global chartId = "chart_${fieldIdNum!}"/>
        <#global chartType = type/>
        <canvas id="${chartId!}" class="${style_grid_large!}12 chart-data" height="150"></canvas>
        <script>
            $(function(){
                var chartDataEl = $('.chart-data:first-of-type');
                var chartData = chartDataEl.sassToJs({pseudoEl:":before", cssProperty: "content"});
                var options ={
                    animation: false,
                    scaleLineColor: chartData.scaleLineColor,
                    scaleFontFamily: chartData.scaleFontFamily,
                    scaleFontSize: chartData.scaleFontSize,
                    scaleFontColor: chartData.scaleFontColor,
                    responsive: true,
                    maintainAspectRatio: true,
                    showTooltips: true,
                    tooltipEvents: ["mousemove", "touchstart", "touchmove"],
                    tooltipFillColor: chartData.tooltipFillColor,
                    tooltipFontFamily: chartData.tolltipFontFamily,
                    tooltipFontSize: chartData.tooltipFontSize,
                    tooltipFontStyle: "normal",
                    tooltipFontColor: chartData.tooltipFontColor,
                    tooltipTitleFontFamily: chartData.tooltipTitleFontFamily,
                    tooltipTitleFontSize: chartData.tooltipTitleFontSize,
                    tooltipTitleFontStyle: chartData.tooltipTitleFontStyle,
                    tooltipTitleFontColor: chartData.tooltipTitleFontColor,
                    tooltipYPadding: 6,
                    tooltipXPadding: 6,
                    tooltipCaretSize: 8,
                    tooltipCornerRadius: 6,
                    datasetFill : true,
                    tooltipTemplate: "<%if (label){%><%=label%>: <%}%><%= value %>",
                    multiTooltipTemplate: "<%= value %>",
                    bezierCurve : false,
                    legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<datasets.length; i++){%><li><span style=\"background-color:<%=datasets[i].strokeColor%>\"></span><%if(datasets[i].label){%><%=datasets[i].label%><%}%></li><%}%></ul>"
                    };
                var ctx_${fieldIdNum!} = $('#${chartId!}').get(0).getContext("2d");
                <#if type=="pie">
                var data = [];
                <#else>
                var data = {
                        labels :[],
                        datasets: [
                            {
                              label: "",
                              fillColor: chartData.fillColor,
                              strokeColor: chartData.strokeColor,
                              pointColor: chartData.pointColor,
                              pointStrokeColor: chartData.pointStrokeColor,
                              pointHighlightFill: chartData.pointHighlightFill,
                              pointHighlightStroke: chartData.pointHighlightStroke,
                              data: []
                            }
                            ]
                    };
                </#if>
                var ${chartId!} = new Chart(ctx_${fieldIdNum!})<#if type=="bar">.Bar(data,options);</#if><#if type=="line">.Line(data,options);</#if><#if type=="pie">.Pie(data,options);</#if>
                <#nested/>
            });
        </script>
    </#if>
</#macro>

<#macro chartdata title value value2="">
    <#if chartLibrary=="foundation">
        <li <#if value2?has_content>data-y="${value!}" data-x="${value2!}"<#else>data-value="${value!}"</#if>>${title!}</li>
    <#else>
        <#if chartType="line" || chartType="bar">
            ${chartId!}.addData([<#if value?has_content>${value!}</#if>]<#if title?has_content>,"${title!}"</#if>);
        <#else>
            ${chartId!}.addData({value:${value!},color:"#F7464A",highlight: "#FF5A5E"<#if title?has_content>,label:"${title!}"</#if>});
        </#if>
    </#if>
</#macro>



<#-- UTLITY MACROS END -->


