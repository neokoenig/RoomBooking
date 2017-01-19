<cfoutput>
<!-- Main Header -->
  <header class="main-header">

<cfif application.rbs.settings.theme_layout NEQ "layout-top-nav">
  <!-- Logo -->
  <a href="/" class="logo">
    <!-- mini logo for sidebar mini 50x50 pixels -->
    <span class="logo-mini"><b><img src="/images/logo_mini.png" alt="Logo" /></b></span>
    <!-- logo for regular state and mobile devices -->
    <span class="logo-lg"><img src="/images/logo_mini.png" alt="Logo" /> <b>#application.rbs.settings.general_shortname#</b></span>
  </a>
</cfif>

<!-- Header Navbar -->
<nav class="navbar navbar-static-top" role="navigation">

      <cfif application.rbs.settings.theme_layout NEQ "layout-top-nav">

        <!-- Sidebar toggle button-->
        <a href="##" class="sidebar-toggle" data-toggle="offcanvas" role="button">
          <span class="sr-only">#l("Toggle navigation")#</span>
        </a>

    <cfelse>
        <a href="/" class="navbar-brand"><b>#application.rbs.settings.general_shortname#</b><img src="/images/logo_mini.png" alt="Logo" /></a>
        <ul class="nav navbar-nav">
          <cfloop query="request.allcalendars">
            #sidebarlink(controller="calendar", route="calendarShow", key=id, icon=icon, text=title)#
          </cfloop>
        </ul>
    </cfif>

      <!-- Navbar Right Menu -->
      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          <!--- Messages: style can be found in dropdown.less-->
          <li class="dropdown messages-menu">
            <!-- Menu toggle button -->
            <a href="##" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-envelope-o"></i>
              <span class="label label-success">4</span>
            </a>
            <ul class="dropdown-menu">
              <li class="header">You have 4 messages</li>
              <li>
                <!-- inner menu: contains the messages -->
                <ul class="menu">
                  <li><!-- start message -->
                    <a href="##">
                      <div class="pull-left">
                        <!-- User Image -->
                        <img src="/images/user2-160x160.jpg" class="img-circle" alt="User Image">
                      </div>
                      <!-- Message title and timestamp -->
                      <h4>
                        Support Team
                        <small><i class="fa fa-clock-o"></i> 5 mins</small>
                      </h4>
                      <!-- The message -->
                      <p>Why not buy a new awesome theme?</p>
                    </a>
                  </li>
                  <!-- end message -->
                </ul>
                <!-- /.menu -->
              </li>
              <li class="footer"><a href="##">See All Messages</a></li>
            </ul>
          </li>
          <!-- /.messages-menu --->

          <!--- Notifications Menu -->
          <li class="dropdown notifications-menu">
            <!-- Menu toggle button -->
            <a href="##" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-bell-o"></i>
              <span class="label label-warning">10</span>
            </a>
            <ul class="dropdown-menu">
              <li class="header">You have 10 notifications</li>
              <li>
                <!-- Inner Menu: contains the notifications -->
                <ul class="menu">
                  <li><!-- start notification -->
                    <a href="##">
                      <i class="fa fa-users text-aqua"></i> 5 new members joined today
                    </a>
                  </li>
                  <!-- end notification -->
                </ul>
              </li>
              <li class="footer"><a href="##">View all</a></li>
            </ul>
          </li>--->


            #includePartial("/common/layout/lang")#
         <cfif isAuthenticated()>
            <!---#sidebarlink(controller="admin.admin", route="adminIndex", icon="fa-cog", text="Administration")#
            #includePartial("/common/layout/tasks")#--->
            #includePartial("/common/layout/account")#
          <cfelse>
            <li>#linkTo(controller="authentication", route="authenticationLogin",  text="<i class='fa fa-lock'></i><span> " & l("Login") & "</span>")#</li>
          </cfif>
          <!-- Control Sidebar Toggle Button
          <li>
            <a href="##" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
          </li>-->
        </ul>
      </div>
    </nav>
  </header>
</cfoutput>
