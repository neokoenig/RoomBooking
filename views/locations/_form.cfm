<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Location Form--->
<cfoutput>
#errorMessagesFor("location")#
<div class="row">
	<div class="col-lg-3">
		#textField(objectname="location", property="name", placeholder="e.g Lecture Theatre")#
	</div>
	<div class="col-lg-3">
		#textField(objectname="location", property="description", placeholder="e.g Ground Floor")#
	</div>
	<div class="col-lg-3">
		#textField(objectname="location", property="class", label="Additional CSS Class", placeholder="e.g theatre")#
	</div>
	<div class="col-lg-3">
		#textField(objectname="location", property="colour",  class="form-control bscp", label="HEX colour", placeholder="e.g ##FF6600")#
	</div>
</div>

<cfsavecontent variable="request.js.colorpicker">
	<script>
$('.bscp').colorpicker();
	</script>
</cfsavecontent>

</cfoutput>