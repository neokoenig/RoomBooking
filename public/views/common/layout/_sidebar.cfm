<cfoutput>
<cfparam name="allcalendars">
<cfif application.rbs.settings.theme_layout NEQ "layout-top-nav">
  <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">
    <section class="sidebar">
      <!-- Sidebar Menu -->
      <ul class="sidebar-menu">

        <!-- Calendars -->
        <cfif hasPermission("calendar")>
          <li class="header">#l("Calendars")#</li>
        <cfloop query="allcalendars">
          <li><a href="/" class="calendarswitcher" data-key=#id#><cfif len(icon)><i class='fa #icon#'></i> </cfif><span>#title#</span></a></li>
        </cfloop>
        </cfif>

        <!-- Bookings Wizard -->

        <cfif hasPermission("bookings")>
          <li class="header">#l("Booking")#</li>
            #sidebarlink( controller="bookings.wizard", route="bookingsWizard", icon="fa-search", text="Find a Room")#
        </cfif>
        <cfif hasPermission("admin")>
          <li class="header">#l("Administration")#</li>
          <li class="treeview #treeIsActive('admin,bookings,users,logs')#">
          <a href="">
            <i class="fa fa-dashboard"></i> <span>#l("Administration")#</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            #sidebarlink( controller="admin.admin", route="adminIndex", icon="fa-dashboard", text="Dashboard")#
            #sidebarlink( controller="admin.bookings", route="adminBookings", icon="fa-list", text="Bookings")#
            #sidebarlink( controller="admin.users", route="adminUsers", icon="fa-users", text="Users")#
            #sidebarlink( controller="admin.logs", route="adminLogs", icon="fa-list", text="Logs")#
          </ul>
          </li>
          <li class="treeview #treeIsActive('calendars,buildings,rooms,resources')#">
          <a href="">
            <i class="fa fa-calendar"></i> <span>#l("Setup")#</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            #sidebarlink( controller="admin.calendars", route="adminCalendars", icon="fa-calendar", text="Calendars")#
            #sidebarlink( controller="admin.buildings", route="adminBuildings", icon="fa-building-o", text="Buildings")#
            #sidebarlink( controller="admin.rooms", route="adminRooms", icon="fa-square-o", text="Rooms")#
            #sidebarlink( controller="admin.resources", route="adminResources", icon="fa-laptop", text="Resources")#
          </ul>
          </li>
           <li class="treeview #treeIsActive('settings,roles,permissions,dump')#">
          <a href="">
            <i class="fa fa-cog"></i> <span>#l("Settings")#</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            #sidebarlink( controller="admin.settings", route="adminSettings", icon="fa-cog", text="Settings")#
            #sidebarlink( controller="admin.roles", route="adminRoles", icon="fa-cog", text="Roles")#
            #sidebarlink( controller="admin.permissions", route="adminPermissions", icon="fa-cog", text="Permissions")#
            #sidebarlink( controller="admin.dump", route="adminDumpIndex", icon="fa-list", text="Dump")#
          </ul>
          </li>
           <li class="treeview #treeIsActive('workflows,triggers,actions')#">
          <a href="">
            <i class="fa fa-cubes"></i> <span>#l("Workflows")#</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            #sidebarlink( controller="admin.workflows", route="adminWorkflows", icon="fa-cubes", text="Workflows")#
            #sidebarlink( controller="admin.triggers", route="adminTriggers", icon="fa-cube", text="Triggers")#
            #sidebarlink( controller="admin.actions", route="adminActions", icon="fa-flash", text="Actions")#
          </ul>
          </li>
        </cfif>
      </ul>
      <!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
  </aside>
  </cfif>
</cfoutput>
