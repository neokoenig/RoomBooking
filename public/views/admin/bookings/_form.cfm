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
	<cfloop from="1" to="#arraylen(locations)#" index="i">
		<button class="btn btn-xs btn-flat">#locations[i]["id"]#: #locations[i]["type"]#: #locations[i]["title"]#</button>
		<cfif structKeyExists(locations[i], "groupby")>
			<cfloop collection="#locations[i]['groupby']#" item="g">
					<strong>#g#</strong><br />
					<cfif arrayLen(locations[i]['groupby'][g])>
						<cfloop from="1" to="#arrayLen(locations[i]['groupby'][g])#" index="r">
							#locations[i]['groupby'][g][r]["id"]#: #locations[i]['groupby'][g][r]["type"]#: #locations[i]['groupby'][g][r]["title"]#<br />
						</cfloop>
					</cfif>
			</cfloop>
		</cfif>
	</cfloop>
		<!---div class="col-md-4">
			#select(objectname="booking", property="buildingid", options=allBuildings,  textField="title", valueField="id", label=l("Building"), includeBlank="Standalone Room")#
		</div>
		<div class="col-md-4">
			#select(objectname="booking", property="roomid", options=allRooms, textField="title", valueField="id", label=l("Room"), includeBlank="No Specific Room")#
		</div--->
	</div>
#boxEnd()#

#box(title=l("Date &amp; Time"))#
			<div class="row">
				<div class="col-md-2">
					#textField(objectname="booking", property="startUTCDate", label=l("Date"))#
				</div>
				<div class="col-md-2">

              <div class="bootstrap-timepicker">
                <div class="form-group">
                <label>#l("Time")#</label>
                  <div class="input-group">
					#textField(objectname="booking", prepend="", append="", label="", prependToLabel="", appendToLabel="", property="startUTCTime", class="form-control timepicker")#
                    <div class="input-group-addon">
                      <i class="fa fa-clock-o"></i>
                    </div>
                  </div>
                  <!-- /.input group -->
                </div>
                <!-- /.form group -->
              </div>
				</div>
				<div class="col-md-1">
					#textField(objectname="booking", property="duration")#
				</div>
				<div class="col-md-2">
					#checkBox(objectname="booking", property="isallday", label=l("All Day"))#
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
			#checkBox(objectname="booking", property="isapproved", label=l("Approved"))#
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
<cfoutput>

</cfoutput>
// Room Picker
$("#booking-buildingid").change(function(e){
	console.log($(this).val());
});
$("#booking-roomid").change(function(e){
	console.log($(this).val());
});
// Date picker
$("#booking-startUTCDate").datepicker({
	language: $('html').attr('lang'),
	format: 'yyyy-mm-dd',
    autoclose: true
});
// Time Picker
$(".timepicker").timepicker({
      showInputs: false
});
// RRULE
$("#booking-repeatpattern").recurrenceinput();
</script>
</cfsavecontent>
