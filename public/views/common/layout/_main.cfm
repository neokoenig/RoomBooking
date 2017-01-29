<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfoutput>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <!---cfif len(request.pagetitle)>
        <h1>#request.pagetitle#</h1>
      </cfif--->
      <!---ol class="breadcrumb">
        <li><a href=""><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
      </ol--->
    </section>

    <!-- Main content -->
    <section class="content">

      <!-- Page Content  -->
      <!--- Flash: uncomment for static HTML msgs --->
      <!---
      <div id="flash">
        #flash(key="alert", prepend="<div class=""alert"">", append="</div>")#
        #flash(key="error", prepend="<div class=""alert""><i class='fa fa-exclamation-triangle'></i> ", append="</div>")#
        #flash(key="info", prepend="<div class=""alert""><i class='fa fa-exclamation-circle' /></i> ", append="</div>")#
        #flash(key="success", prepend="<div class=""alert""><i class='fa fa-check' /></i> ", append="</div>")#
        <cfdump var="#session.flash#">
      </div>
      --->

      <!--- Useful to debug triggers --->
      <!---
      <cfif structKeyExists(request, "triggers")>
      <cfdump var="#request.triggers#">
      </cfif>
      --->

	  #includeContent()#

    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
</cfoutput>
<!--- JS noty based flash messages --->
<cfsavecontent variable="request.js.noty">
<script>
var flashMessages=<cfoutput>#serializeJSON(session.flash)#</cfoutput>
  console.log(flashMessages);
  if(!$.isEmptyObject(flashMessages)){
    for(m in flashMessages){
      console.log(m);
      noty({
        layout: 'topCenter',
        theme: 'metroui',
        text: flashMessages[m],
        type: m,
         animation: {
            open: {height: 'toggle'}, // or Animate.css class names like: 'animated bounceInLeft'
            close: {height: 'toggle'}, // or Animate.css class names like: 'animated bounceOutLeft'
            easing: 'swing',
            speed: 500 // opening & closing animation speed
          },
        timeout: 4000, // [integer|boolean] delay for closing event in milliseconds. Set false for sticky notifications
        progressBar: true, // [boolean] - displays a progress bar
      });
    }
  }
</script>
</cfsavecontent>
