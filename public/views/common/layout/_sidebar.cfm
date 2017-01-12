<cfoutput>

  <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">
    <section class="sidebar">

      <!-- search form (Optional)
      <form action="##" method="get" class="sidebar-form">
        <div class="input-group">
          <input type="text" name="q" class="form-control" placeholder="Search...">
              <span class="input-group-btn">
                <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                </button>
              </span>
        </div>
      </form> -->
      <!-- /.search form -->

      <!-- Sidebar Menu -->
      <ul class="sidebar-menu">
        <cfif hasPermission("calendar")>
          <li class="header">#l("Calendars")#</li>
        </cfif>
        <cfloop query="request.allcalendars">
        #sidebarlink(controller="calendar", route="calendarShow", key=id, icon=icon, text=title)#
        </cfloop>
        <!---
        #sidebarlink(hasPermissionCheck="accessSchedule", controller="schedule", route="calendarSchedule", icon="fa-calendar", text="Schedule")#

        #sidebarlink(hasPermissionCheck="canCreateBooking", controller="bookings", route="bookings", icon="fa-plus", text="Book a Room")#
--->
        <cfif hasPermission("admin")>
        <li class="header">#l("Administration")#</li>
          #sidebarlink(controller="admin.admin", route="adminIndex", icon="fa-cog", text="Administration")#
        </cfif><li class="active">
        <cfif isAuthenticated()>
          <li>#linkTo(controller="authentication", route="authenticationLogout",  text="<i class='fa fa-unlock'></i><span>" & l("Logout") & "</span>")#</li>
        <cfelse>
          <li>#linkTo(controller="authentication", route="authenticationLogin",  text="<i class='fa fa-lock'></i><span>" & l("Login") & "</span>")#</li>
        </cfif>
      </ul>
      <!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
  </aside>
</cfoutput>
