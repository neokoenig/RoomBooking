<cfoutput>
<!-- User Account Menu -->
          <li class="dropdown user user-menu">
            <!-- Menu Toggle Button -->
            <a href="##" class="dropdown-toggle" data-toggle="dropdown">
              <!-- The user image in the navbar-->
                <img src="https://www.gravatar.com/avatar/#lcase(Hash(lcase(session.user.properties.email)))#" alt="Gravatar" class="img-circle user-image" />
              <!-- hidden-xs hides the username on small devices so only the image appears. -->
              <span class="hidden-xs">#session.user.properties.firstname# #session.user.properties.lastname#</span>
            </a>
            <ul class="dropdown-menu">
              <!-- The user image in the menu -->
              <li class="user-header">
                <img src="https://www.gravatar.com/avatar/#lcase(Hash(lcase(session.user.properties.email)))#" alt="Gravatar" class="img-circle" />
                <p>
                  Logged In User
                  <small>Member since Nov. XXXX</small>
                </p>
              </li>
              </li>
              <!-- Menu Footer-->
              <li class="user-footer">
                <div class="pull-left">
                  <a href="##" class="btn btn-default btn-flat">Profile</a>
                </div>
                <div class="pull-right">
                  #linkTo(route="authenticationLogout", text=l("Logout"), class="btn btn-default btn-flat")#
                </div>
              </li>
            </ul>
          </li>
          </cfoutput>
