<!---
	If you leave these settings commented out, Wheels will set the data source name to the same name as the folder the application resides in.

	<cfset set(dataSourceUserName="")>
	<cfset set(dataSourcePassword="")>
--->

<!---
	If you leave this setting commented out, Wheels will try to determine the URL rewrite capabilities automatically.
	The URLRewriting setting can bet set to "On", "Partial" or "Off".
	To run with "Partial" rewriting, the "PATH_INFO" variable needs to be supported by the web server.
	To run with rewriting "On", you need to apply the necessary rewrite rules on the web server first.
	<cfset set(URLRewriting="Partial")>
--->
<cfscript>
set(dataSourceName="roombooking");
set(URLRewriting="on");
set(allowedEnvironmentSwitchThroughURL=true);
set(reloadPassword="roombooking");

// Environment-agnostic settings
set(assetQueryString=true);
set(deletePluginDirectories=false); // set to false for plugin development
set(excludeFromErrorEmail="password,hashedpassword,passwordsalt,ssn");
set(flashStorage="session"); // valid values are "session" or "cookie"
set(obfuscateURLs=false);
set(overwritePlugins=true); // set to false for plugin development

// BS3 form settings
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