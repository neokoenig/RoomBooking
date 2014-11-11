<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfoutput>
	<fieldset>
		<legend>Bulk Create Events</legend>

	<div class="row">
		<div class="col-md-2">
			#radioButtonTag(name="repeat", value="none", label="Don't Repeat", checked=true)#
		</div>
		<div class="col-md-2">
			#radioButtonTag(name="repeat", value="week", label="Weekly")#
		</div>
		<div class="col-md-2">
			#radioButtonTag(name="repeat", value="month", label="Monthly")#
		</div>
		 <div class="col-md-3">
			#selectTag(name="repeatno", label="How Many More Times?", options="1,2,3,4,5,6,7,8,9,10,11,12,13,14,15", includeBlank=true)#
		</div>
	</div>
		</fieldset>
</cfoutput>