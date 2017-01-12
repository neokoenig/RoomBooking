<cfparam name="allroles">
<cfoutput>
#linkTo(route="newAdminRole", class="btn btn-primary", text="<i class='fa fa-plus'></i> " & l("Create New Role") )#
<hr />
#box(title="Permissions")#
<table id="permissionstable" class="table table-bordered table-striped">
	<thead>
	<tr>
		<th>#l("Name")#</th>
		<cfloop query="allroles">
			<th>#name#</th>
		</cfloop>
		<th>#l("Actions")#</th>
	</tr>
	</thead>
	<tbody>
	<cfloop query="permissions" group="id">
	<cfset qNameArr=listToArray(name, '.')>
		<tr>
			<td><cfloop from="1" to="#arrayLen(qNameArr)#" index="i">
					<cfif i EQ arrayLen(qNameArr)>
						<strong>#qNameArr[i]#</strong>
					<cfelse>
						<span class="text-muted">#qNameArr[i]# <i class="fa fa-angle-double-right"></i> </span>
					</cfif>
				</cfloop>
			</td>
			<cfset roleArr=[]>
			<cfloop><cfset arrayAppend(roleArr, rolename)></cfloop>
			<cfloop query="allroles">
			<td>
				#tickOrCross(arrayFind(roleArr, name))#
			</td>
			</cfloop>
			<td>#linkTo(route="editAdminPermission", key=id, text="<i class='fa fa-edit'></i> " & l("Edit"), class="btn btn-xs btn-primary")#</td>
		</tr>
	</cfloop>
	</tbody>
	</table>
#boxEnd()#

</cfoutput>
