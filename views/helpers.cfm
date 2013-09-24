<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Place helper functions here that should be available for use in all view pages of your application --->
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

<cffunction name="formatDate">
	<cfargument name="d" required="true">
	<cfif isDate(arguments.d)> 
	<cfreturn dateFormat(arguments.d, "dd mmm yyyy") & ' - ' & timeFormat(arguments.d, "HH:MM")> 
	</cfif>
</cffunction>

<cffunction name="eToLocal" hint="convert epoc to localtime">
	<cfargument name="e">
	<cfreturn DateAdd("s", arguments.e ,DateConvert("utc2Local", "January 1 1970 00:00"))>
</cffunction>