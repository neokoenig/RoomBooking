<cfscript>

// Default Datasource name as set in Lucee admin.
set(dataSourceName="roombooking");

// Reload Password: you'll definitely want to change this to something unique.
set(reloadPassword="roombooking");

// Setting URL rewriting to off by default, as running wheels in a subdirectory requires more complex configuration
set(URLRewriting="on");

// Commandbox/Tuckey URL rewrite override - most of the time this will be rewrite.cfm (the default) for apache etc.
if(cgi.server_name CONTAINS "127.0.0.1"){
	set(rewriteFile="index.cfm");
}

// In this app, plugins are part of the source and not designed to be distributed in zip form
set(overwritePlugins=false);
set(deletePluginDirectories=false);

// Override standard JSON mime type with JSONAPI spec
//addFormat(extension="json", mimeType="application/vnd.api+json");

//=====================================================================
//= 	Localisation
//=====================================================================
set(localizatorGetLocalizationFromFile=true);
set(localizatorLanguageDefault="en_GB");
// NB, not putting this in the currentuser scope on purpose.
set(localizatorLanguageSession="session.lang");

//=====================================================================
//= 	Bootstrap 3 form Defaults: this is so you can more easily build
//=		Form fields without having to append/prepend markup
//=====================================================================
set(functionName="startFormTag");
set(functionName="submitTag", class="btn btn-primary", value="Save Changes");
set(functionName="checkBox,checkBoxTag", labelPlacement="aroundRight", prependToLabel="<div class=""checkbox"">", appendToLabel="</div>", uncheckedValue="0");
set(functionName="radioButton,radioButtonTag", labelPlacement="aroundRight", prependToLabel="<div class=""radio"">", appendToLabel="</div>");
set(functionName="textField,textFieldTag,select,selectTag,passwordField,passwordFieldTag,textArea,textAreaTag,fileFieldTag,fileField",
class="form-control",
labelClass="control-label",
labelPlacement="before",
prependToLabel="<div class=""form-group"">",
prepend="",
append="</div>"  );

set(functionName="dateTimeSelect,dateSelect", prepend="<div class=""form-group"">", append="</div>", timeSeparator="", minuteStep="5", secondStep="10", dateOrder="day,month,year", dateSeparator="", separator="");

set(functionName="errorMessagesFor", class="alert alert-dismissable alert-danger"" style=""margin-left:0;padding-left:26px;");
set(functionName="errorMessageOn", wrapperElement="div", class="alert alert-danger");
set(functionName="flash", prepend="<div class=""alert""><a class=""close"" data-dismiss=""alert"">&times;</a>", append="</div>");
set(functionName="flashMessages", prependToValue="<div class=""alert alert-dismissable alert-info""><a class=""close"" data-dismiss=""alert"">&times;</a>", appendToValue="</div>");
set(functionName="paginationLinks", prepend="<ul class=""pagination"">", append="</ul>", prependToPage="<li>", appendToPage="</li>", linkToCurrentPage=true, classForCurrent="active", anchorDivider="<li class=""disabled""><a href=""##"">...</a></li>");
 </cfscript>
