<!--- My Account --->
<cfoutput>  
#errorMessagesFor("user")#
<div class="row">
	<div class="col-lg-9">
	#startFormTag(route="updateaccount")#
		#includePartial("formparts/main")#  
		#submitTag(value="Update My Details")#
	#endFormTag()#
	</div>
	<div class="col-lg-3"> 
		#panel(title="Change Password")# 
			#startFormTag(route="updatepassword")#
				#passwordFieldTag(name="password", label="Password", required=true)#
				#passwordFieldTag(name="passwordConfirmation", label="Confirm Password", required=true)# 
				#submitTag(value="Update Password")#	
			#endFormTag()#
		#panelend()# 
	</div>
</div>
</cfoutput>

