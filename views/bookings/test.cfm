<!--- Test --->
<cfset events=model("events").findAll(select="id, start, end, title, locationid", where="start > '#now()#'", order="start")>

<cfloop query="events">
	<cfoutput>
		#id# #start# #end# #title#<br />
	</cfoutput>
</cfloop>
<cfset timeslot=createDateTime(2014,11,15,15,30,00)>
<cfquery dbtype="query" name="test">
SELECT * FROM events WHERE
start <=
<cfqueryparam cfsqltype="cf_sql_timestamp" value="#timeSlot#">
AND end >=
<cfqueryparam cfsqltype="cf_sql_timestamp" value="#dateAdd("n", 15, timeslot)#">;
</cfquery>
<cfdump var="#test#">