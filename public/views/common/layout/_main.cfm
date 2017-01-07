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

      <!-- Your Page Content Here -->
	  #flashMessages()#
	  #includeContent()#

    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
</cfoutput>
