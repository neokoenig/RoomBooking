<cfparam name="user">
<cfoutput>

#startFormTag( controller="users", action="create", id="userForm")#
#errorMessagesFor("user")#
<div class="row">
	<div class="col-md-9">
		#includePartial("formparts/main")#
	</div>
	<div class="col-md-3">
		#includePartial("formparts/userrole")#

		#includePartial("formparts/userpw")#
	</div>
</div>
#submitTag(value="Create Account", class="btn btn-primary")#
#endFormTag()#
</cfoutput>