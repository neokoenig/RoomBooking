<cfoutput>
#box(title="Update Value for #permission.name#")#
	<div class="row">
		<div class="col-md-4">
			#permission.description#
		</div>
		<div class="col-md-4">
			<cfloop query="allroles">
				#hasManyCheckBox(objectName="permission", association="rolepermissions", keys="#id#,#permission.key()#", label=name)#
			</cfloop>
		</div>
	</div>
#boxEnd()#
</cfoutput>
