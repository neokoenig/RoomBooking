<!--- Event Details --->
<cfoutput>
	<fieldset>
		<legend>Contact Details</legend>
	<div class="row">
		<div class="col-lg-4 col-md-4">
			#textField(objectname="event", property="contactname", label="Contact Name", placeholder="e.g Joe Bloggs")#
		</div>
		<div class="col-lg-4 col-md-4">
			#textField(objectname="event", property="contactno", label="Tel No.", placeholder="e.g 01865 287430")#
		</div>
		<div class="col-lg-4 col-md-4">
			#textField(objectname="event", property="contactemail", label="Email", placeholder="e.g joe@bloggs.com")#
		</div>
	</div>
	<cfif params.action EQ "add" OR params.action EQ "create">
		#checkbox(objectName="event", property="emailContact", label="Send Confirmation Email to Contact")#
			<cfif application.rbs.setting.isDemoMode>
				<p class="help-block">No emails will be sent in demo mode</p>
			</cfif>
	</cfif>
	</fieldset>


</cfoutput>