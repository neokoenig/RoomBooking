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
            #includePartial("/common/layout/lang")#
         <cfif isAuthenticated()>
            #includePartial("/common/layout/account")#
          <cfelse>
            <li>#linkTo(route="login",  text="<i class='fa fa-lock'></i><span> " & l("Login") & "</span>")#</li>
          </cfif>
        </ul>
      </div>
    </nav>
  </header>
</cfoutput>
