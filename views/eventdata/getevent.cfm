<!--- Gets injected into modal--->
<cfparam name="event">
<cfoutput>
<div class="btn-group">
	#linkTo(action="edit", key=event.eventid, text="Edit", controller="bookings", class="btn btn-info")#
</div>
<h4>#event.title#</h4>
<p>#formatDate(event.start)# - #formatDate(event.end)#</p>
<p>Location: #event.name#<br />#event.description#</p>
<p>#event.eventdescription#</p>
</cfoutput>