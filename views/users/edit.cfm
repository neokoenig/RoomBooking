<cfoutput> 

#startFormTag( controller="users",  action="update", key=user.id)#
#errorMessagesFor("user")#
<div class="row">
	<div class="col-lg-9">
		#includePartial("formparts/main")# 
	</div>
	<div class="col-lg-3">
		#includePartial("formparts/userrole")#   
	</div>
</div> 
#submitTag(value="Save", class="btn btn-primary")# 
#endFormTag()#				
</cfoutput>