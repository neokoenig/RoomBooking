<!--- Event Details --->
<cfoutput>
	<fieldset>
		<legend>Contact Details</legend>
	<div class="row">
		<div class="col-md-4">
			#textField(objectname="event", property="contactname", label="Contact Name", placeholder="e.g Joe Bloggs")#
		</div>
		<div class="col-md-4">
			#textField(objectname="event", property="contactno", label="Tel No.", placeholder="e.g 01865 287430")#
		</div>
		<div class="col-md-4">
			#textField(objectname="event", property="contactemail", label="Email", type="email", placeholder="e.g joe@bloggs.com", data_bv_emailaddress="true",  data_bv_emailaddress_message="The value is not a valid email address")#
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