<!--- User Role --->
<Cfoutput>
#panel(title="Role & Permissions")#
#select(objectname="user", property="role", options=roles, label="Role *", required="true")#
#panelEnd()#
</cfoutput>