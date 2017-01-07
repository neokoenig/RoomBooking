<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfoutput>
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->
<script
  src="https://code.jquery.com/jquery-2.2.4.min.js"
  integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
  crossorigin="anonymous"></script>
<!-- Bootstrap 3.3.6 -->
<script src="/javascripts/bootstrap.min.js"></script>
<script src="/javascripts/slimscroll.min.js"></script>
<script src="/javascripts/icheck.min.js"></script>
<!-- Full Calendar -->
<script src="/javascripts/moment.min.js"></script>
<script src="/javascripts/fullcalendar.min.js"></script>
<script src="/javascripts/fullcalendar-locales.js"></script>
<!-- Data Tables -->
<script src="/javascripts/datatables.js"></script>
<script src="/javascripts/bootstrap-datepicker.js"></script>
<script src="/javascripts/daterangepicker.js"></script>

<script src="/javascripts/timepicker.js"></script>
<script src="/javascripts/jquery.tmpl.js"></script>
<script src="/javascripts/jquery.tools.dateinput.js"></script>
<script src="/javascripts/jquery.tools.overlay.js"></script>
<script src="/javascripts/jquery.recurrenceinput.js"></script>

<!-- AdminLTE App -->
<script src="/javascripts/app.min.js"></script>

<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. Slimscroll is required when using the
     fixed layout. -->

<!--- Dynamic Javascript Set in Page --->
<cfif structkeyexists(request, "js")><cfloop list="#structKeyList(request.js)#" index="key"><cfoutput>#request.js[key]#</cfoutput></cfloop></cfif>
</body>
</html>
</cfoutput>
