<!---================= Room Booking System / https://github.com/neokoenig =======================--->


<!---================================ Bootstrap Helpers ======================================--->
<cffunction name="panel" hint="Renders a bootstrap Panel">
	<cfargument name="title" required="true">
	<cfargument name="class" default="panel-primary">
	<cfset var r ="">
	<cfsavecontent variable="r"><Cfoutput>
	<!--- Start Panel --->
	<div class="panel #arguments.class#">
		<div class="panel-heading">
			<h3 class="panel-title">#arguments.title#</h3>
		</div>
		<div class="panel-body">
	</Cfoutput>
	</cfsavecontent>
	<cfreturn r />
</cffunction>

<cffunction name="panelend" hint="Close Panel">
	<cfreturn "</div></div>" />
</cffunction>

<!---================================ Date Formatters ======================================--->
<cffunction name="_formatDate" hint="General use date Formatter using user preferences" output="false">
	<cfargument name="d" required="true" hint="A full datetime string">
	<cfscript>
		if(isDate(arguments.d)){
			return dateFormat(arguments.d, "#application.rbs.setting.defaultDateFormat#");
		} else {
			return "";
		}
	</cfscript>
</cffunction>

<cffunction name="_formatTime" hint="General use time Formatter using user preferences"  output="false">
	<cfargument name="d" required="true" hint="A full datetime string">
		<cfscript>
		if(isDate(arguments.d)){
			return timeFormat(arguments.d, "#application.rbs.setting.defaultTimeFormat#");
		} else {
			return "";
		}
	</cfscript>
</cffunction>

<cffunction name="_formatDateTime" hint="General use date and Time Formatter using user preferences"  output="false">
	<cfargument name="d" required="true" hint="A full datetime string">
	 <cfscript>
		if(isDate(arguments.d)){
			return dateFormat(arguments.d, "#application.rbs.setting.defaultDateFormat#") & ' - ' & timeFormat(arguments.d, "#application.rbs.setting.defaultTimeFormat#");
		} else {
			return "";
		}
	</cfscript>
</cffunction>

<cffunction name="_formatDateRange" hint="Format two dates as a single range: i.e, 7th March 2003, 4pm - 9th March 2003, 6pm"  output="false">
	<cfargument name="d1" required="true" hint="A full datetime string">
	<cfargument name="d2" required="true" hint="A full datetime string">
	<cfargument name="allday" required="false" hint="0 or 1" default="0">
	<cfscript>
		local.d1=_formatDate(arguments.d1);
		local.t1=_formatTime(arguments.d1);
		local.d2=_formatDate(arguments.d2);
		local.t2=_formatTime(arguments.d2);
		local.dateTime1=local.d1 & ', ' & local.t1;
		local.dateTime2=local.d2 & ', ' & local.t2;
		if(structKeyExists(arguments, "allDay") AND arguments.allDay){
			local.dateTime1=local.d1 & " (All Day)";
			local.dateTime2=local.d2 & " (All Day)";
		}
		// conditional formatting:
		if(local.dateTime1 EQ local.dateTime2){
			return local.dateTime1;
		} else {
			if(local.d1 EQ local.d2){
				return local.dateTime1 & " - " & local.t2;
			}
			else {
				return local.dateTime1 & " - " & local.dateTime2;
			}

		}
	</cfscript>
</cffunction>

<cffunction name="eToLocal" hint="convert epoc to localtime">
	<cfargument name="e">
	<cfreturn DateAdd("s", arguments.e ,DateConvert("utc2Local", "January 1 1970 00:00"))>
</cffunction>

<cffunction name="_monthList" hint="used in dropdowns filters">
	<cfset var r=[]>
	<Cfset var m={}>
 	<cfloop from="1" to="12" index="i">
 		<cfset m["k"]=i>
 		<cfset m["v"]=monthAsString(i)>
 		<cfset arrayAppend(r, m)>
		<cfset m={}>
 	</cfloop>
 	<Cfreturn r>
</cffunction>

