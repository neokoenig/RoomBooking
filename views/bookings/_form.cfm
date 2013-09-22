<!--- Form--->
<cfparam name="locations">
<cfparam name="event">
<cfoutput>
<div class="row">
	<div class="col-lg-4"> 
		#textField(objectname="event", property="title", label="Event Name", placeholder="i.e Committee Meeting")# 
	</div> 
	<div class="col-lg-4"> 
		#select(objectname="event", property="locationid", options=locations, label="Location")#	
	</div>
	<div class="col-lg-4"> 
		#select(objectname="event", property="layoutstyle", options="Standard,Boardroom,Lecture", label="Layout")#	
	</div>
</div>
<div class="row">
	<div class="col-lg-4"> 
		#textField(objectname="event", property="contactname", label="Contact Name", placeholder="i.e Joe Bloggs")# 
	</div> 
	<div class="col-lg-4"> 
		#textField(objectname="event", property="contactno", label="Tel No.", placeholder="i.e 01865 287430")# 
	</div> 
	<div class="col-lg-4"> 
		#textField(objectname="event", property="contactemail", label="Email", placeholder="i.e joe@bloggs.com")# 
	</div>
</div> 
<div class="datetimeselect clearfix">
	<label>Start Date</label>#dateTimeSelect(objectName="event", property="start", class="form-control")#
</div> 
<div class="datetimeselect clearfix">
	<label>End Date</label>#dateTimeSelect(objectName="event", property="end", class="form-control", includeBlank=true)#
</div> 
#checkbox(objectName="event", property="allDay", label="This is an all day event")# 
#textArea(objectName="event", property="description", label="Description", placeholder="Optional Notes about this event")#

</cfoutput>