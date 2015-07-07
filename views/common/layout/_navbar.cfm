<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfoutput>
<cfif request.showNavBar>
 <div class="navbar navbar-inverse">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#application.wheels.rootpath#">
            <cfif len(application.rbs.setting.sitelogo) GT 1>
              <img src="#application.rbs.setting.sitelogo#" alt="Logo" class="img-responsive pull-left logo" />
            </cfif>
            <cfif len(application.rbs.setting.sitetitle) GT 1>
              #application.rbs.setting.sitetitle#
            </cfif><cfif application.rbs.setting.isDemoMode>(#l("Demo Mode")#)</cfif></a>
        </div>
        <nav class="collapse navbar-collapse">
          <cfif checkpermission("accessCalendar")>
            <ul class="nav navbar-nav">
            <cfif checkpermission("accessCalendar")>
           <li class="dropdown">
            <a href="##" class="dropdown-toggle" data-toggle="dropdown"><span class='glyphicon glyphicon-calendar'></span> #l("Events")# <b class="caret"></b></a>
            <ul class="dropdown-menu">
                <li>#linkTo(route="home", text="<span class='glyphicon glyphicon-calendar'></span> " & l('Calendar'))#</li>
                <!--- Day view deprecated in it's current form --->
                <!---li>#linkTo(controller="bookings", action="day", text="<span class='glyphicon glyphicon-th'></span> Day")#</li--->
                <li>#linkTo(controller="bookings", action="list", text="<span class='glyphicon glyphicon-list'></span> " & l('List'))#</li>
                 <cfif checkpermission("allowAPI")>
                    <li>#linkTo(controller="api",  text="<span class='glyphicon glyphicon-cloud-download'></span> " & l('Data Feed'))#</li>
                 </cfif>
                <li>#linkTo(controller="locations", action="list", text="<span class='glyphicon glyphicon-list'></span> " & l('Locations'))#</li>
            </ul>
            </li>
               </cfif>
              <cfif checkpermission("allowRoomBooking")>
                <li>#linkTo(controller="bookings", action="add", text="<span class='glyphicon glyphicon-plus-sign'></span> " & l('Book a Room'))#</li>
              </cfif>
            </ul>
          </cfif>
           <ul class="nav navbar-nav navbar-right">
            #includePartial("/common/layout/lang")#

          <cfif isloggedin() AND (application.rbs.setting.allowSettings OR application.rbs.setting.allowLocations)>
            <li class="dropdown">
            <a href="##" class="dropdown-toggle" data-toggle="dropdown"><span class='glyphicon glyphicon-cog'></span> #l("Settings")# <b class="caret"></b></a>
            <ul class="dropdown-menu">
            <cfif checkPermission("updateOwnAccount")>
               <li>#linkTo(route="myaccount", text="<span class='glyphicon glyphicon-user'></span> " & l('My Account'))#</li>
            </cfif>
             <cfif checkpermission("accessUsers")>
               <li>#linkTo(controller="users",  text="<span class='glyphicon glyphicon-user'></span> " & l('Users'))#</li>
             </cfif>

            <cfif application.rbs.setting.allowLocations AND checkpermission("accessLocations")>
              <li>#linkTo(controller="locations",  text="<span class='glyphicon glyphicon-plus-sign'></span> " & l('Locations'))#</li>
            </cfif>
             <cfif application.rbs.setting.allowResources AND checkpermission("accessResources")>
              <li>#linkTo(controller="resources",  text="<span class='glyphicon glyphicon-plus-sign'></span> " & l('Resources'))#</li>
            </cfif>

            <cfif application.rbs.setting.allowSettings>
            <cfif checkpermission("accessSettings")>
               <li>#linkTo(controller="settings",  text="<span class='glyphicon glyphicon-cog'></span> " &l('Configuration'))#</li>
            </cfif>
              <cfif checkpermission("accessPermissions")>
               <li>#linkTo(controller="permissions",  text="<span class='glyphicon glyphicon-cog'></span> " &l('Permissions'))#</li>
              </cfif>
              <cfif checkPermission("accessCustomFields")>
                <li>#linkTo(controller="Customfields", text="<span class='glyphicon glyphicon-cog'></span> " &l('Custom Fields'))#</li>
              </cfif>
              <cfif checkPermission("accessLogfiles")>
                <li>#linkTo(controller="logfiles", text="<span class='glyphicon glyphicon-list'></span> " &l('Logs'))#</li>
              </cfif>
            </cfif>
            </ul>
            </li>
          </cfif>
          <li>
            <cfif isLoggedIn()>
              #linkTo(route="logout", text="<span class='glyphicon glyphicon-off'></span> " & l('Logout'))#
            <cfelse>
              #linkTo(route="login", class="hidden-lg", text="<span class='glyphicon glyphicon-lock'></span> " & l('Login'))#
              <li class="dropdown visible-lg">
            <a class="dropdown-toggle" href="##" data-toggle="dropdown"><span class='glyphicon glyphicon-lock'></span> #l("Login")#<strong class="caret"></strong></a>
            <div id="dropdown-signin" class="dropdown-menu">
               #includePartial("/sessions/signin")#
            </div>
          </li>
            </cfif>
            </li>
          </ul>
        </nav><!--/.nav-collapse -->
      </div>
    </div>
</cfif>
<cfif fileExists(expandPath("/install/index.cfm"))>
    <div class="container">
        <div class="alert alert-danger" role="alert">
          <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
          <span class="sr-only">#l("Error")#:</span>
          #l("Please delete or rename the <code>/install/</code> directory before continuing")#
        </div>
    </div>
</cfif>
</cfoutput>
