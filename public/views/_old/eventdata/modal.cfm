<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Get Event--->
<cfoutput>
<div class="modal-header">
<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">#l("Close")#</span></button>
<h4 class="modal-title">#l("Event Detail")#:</h4>
</div>
<div class="modal-body">
#includeContent()#
</div>
<div class="modal-footer">
<button type="button" class="btn btn-default" data-dismiss="modal">#l("Close")#</button>
</div>
</cfoutput>