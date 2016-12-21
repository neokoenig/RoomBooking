<cfoutput>
	#linkTo(route="adminUsersRoot", text="<--- Back")#

	#startFormTag(route="adminUsersUpdate", key=user.key())#
		#includePartial("form")#
		#submitTag()#
	#endFormTag()#
</cfoutput>
