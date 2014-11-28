<cfoutput>

#startFormTag( controller="users",  action="update", key=user.id, id="userForm")#
#errorMessagesFor("user")#
<div class="row">
	<div class="col-md-9">
		#includePartial("formparts/main")#
	</div>
	<div class="col-md-3">
		#includePartial("formparts/userrole")#
	</div>
</div>
#submitTag(value="Save", class="btn btn-primary")#
#endFormTag()#
</cfoutput>