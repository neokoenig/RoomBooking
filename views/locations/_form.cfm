<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Location Form--->
<cfoutput>
#errorMessagesFor("location")#
<div class="row">
	<div class="col-lg-3">
		#textField(objectname="location", property="name", placeholder="e.g Lecture Theatre")#
		<p class="help-block">The Main room name, i.e Seminar Room 1</p>
	</div>
	<div class="col-lg-3">
		#textField(objectname="location", property="description", placeholder="e.g Ground Floor")#
		<p class="help-block">Might be a building location or floor</p>
	</div>
	<div class="col-lg-3">
		#textField(objectname="location", property="class", label="Placeholder CSS Class", placeholder="e.g theatre")#
		<p class="help-block">Classname used to assign a colour, should be unique to this location</p>
	</div>
	<div class="col-lg-3">
		#textField(objectname="location", property="colour",  class="form-control bscp", label="HEX colour", placeholder="e.g ##FF6600")#<p class="help-block">The colour assigned to this location</p>
	</div>
</div>

<cfsavecontent variable="request.js.colorpicker">
	<script>
$('.bscp').colorpicker();
	</script>
</cfsavecontent>

</cfoutput>