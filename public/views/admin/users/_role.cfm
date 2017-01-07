<cfoutput>
#box(title="Role & Permissions")#
	<div class="row">
		<div class="col-md-2">
			#select(objectname="user", property="roleid", options=getRoleDropdownList(), label=l('Role'), includeBlank="--- None ---")#
		</div>
		<div class="col-md-10">
			<p><strong>#l("User Permission Overrides")#</strong></p>
			Matrix?
		</div>
	</div>
#boxEnd()#
</cfoutput>
