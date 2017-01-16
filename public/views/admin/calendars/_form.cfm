<cfoutput>
#box(title=l("Main Calendar Details"))#
	<div class="row">
		<div class="col-sm-4">
			#textField(objectname="calendar", property="title", label=l("Title") & " *", placeholder="My Calendar", required="true")#
		</div>
		<div class="col-sm-8">
			#textField(objectname="calendar", property="description", label=l("Description"), placeholder="Optional Description")#
		</div>
	</div>
#boxend()#

#includePartial(objectname="calendar", partial="/common/form/owner")#

#box(title=l("Preferences"))#
	<div class="row">
		<div class="col-md-3">
			#select(objectname="calendar", property="template", label=l("Template"), options="fullcalendar,yearcalendar")#
		</div>
		<div class="col-md-3">
			#textField(objectname="calendar", property="icon", label=l("Icon"))#
		</div>
	</div>
#boxend()#

#box(title=l("Calendar Settings"))#
<cfdump var="#settings#">
<cfloop query="settings">
	#hasManyCheckBox(objectName="calendar", association="calendarsettings", keys="#calendar.key()#,#id#", label=name)#
</cfloop>
Override default settings for Calendar_
#boxend()#

#box(title=l("Buildings & Rooms"))#
<div class="row">

<div class="col-md-4">
	<div id="buildingselector">
		<cfloop query="allbuildings">
			#hasManyCheckBox(objectName="calendar", association="calendarbuildings", keys="#calendar.key()#,#id#", label=title)#
		</cfloop>
	</div>
</div>
<div class="col-md-4">
	<div id="roomselector">
		<cfloop query="allrooms">
			#hasManyCheckBox(objectName="calendar", association="calendarrooms", keys="#calendar.key()#,#id#", label=title)#
		</cfloop>
	</div>
</div>
</div>
#boxEnd()#

</cfoutput>

<cfsavecontent variable="request.js.buildingselector">
<script>
$("#buildingselector .checkbox").on("click", function(e){
	console.log($(this).find("[input]").data());
});
</script>
</cfsavecontent>
