<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfoutput>
#errormessagesFor("permission")#
<h3>#permission.id#</h3>
<cfloop list="#application.rbs.roles#" index="i">
#checkbox(objectName="permission", property=i, label=i)#
</cfloop>
<span class="help-block">#permission.notes#</span>
</cfoutput>