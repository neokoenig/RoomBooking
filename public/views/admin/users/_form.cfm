<cfoutput>
<!---
#textField(objectname='user', property='firstname')#
#textField(objectname='user', property='lastname')#
#textField(objectname='user', property='address1')#
#textField(objectname='user', property='address2')#
#textField(objectname='user', property='city')#
#textField(objectname='user', property='county')#
#textField(objectname='user', property='country')#
#textField(objectname='user', property='tel')#
#textField(objectname='user', property='email')#
#textField(objectname='user', property='www')#
#textField(objectname='user', property='password')#
#textField(objectname='user', property='passwordresettoken')#
#textField(objectname='user', property='apikey')#
--->

#box(title=l("Main Account Details"))#
	<div class="row">
		<div class="col-sm-2">
			#textField(objectname="user", property="title", label=l("Title"), placeholder="e.g Mr")#
		</div>
		<div class="col-sm-4">
			#textField(objectname="user", property="firstname", label=l("First Name") & " *", required="true", placeholder="e.g Joe")#
		</div>
		<div class="col-sm-4">
			#textField(objectname="user", property="lastname", label=l("Last Name") & " *", required="true", placeholder="e.g Bloggs")#
		</div>
	</div>
	<div class="row">
		<div class="col-md-4 col-md-offset-2">
			#textField(objectname="user", property="email", label=l("Email") & " *", type="email", required="true", placeholder="joe@bloggs.com")#
		</div>
		<div class="col-md-4">
			#textField(objectname="user", property="tel", label=l("Phone"), placeholder="+44 (0) 0000 000000")#
		</div>
	</div>
	<div class="row">
		<div class="col-md-6  col-md-offset-2">
			#textField(objectname="user", property="address1", label=l("Address 1"), placeholder="34 Fake Street")#
			#textField(objectname="user", property="address2", label=l("Address 2"), placeholder="Oxford")#
			<div class="row">
				<div class="col-md-4">
					#textField(objectname="user", property="state", label=l("State/County"), placeholder="Oxon or Alabama")#
				</div>
				<div class="col-md-4">
					#textField(objectname="user", property="postcode", label=l("Postcode"), placeholder="OX1 1DP or 90210")#
				</div>
			</div>
			#select(objectname="user", property="country", label=l("Country"), options="test", includeBlank=true)#
		</div>
	</div>

#boxend()#
</cfoutput>
