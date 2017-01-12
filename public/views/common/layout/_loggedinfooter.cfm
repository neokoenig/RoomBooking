<cfoutput>
<!-- Main Footer -->
  <footer class="main-footer">
    #application.rbs.settings.general_copyright#
  </footer>
  <cfif params.controller EQ "calendar">
  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-light">
      <button class="btn btn-block btn-flat btn-info btn-lg" data-toggle="control-sidebar"><i class="fa fa-times"></i> Close</button>
      <div id="sidebar-dynamic-content"></div>
  </aside>
  <!-- /.control-sidebar -->
  <!-- Add the sidebar's background. This div must be placed
       immediately after the control sidebar -->
  <div class="control-sidebar-bg"></div>
  </cfif>
  </cfoutput>
