<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Room Booking Confirmation--->
<cfparam name="event">
<cfoutput>
#includePartial("/common/email/header")#
<p style="Margin-top: 0;color: ##565656;font-family: sans-serif;font-size: 16px;line-height: 25px;Margin-bottom: 24px">Dear #event.contactName#,</p>
<p style="Margin-top: 0;color: ##565656;font-family: sans-serif;font-size: 16px;line-height: 25px;Margin-bottom: 24px">This is to confirm your room booking:</p>
<h4 style="Margin-top: 0;color: ##565656;font-weight: 700;font-size: 24px;Margin-bottom: 18px;font-family: sans-serif;line-height: 24px">#h(event.title)#</h4>
<p style="Margin-top: 0;color: ##565656;font-family: sans-serif;font-size: 16px;line-height: 25px;Margin-bottom: 24px">#_formatDate(event.start)# - #_formatDate(event.end)#</p>
<p style="Margin-top: 0;color: ##565656;font-family: sans-serif;font-size: 16px;line-height: 25px;Margin-bottom: 24px">Location: #eventlocation.name#, #eventlocation.description#<cfif len(eventlocation.building)><br />#eventlocation.building#</cfif></p>
<cfif len(event.description)><p>#h(event.description)#</p></cfif>
		<h4 style="Margin-top: 0;color: ##565656;font-weight: 700;font-size: 22px;Margin-bottom: 18px;font-family: sans-serif;line-height: 24px">Contact Details:</h4>
			<cfif len(event.contactname) OR len(event.contactemail) OR len(event.contactno)>
				<p style="Margin-top: 0;color: ##565656;font-family: sans-serif;font-size: 16px;line-height: 25px;Margin-bottom: 24px">
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
		<p style="Margin-top: 0;color: ##565656;font-family: sans-serif;font-size: 16px;line-height: 25px;Margin-bottom: 24px">None provided</p>
</cfif>

#includePartial("/common/email/footer")#
</cfoutput>