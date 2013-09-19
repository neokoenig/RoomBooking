<!--- Form--->
<cfparam name="locations">
<cfparam name="event">
<cfoutput>
#textField(objectname="event", property="title", label="Event Name", placeholder="i.e Committee Meeting")# 
#select(objectname="event", property="locationid", options=locations, label="Location")#	
 

<div class="datetimeselect clearfix">
	<label>Start Date</label>#dateTimeSelect(objectName="event", property="start", class="form-control")#
</div>


<div class="datetimeselect clearfix">
	<label>End Date (optional)</label>#dateTimeSelect(objectName="event", property="end", class="form-control", includeBlank=true)#
</div>

#checkbox(objectName="event", property="allDay", label="This is an all day event")#

#textArea(objectName="event", property="description", label="Description", placeholder="Optional Notes about this event")#
</cfoutput>