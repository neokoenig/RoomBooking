<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfoutput>
#errormessagesFor("setting")#
<cfswitch expression="#setting.fieldtype#">
	<cfcase value="integer,string">
		#textField(objectName="setting", property="value", label=setting.id)#
	</cfcase>
	<cfcase value="boolean">
		#select(objectName="setting", property="value", label=setting.id, options="0,1")#
	</cfcase>
</cfswitch>
<span class="help-block">#h(setting.notes)#</span>
</cfoutput>