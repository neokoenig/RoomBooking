<!--- Event Details --->
<cfoutput>
	<fieldset>
		<legend>Event Details</legend>


<div class="row">
	<div class="col-md-4">
		#textField(objectname="event", property="title", label="Event Title *", placeholder="e.g Committee Meeting", data_bv_notempty="true",  data_bv_notempty_message="Required Field")#
	</div>
	<div class="col-md-4">
		#select(objectname="event", property="locationid", options=locations, label="Location")#
	</div>
	<div class="col-md-4">
		#select(objectname="event", property="layoutstyle", options="#application.rbs.setting.roomlayouttypes#", label="Layout")#
	</div>
</div>

<div class="row">
	<div class="col-md-4">
		#textField(objectName="event", property="start",   data_date_format="DD MMM YYYY HH:mm", label="Starts *")#
	</div>
	<div class="col-md-4">
		#textField(objectName="event", property="end",   data_date_format="DD MMM YYYY HH:mm", label="Ends *")#
	</div>
	<div class="col-md-4">
		#checkbox(objectName="event", property="allDay", label="This is an all day event")#
	</div>
</div>

		#textArea(objectName="event", property="description", label="Description", placeholder="Optional Notes about this event")#


</fieldset>

</cfoutput>