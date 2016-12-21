<cfoutput>
	#linkTo(route="adminUsersNew", text="<i class='fa fa-plus'></i> " & l("Create New User"), class="btn btn-primary")#

	<div id="userfilter">
		Filters
	</div>

	<div id="usertable">
		<cfif users.recordcount>
			<cfdump var="#users#">
		<cfelse>
			#alert(title="No Users Found", content="There aren't any users yet. Maybe create some?")#
		</cfif>
	</div>
</cfoutput>



USER TABLE
<p>
	hasOne role(rolepermissions) <--- Default role permissions
	hasMany userpermissions <--- Permissions overrides
</p>
<p>
	id<br />
	title<br />
	firstname<br />
	lastname<br />
	address1<br />
	address2<br />
	city<br />
	county<br />
	postcode/zip<br />
	country<br />
	tel<br />
	email<br />
	www<br />
	<br />
	password<br />
	passwordresettoken<br />
	apikey<br />
	roleid<br />
	<br />
	locale<br />
	timezone/offset<br />
	<br />
	lastloggedinat<br />
	createdat<br />
	updatedat<br />
	deletedat<br />
</p>
