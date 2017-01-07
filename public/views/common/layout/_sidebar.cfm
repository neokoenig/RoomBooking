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
        <li class="header">#l("Calendars")#</li>
        <cfloop query="request.allcalendars">
        #sidebarlink(permission="accessCalendar", controller="calendar", route="calendarShow", key=id, icon=icon, text=title)#
        </cfloop>
        <!---
        #sidebarlink(permission="accessSchedule", controller="schedule", route="calendarSchedule", icon="fa-calendar", text="Schedule")#

        #sidebarlink(permission="canCreateBooking", controller="bookings", route="bookings", icon="fa-plus", text="Book a Room")#
--->
        <li class="header">#l("Administration")#</li>
        <cfif isAuthenticated()>
          #sidebarlink(permission="accessSettings", controller="admin.admin", route="adminIndex", icon="fa-cog", text="Administration")#
          #sidebarlink(permission="accessApplication", controller="authentication", route="authenticationLogout", icon="fa-unlock-alt", text="Logout")#
        <cfelse>
          #sidebarlink(permission="accessApplication", controller="authentication", route="authenticationLogin", icon="fa-lock", text="Login")#
        </cfif>
      </ul>
      <!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
  </aside>
</cfoutput>
