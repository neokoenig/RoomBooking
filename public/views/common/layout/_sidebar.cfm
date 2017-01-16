<cfoutput>
<cfif application.rbs.settings.theme_layout NEQ "layout-top-nav">
  <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">
    <section class="sidebar">
      <!-- Sidebar Menu -->
      <ul class="sidebar-menu">
        <cfif hasPermission("calendar")>
          <li class="header">#l("Calendars")#</li>
        </cfif>
        <cfloop query="request.allcalendars">
        <!---#sidebarlink(controller="calendar", route="calendarShow", key=id, icon=icon, text=title)#--->

        <li>
          <a class="calendarswitcher" data-key=#id#><cfif len(icon)><i class='fa #icon#'></i> </cfif>#title#</a></li>

        </cfloop>
        <!---
        #sidebarlink(hashasPermission="accessSchedule", controller="schedule", route="calendarSchedule", icon="fa-calendar", text="Schedule")#

        #sidebarlink(hashasPermission="canCreateBooking", controller="bookings", route="bookings", icon="fa-plus", text="Book a Room")#
--->

      </ul>
      <!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
  </aside>
  </cfif>
</cfoutput>
<cfsavecontent variable="request.js.cal">
<script>

</script>
</cfsavecontent>
