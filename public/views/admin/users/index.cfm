<cfoutput>
	#linkTo(route="newAdminUser", text="<i class='fa fa-plus'></i> " & l("Create New User"), class="btn btn-primary btn-flat")#
<hr />
    #includePartial("filter")#
	<div id="usertable">
		<cfif users.recordcount>
 			#box(title="Users")#
      #paginationLinks()#
              <table id="usertable" class="table table-bordered table-striped  table-condensed">
                <thead>
                <tr>
                	<th>#l("First Name")#</th>
                	<th>#l("Last Name")#</th>
                  <th>#l("Username")#</th>
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
                  <td>#username#</td>
                  <td>#truncate(email, 50)#</td>
                  <td>#name#</td>
                  <td>#LSDateFormat(createdat)#</td>
                  <td>
                    <cfif !len(deletedAt)>
                    <div class="btn-group">
                    #linkTo(route="editAdminUser", key=id, text="<i class='fa fa-edit'></i> " & l("Edit"), class="btn btn-xs btn-flat btn-primary")#
                    <button type="button" class="btn btn-xs btn-primary btn-flat dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                      <span class="caret"></span>
                      <span class="sr-only">#l("Advanced")#</span>
                    </button>
                    <ul class="dropdown-menu" role="menu">
                      <li><a href="">TODO: Reset Password</a></li>
                      <li><a href="">TODO: Edit Permissions</a></li>
                      <li><a href="">TODO: View All Bookings</a></li>
                      <!-- Don't show delete/assume links for own account -->
                      <cfif session.user.properties.id NEQ id>
                        <li class="divider"></li>
                        <li>#linkTo(route="adminAssume", key=id, text="<i class='fa fa-user-secret'></i> " & l("Assume"))#</li>
                        <cfif hasPermission("admin.bookings.delete")>
                          <li class="text-danger">#linkTo(href=adminUserPath(id), method="delete", title=l("Disable"), text="<i class='fa fa-trash-o'></i> " & l("Disable"), class="text-danger", confirm=l("Disable This User?"))#</li>
                        </cfif>
                      </cfif>
                    </ul>
                  </div>
                  <cfelse>
                  <cfif hasPermission("admin.users.recover")>
                    #linkTo(route="adminRecover", key=id, text="<i class='fa fa-trash-o'></i> " & l("Recover"), class="btn btn-xs btn-flat btn-warning")#
                  </cfif>
                  </cfif>
                  </td>
                </tr>
                </cfloop>
                </tbody>
              </table>
      #paginationLinks()#
              #boxEnd()#
		<cfelse>
			#alert(title="No Users Found", content="There aren't any users yet. Maybe create some?")#
		</cfif>
	</div>
</cfoutput>