<cffunction name="_yearList" hint="used in dropdowns filters, defaults to now - 5, and now + 5">
 	<cfset var r=[]>
 	<cfloop from="#(year(now()) - 5)#" to="#(year(now()) + 5)#" index="i">
 		<cfset arrayAppend(r, i)>
 	</cfloop>
 	<Cfreturn r>
</cffunction>
<!---================================ Misc ======================================--->
<cffunction name="countryList" output="false" access="public" returnType="any">
<cfset countrylist = "Afghanistan,Aland Islands,Albania,Algeria,American Samoa,Andorra,Angola,Anguilla,Antigua & Barbuda,Argentina,Armenia,Aruba,Australia,Austria,Azerbaijan,Bahamas,Bahrain,Bangladesh,Barbados,Belarus,Belgium,Belize,Benin,Bermuda,Bhutan,Bolivia,Bosnia,Botswana,Brazil,British Virgin Isles,Brunei,Bulgaria,Burkina Faso,Burundi,Cambodia,Cameroon,Canada,Cape Verde,Cayman Islands,Central African Republic,Chad,Chile,China People's Republic of,Colombia,Congo,Cook Islands,Costa Rica,Croatia,Cyprus,Czech Republic,Denmark,Djibouti,Dominica,Dominican Republic,Ecuador,Egypt,El Salvador,Equatorial Guinea,Eritrea,Estonia,Ethiopia,Faeroe Islands,Fiji,Finland,France,French Guiana,French Polynesia,Gabon,Gambia,Georgia,Germany,Ghana,Gibraltar,Greece,Greenland,Grenada,Guadeloupe,Guam,Guatemala,Guernsey,Guinea,Guinea-Bissau,Guyana,Haiti,Honduras,Hong Kong,Hungary,Iceland,India,Indonesia,Iraq,Ireland Republic of,Israel,Italy,Ivory Coast,Jamaica,Japan,Jersey,Jordan,Kazakhstan,Kenya,Kiribati,Kuwait,Kyrgyzstan,Laos,Latvia,Lebanon,Lesotho,Liberia,Liechtenstein,Lithuania,Luxembourg,Macau,Macedonia (Fyrom),Madagascar,Malawi,Malaysia,Maldives,Mali,Malta,Marshall Islands,Martinique,Mauritania,Mauritius,Mexico,Micronesia,Moldova,Monaco,Mongolia,Montenegro,Montserrat,Morocco,Mozambique,N. Mariana Islands,Namibia,Nepal,Netherlands,Netherlands Antilles,New Caledonia,New Zealand,Nicaragua,Niger,Nigeria,Norfolk Island,Norway,Oman,Pakistan,Palau,Panama,Papua New Guinea,Paraguay,Peru,Philippines,Poland,Portugal,Puerto Rico,Qatar,Reunion,Romania,Russia,Rwanda,Samoa,San Marino,Saudi Arabia,Senegal,Serbia,Seychelles,Sierra Leone,Singapore,Slovakia,Solomon Islands,South Africa,South Korea,Spain,Sri Lanka,St. Kitts & Nevis,St. Lucia,St. Vincent/Grenadines,Suriname,Swaziland,Sweden,Switzerland,Syria,Taiwan,Tajikistan,Tanzania,Thailand,Togo,Trinidad & Tobago,Tunisia,Turkey,Turkmenistan,Turks & Caicos Islands,Tuvalu,Uganda,Ukraine,United Arab Emirates,United Kingdom,United States,Uruguay,US Virgin Islands,Uzbekistan,Vanatu,Venezuela,Vietnam,Wallia & Futuna Islands,Yemen,Zambia,Zimbabwe">
<cfreturn countrylist>
</cffunction>

<cffunction name="tickorcross">
	<cfargument name="value">
	<cfscript>
		if(arguments.value){
			return "<span class='label label-success'><span class='glyphicon glyphicon-ok'></span></span>";
		}else {
			return "<span class='label label-danger'><span class='glyphicon glyphicon-remove'></span></span>";
			}
	</cfscript>
</cffunction>