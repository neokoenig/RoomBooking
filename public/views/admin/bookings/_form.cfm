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
			<div class="form-group">
                <label>Minimal</label>
                <select class="form-control select2" style="width: 100%;">
                  <option selected="selected">Alabama</option>
                  <option>Alaska</option>
                  <option>California</option>
                  <option>Delaware</option>
                  <option>Tennessee</option>
                  <option>Texas</option>
                  <option>Washington</option>
                </select>
              </div>
		</div>
	</div>
			


	<div class="row"> 
	<cfscript>
	buildings=getBuildingArray();
	rooms=getRoomArray();
	</cfscript>

 
		<div class="col-md-6"> 
 			<div data-selected=#booking.buildingid# id="buildingpicker" style="overflow-y: scroll; max-height:180px;">
			  <cfloop from="1" to="#arraylen(buildings)#" index="b">
				  <cfset initialClass="">
				  	<cfif structKeyExists(booking,"buildingid") AND booking.buildingid EQ buildings[b]['id']>
						<cfset initialClass="btn-primary"> 
				  	</cfif>
			  	<button class="lpicker #initialClass# btn btn-sm btn-block " data-id=#buildings[b]["id"]#>#buildings[b]["title"]# </button> 
			  </cfloop> 

			<!---#select(objectname="booking", property="buildingid", options=allBuildings,  textField="title", valueField="id", label=l("Building"), includeBlank="Standalone Room")#
			--->
			</div>
		</div>
		<div class="col-md-6">  
 			<div data-selected=#booking.roomid# id="roompicker" style="overflow-y: scroll; max-height:180px;">
			  <cfloop from="1" to="#arraylen(rooms)#" index="b">
			  <cfset initialClass="">
			  	<cfif structKeyExists(booking,"roomid") AND booking.roomid EQ rooms[b]['id']>
					<cfset initialClass="btn-primary"> 
			  	</cfif>
			  	<button class="rpicker hidden #initialClass# btn btn-sm btn-block " data-buildingid=#rooms[b]["buildingid"]# data-id=#rooms[b]["id"]#>#rooms[b]["title"]#</button>  
			  </cfloop> 
			 </div> 
		<!---
			#select(objectname="booking", property="roomid", options=allRooms, textField="title", valueField="id", label=l("Room"), includeBlank="No Specific Room")#
			--->
		</div>
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
$(".select2").select2();

toggleRooms($("#buildingpicker").data("selected"));

function toggleRooms(id){  
	console.log(id);
	$(".rpicker")
		.addClass("hidden").end()
		.find("[data-buildingid=" + id + "]")
		.removeClass("hidden");  
}

// Room Picker
$(".lpicker").on("click", function(e) {
	toggleRooms($(this).data("id"));
	$(".lpicker").removeClass("btn-primary");
	$(this).addClass("btn-primary");
	e.preventDefault();
}); 

$(".rpicker").on("click", function(e) {
	$(".rpicker").removeClass("btn-primary");
	$(this).addClass("btn-primary");
	e.preventDefault();
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
