<!---all--->
<cfoutput>
<cfset events=model("event").findAll()>
<cfset e=1041497199>
Current Time: #now()#<br />
Current Epoc: #getTickCount()#<br />
Epoc To Local: #DateAdd("s", e ,DateConvert("utc2Local", "January 1 1970 00:00"))#
<hr />
<cfloop query="events">
	<cfoutput>
	Starts: #start#<br />
	Formatted:  #formatDate(start)#<br />
	Epoc: ##
	<hr />
	</cfoutput>
</cfloop>
</cfoutput>
