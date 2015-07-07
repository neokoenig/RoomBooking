<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- User Role --->
<Cfoutput>
#panel(title="Role & Permissions")#
#select(objectname="user", property="role", options=roles, label=l("Role") & " *", required="true")#
#panelEnd()#
</cfoutput>