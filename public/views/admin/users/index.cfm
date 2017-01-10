<cfoutput>
	#linkTo(route="newAdminUser", text="<i class='fa fa-plus'></i> " & l("Create New User"), class="btn btn-primary")#
<hr />
	<div id="usertable">
		<cfif users.recordcount>
 			#box(title="Users")#
              <table id="usertable" class="table table-bordered table-striped">
                <thead>
                <tr>
                	<th>#l("First Name")#</th>
                	<th>#l("Last Name")#</th>
                  <th>#l("Email")#</th>
                	<th>#l("Role")#</th>
                	<th>#l("Created")#</th>
                	<th>#l("Actions")#</th>
                </tr>
                </thead>
                <tbody>
                <cfloop query="users">
                <tr>
                  <td>#firstname#</td>
                  <td>#lastname#</td>
                  <td>#email#</td>
                  <td>#name#</td>
                  <td>#LSDateFormat(createdat, "YYYY MM DD")#</td>
                  <td>
                    <div class="btn-group">
                    #linkTo(route="editAdminUser", key=id, text="<i class='fa fa-edit'></i> " & l("Edit"), class="btn btn-xs btn-flat btn-primary")#
                    <button type="button" class="btn btn-xs btn-primary btn-flat dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                      <span class="caret"></span>
                      <span class="sr-only">#l("Advanced")#</span>
                    </button>
                    <ul class="dropdown-menu" role="menu">
                      <li><a href="">Reset Password</a></li>
                      <li><a href="">Edit Permissions</a></li>
                      <li class="divider"></li>
                      <li>
                      <cfif session.user.properties.id NEQ id>
                      #linkTo(route="adminAssume", key=id, text="<i class='fa fa-user-secret'></i> " & l("Assume"))#
                      </cfif>
                    </li>
                      <li><a href="">Disable</a></li>
                    </ul>
                  </div>
                  </td>
                </tr>
                </cfloop>
                </tbody>
              </table>
              #boxEnd()#
		<cfelse>
			#alert(title="No Users Found", content="There aren't any users yet. Maybe create some?")#
		</cfif>
	</div>
</cfoutput>


