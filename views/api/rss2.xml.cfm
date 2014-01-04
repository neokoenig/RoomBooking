<cfprocessingdirective suppressWhitespace="true"><cfcontent type="application/rss+xml" reset="true"><?xml version="1.0"?>
<rss version="2.0">
	<channel><cfoutput>
		<title>#application.rbs.setting.sitetitle# Events</title>
		<link>#urlFor(controller="api",  onlyPath=false)#</link>
		<description>#application.rbs.setting.sitedescription#</description>
		<language>en-US</language>
		<copyright>#application.rbs.setting.sitetitle#</copyright>
		<category>Events</category>
		<generator>Room Booking System</generator>
		<docs>http://blogs.law.harvard.edu/tech/rss</docs>
		<ttl>60</ttl>		
		<pubDate>#dateFormat(now(), "ddd, dd mmm yyyy")# #timeFormat(now(), "HH:MM:SS")# UT</pubDate>
    	<lastBuildDate>#dateFormat(now(), "ddd, dd mmm yyyy")# #timeFormat(now(), "HH:MM:SS")# UT</lastBuildDate>
		<cfloop query="data">
			<item>
			<title><![CDATA[#title#]]></title>
			<link>#urlFor(controller="bookings", action="view", key=eventid,  onlyPath=false)#</link>
			<description><![CDATA[#eventdescription#]]></description>
			<category><![CDATA[#name#]]></category>
			<pubDate>#dateFormat(start, "ddd, dd mmm yyyy")# #timeFormat(start, "HH:MM:SS")# UT</pubDate>
			<guid isPermaLink="true">#urlFor(controller="bookings", action="view", key=eventid,  onlyPath=false)#</guid>
		</item> 
		</cfloop> 
	</channel>	
</rss> 
</cfoutput></cfprocessingdirective><cfabort>