<cfoutput>
<table class="table table-condensed ">
		<thead>
			<tr>
				<th>Name</th>
				<th>Email</th>
				<th>Role</th>
				<th>API Token</th>
                <th colspan=4>Actions</th>
			</tr>
		</thead>
		<tbody>
			<cfloop query="arguments.users">
				<tr>
					<td>#linkTo(text="#firstname# #lastname#",   controller="users",  action="edit", key=id)#</td>
					<td>#linkTo(text="#email#",   controller="users",  action="edit", key=id)#</td>
					<td>#role#</td>
					<td>#tickorcross(len(apitoken))#</td>
					<td>#_formatDate(createdAt)#</td>
                   <td>

                   	<!-- Split button -->
					<div class="btn-group">
					 #linkTo(text="<span class='glyphicon glyphicon-edit'></span> Edit",   controller="users",  action="edit", key=id, class="btn btn-xs btn-primary")#
					  <button type="button" class="btn btn-xs btn-primary dropdown-toggle" data-toggle="dropdown">
					    <span class="caret"></span>
					  </button>
					  <ul class="dropdown-menu" role="menu">
					  	<li>#linkTo(text="<span class='glyphicon glyphicon-edit'></span> Edit",   controller="users",  action="edit", key=id, class="")#</li>
			  		<cfif !len(deletedAt)>
					  <cfif role NEQ "admin" AND userisInRole("admin")>
					  	<li>#linkTo(text="<span class='glyphicon glyphicon-user'></span> Assume",  controller="users",   action="assumeUser", key=id,  class="")# </li>
					  </cfif>
					  <cfif !len(apitoken)>
					  	<li>#linkTo(text="<span class='glyphicon glyphicon-phone'></span> Generate API Key", controller="users",  action="generateAPIKey", key=id)#</li>
					  	<cfelse>
						<li>#linkTo(text="<span class='glyphicon glyphicon-phone'></span> Re-Generate API Key", controller="users",  action="generateAPIKey", key=id)#</li>
					  </cfif>
					  <cfif checkPermission("accessLogfiles")>
				  		<li>#linkTo(text="<span class='glyphicon glyphicon-th'></span> Activity", controller="logfiles",  action="index", params="type=&userid=#id#&rows=1000")#</li>
					  </cfif>
					    <li class="divider"></li>
					    <li>#linkTo(text="<span class='glyphicon glyphicon-trash'></span> Disable",  controller="users",  action="delete", key=id, class="", confirm="Are you sure you want to disable this account?")#</li>
					 <cfelse>
 						<li>#linkTo(text="<span class='glyphicon glyphicon-trash'></span> Recover", controller="users",   action="recover", key=id, class="", confirm="Are you sure you want to recover this account?")#</li>
					    </cfif>
					  </ul>
					</div>


					</td>
				</tr>
			</cfloop>
		</tbody>
	</table>
</Cfoutput>