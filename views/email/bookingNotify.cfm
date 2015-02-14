<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Room Booking Confirmation--->
<cfparam name="event">
<cfoutput>
#includePartial("/common/email/header")#
<p>Dear #event.contactName#,</p>
<p>This is to confirm your room booking:</p>
<h4>#h(event.title)#</h4>
<p>#formatDate(event.start)# - #formatDate(event.end)#</p>
<p>Location: #eventlocation.name#, #eventlocation.description#</p>
<cfif len(event.description)><p>#h(event.description)#</p></cfif>

<h4>Contact Details:</h4>
<cfif len(event.contactname) OR len(event.contactemail) OR len(event.contactno)>
	<p>
<cfif len(event.contactname)>
	#h(event.contactname)#<br />
</cfif>
<cfif len(event.contactemail)>
	#autolink(event.contactemail)#<br />
</cfif>
<cfif len(event.contactno)>
	#h(event.contactno)#
</cfif>
</p>
	<cfelse>
		<p>None provided</p>
</cfif>

#includePartial("/common/email/footer")#
</cfoutput>