<cfoutput>
<!--- Account Header --->
<div class="box box-primary">
	<div class="box-body box-profile">
	  <img class="profile-user-img img-responsive img-circle" src="https://www.gravatar.com/avatar/#lcase(Hash(lcase(session.user.properties.email)))#" alt="User profile picture">
	  <h3 class="profile-username text-center">#session.user.properties.fullname#</h3>
	  <p class="text-muted text-center">#session.user.properties.username#</p>
 		<div class="btn-group">
        <cfif hasPermission("my.account")>
          #linkTo(route="myAccount", text=l("My Account"), class="btn btn-default btn-sm btn-flat")#
        </cfif>
        <cfif hasPermission("my.bookings")>
          #linkTo(route="myBookings", text=l("My Bookings"), class="btn btn-default btn-sm btn-flat")#
        </cfif>
        </div>
	</div><!-- /.box-body -->
</div><!-- /.box -->
</cfoutput>
