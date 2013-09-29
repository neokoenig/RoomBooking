<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- 

Notes
	This CFC should provide json, xml, rss, ical, (+ rendered html?) data dependent on url strings being passed in.
	@format: one of 
--->
<cfcomponent extends="controller">
	<cffunction name="init">
		<cfscript>
			provides("json,xml,html");
		</cfscript>
	</cffunction>
 
<!---================================ Main RSS Feeds ======================================--->
	<cffunction name="index">
		<cfscript>
		var events=model("location").findAll();
		renderwith(data=events, layout=false);
	 	</cfscript> 
	</cffunction>



<!---================================ ical ======================================--->
	<!---
	BEGIN:VCALENDAR
	METHOD:PUBLISH
	CALSCALE:GREGORIAN
	PRODID:-//EVDB//www.eventful.com//EN
	VERSION:2.0
	X-WR-CALNAME:Eventful results for "concert" in "san diego"
	BEGIN:VEVENT
	  DTSTART:20051111T190000
	  DTSTAMP:20050902T183453Z
	  SUMMARY:Rolling Stones
    DESCRIPTION:
    LOCATION:Petco Park (Stones)
    SEQUENCE:0
    UID:E0-001-000318135-0
    URL:http://eventful.com/E0-001-000318135-0
	END:VEVENT
	...
END:VCALENDAR--->

 </cfcomponent>