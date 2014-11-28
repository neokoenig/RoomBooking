<cfparam name="user">
<cfset countries=countryList()>
<cfoutput>
#panel(title="Main Account Details")#
			<div class="row">
			<div class="col-md-6">
				#textField(objectname="user", property="firstname", label="First Name *", required="true",placeholder="e.g Joe")#
				#textField(objectname="user", property="lastname", label="Last Name *", required="true",placeholder="e.g Bloggs")#
				#textField(objectname="user", property="email", label="Email *", type="email", required="true",placeholder="joe@bloggs.com")#
				#textField(objectname="user", property="tel", label="Phone",placeholder="+44 (0) 0000 000000")#
			</div>
			<div class="col-md-6">
				#textField(objectname="user", property="address1", label="Address 1",placeholder="34 Fake Street")#
				#textField(objectname="user", property="address2", label="Address 2",placeholder="Oxford")#
				#textField(objectname="user", property="state", label="State/County",placeholder="Oxon or Alabama")#
				#textField(objectname="user", property="postcode", label="Postcode",placeholder="OX1 1DP or 90210")#
				#select(objectname="user", property="country", options=countries, includeBlank=true)#
			</div>

			</div>
#panelend()#
</cfoutput>