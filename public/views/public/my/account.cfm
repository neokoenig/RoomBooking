<cfparam name="user">
<cfoutput>
#includePartial("header")#
#startFormTag(route="myAccount")#
	#includePartial("/admin/users/form")#
	#submitTag()#
#endFormTag()#
</cfoutput>
