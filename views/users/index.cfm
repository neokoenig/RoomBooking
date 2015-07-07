<!---================= Room Booking System / https://github.com/neokoenig =======================--->
 <!--- Admin Home --->
<cfparam name="params.showPaging" default="true">
<Cfoutput>
      #panel(title=l("Account Listings"))#
      #linkTo(controller="users", action="add", text="<span class='glyphicon glyphicon-plus-sign'></span> " & l("Create New Account"), class="btn btn-primary")#
      #includePartial(partial="usertable", users=users)#
        <cfif params.showPaging>
          #paginationLinks()#
        </cfif>
      #panelend()#
  </Cfoutput>

