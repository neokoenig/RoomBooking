<cfoutput>
#box(title=l("Main Details"))#
	<div class="row">
		<div class="col-md-4">
			#textField(objectname="booking", property="title", label=l("Title") & " *", placeholder="My Meeting", required="true")#
		</div>
	</div>
#boxEnd()#

#box(title=l("Location"))#
	<div class="row">
		<div class="col-md-4">
			#select(objectname="booking", property="buildingid", options=allBuildings,  textField="title", valueField="id", label=l("Building"), includeBlank="Standalone Room")#
		</div>
		<div class="col-md-4">
			#select(objectname="booking", property="roomid", options=allRooms, textField="title", valueField="id", label=l("Room"), includeBlank="No Specific Room")#
		</div>
	</div>
#boxEnd()#

#box(title=l("Date &amp; Time"))#
	<!---div class="row">
		<div class="col-md-6">
			<div class="form-group">
				<label>#l("Duration")#</label>
	                <div class="input-group">
				<div class="input-group-addon">
					<i class="fa fa-clock-o"></i>
			</div>
			#textField(objectname="booking", prepend="", append="", prependToLabel="", appendToLabel="", property="startUTC", label="")#
			 </div>
                <!-- /.input group -->
              </div>

		</div>
		<div class="col-md-4">
			#checkBox(objectname="booking", property="allday", label=l("All Day"))#
		</div>
	</div--->


			<div class="row">
				<div class="col-md-3">
					#textField(objectname="booking", property="startUTC")#
					<!---#textField(objectname="booking", property="endUTC")#--->
				</div>
				<div class="col-md-1">
					#textField(objectname="booking", property="duration")#
				</div>
				<div class="col-md-2">
					#checkBox(objectname="booking", property="allday", label=l("All Day"))#
					#checkBox(objectname="booking", property="isrepeat", label=l("Use Repeats"))#
				</div>
				<div class="col-md-4">
					#textArea(objectname="booking", property="repeatpattern")#
				</div>
			</div>

#boxEnd()#

#includePartial(objectname="booking", partial="/common/form/owner")#
#includePartial(objectname="booking", partial="/common/form/contact")#

#box(title=l("Approval Status"))#
	<div class="row">
		<div class="col-md-4 ">
			#checkBox(objectname="booking", property="approved", label=l("Approved"))#
			#select(objectname="booking", property="approvedby", label=l("Approved By"), valueField="id", textField="fullname", options=allusers, includeBlank=l("Unknown"))#
		</div>
	</div>
#boxEnd()#

#box(title=l("Notes"))#
	<div class="row">
		<div class="col-md-6">
			#textArea(objectname="booking", property="usernotes", label=l("User Notes"))#
		</div>
		<div class="col-md-6">
			#textArea(objectname="booking", property="adminnotes", label=l("Administrative Notes"))#
		</div>
	</div>
#boxEnd()#
</cfoutput>
<cfsavecontent variable="request.js.picker">
<script>
//Date picker
$("#booking-startUTC").datepicker({

});
$("#booking-repeatpattern").recurrenceinput();
</script>
</cfsavecontent>
