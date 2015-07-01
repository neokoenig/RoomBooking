<cfscript>
// RoomBooking System settings

// Default Datasource name as set in /CFIDE/administrator | Railo admin | Lucee admin.
// If you change this before installing, ensure you update request.dsn in /install/index.cfm
set(dataSourceName="roombooking");

// Setting URL rewriting to off by default, as running wheels in a subdirectory requires more complex configuration
set(URLRewriting="off");

// Whether to allow ?reload=production etc via URL. I tend to keep this on.
set(allowedEnvironmentSwitchThroughURL=true);

// Reload Password: you'll definitely want to change this to something unique.
set(reloadPassword="roombooking");

// Environment-agnostic settings
set(assetQueryString=true);

// set to false for plugin development
set(deletePluginDirectories=false);

set(excludeFromErrorEmail="password,hashedpassword,passwordsalt,ssn");

// valid values are "session" or "cookie"
set(flashStorage="session");

set(obfuscateURLs=false);

// set to false for plugin development
set(overwritePlugins=true);

// Highlight defaults
set(functionName="highlight", tag="mark");
// Bootstrap 3 form defaults
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