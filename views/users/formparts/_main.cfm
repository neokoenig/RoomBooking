<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfparam name="user">
<cfset countries=countryList()>
<cfoutput>
#panel(title=l("Main Account Details"))#
			<div class="row">
			<div class="col-md-6">
				#textField(objectname="user", property="firstname", label=l("First Name") & " *", required="true", placeholder="e.g Joe")#
				#textField(objectname="user", property="lastname", label=l("Last Name") & " *", required="true",placeholder="e.g Bloggs")#
				#textField(objectname="user", property="email", label=l("Email") & " *", type="email", required="true",placeholder="joe@bloggs.com")#
				#textField(objectname="user", property="tel", label=l("Phone"), placeholder="+44 (0) 0000 000000")#
			</div>
			<div class="col-md-6">
				#textField(objectname="user", property="address1", label=l("Address 1"), placeholder="34 Fake Street")#
				#textField(objectname="user", property="address2", label=l("Address 2"), placeholder="Oxford")#
				#textField(objectname="user", property="state", label=l("State/County"), placeholder="Oxon or Alabama")#
				#textField(objectname="user", property="postcode", label=l("Postcode"), placeholder="OX1 1DP or 90210")#
				#select(objectname="user", property="country", label=l("Country"), options=countries, includeBlank=true)#
			</div>

			</div>
#panelend()#
</cfoutput>