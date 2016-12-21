<cfoutput>

  <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">

    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">

      <!-- Sidebar user panel (optional) -->
      <div class="user-panel">
        <div class="pull-left image">
          <img src="/images/user2-160x160.jpg" class="img-circle" alt="User Image">
        </div>
        <div class="pull-left info">
          <p>Logged in Username</p>
        </div>
      </div>

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
        <li class="header">Bookings</li>
        <!-- Optionally, you can add icons to the links -->

        <li class="#iif(params.route == 'root' || params.controller == 'calendar', '"active"', '')#">
            #linkTo(route="root", text="<i class='fa fa-calendar'></i> <span>Calendar</span>")#
        </li>
        <li class="#iif(params.controller == 'schedule', '"active"', '')#">
            #linkTo(route="scheduleRoot", text="<i class='fa fa-calendar'></i> <span>Schedule</span>")#
        </li>
        <li class="#iif(params.controller == 'bookings', '"active"', '')#">
            #linkTo(route="bookingsRoot", text="<i class='fa fa-plus'></i> <span>Create Booking</span>")#
        </li>
        <!---li class="treeview">
          <a href="##"><i class="fa fa-link"></i> <span>Multilevel</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="##">Link in level 2</a></li>
            <li><a href="##">Link in level 2</a></li>
          </ul>
        </li--->
        <li class="header">Administration</li>

        <li class="#iif(params.controller == 'admin.buildings', '"active"', '')#">
            #linkTo(route="adminBuildingsRoot", text="<i class='fa fa-building-o'></i> <span>Buildings</span>")#
        </li>
        <li class="#iif(params.controller == 'admin.rooms', '"active"', '')#">
            #linkTo(route="adminRoomsRoot", text="<i class='fa fa-building-o'></i> <span>Rooms</span>")#
        </li>
        <li class="#iif(params.controller == 'admin.resources', '"active"', '')#">
            #linkTo(route="adminResourcesRoot", text="<i class='fa fa-laptop'></i> <span>Resources</span>")#
        </li>
        <li class="#iif(params.controller == 'admin.users', '"active"', '')#">
            #linkTo(route="adminUsersRoot", text="<i class='fa fa-users'></i> <span>Users</span>")#
        </li>
        <li class="#iif(params.controller == 'admin.permissions', '"active"', '')#">
            #linkTo(route="adminPermissionsRoot", text="<i class='fa fa-cog'></i> <span>Permissions</span>")#
        </li>
        <li class="#iif(params.controller == 'admin.settings', '"active"', '')#">
            #linkTo(route="adminSettingsRoot", text="<i class='fa fa-cog'></i> <span>Settings</span>")#
        </li>
        <li class="#iif(params.controller == 'admin.logs', '"active"', '')#">
            #linkTo(route="adminLogsRoot", text="<i class='fa fa-list'></i> <span>Logs</span>")#
        </li>
        <li class="header">Help &amp; FAQ</li>
        <li><a href="##"><i class="fa fa-book"></i> <span>Documentation</span></a></li>
      </ul>
      <!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
  </aside>
</cfoutput>
