<cfoutput>
#box(title=l("Main Room Details"))#
	<div class="row">
		<div class="col-sm-3">
			#textField(objectname="room", property="title", label=l("Title") & " *", placeholder="My Room", required="true")#
		</div>
		<div class="col-sm-4">
			#textField(objectname="room", property="description", label=l("Description"), placeholder="Optional Description")#
		</div>
		<div class="col-sm-2">
		#select(objectname="room", property="buildingid", label=l("Building"), options=allbuildings, includeBlank="Standalone Room")#
		</div>
		<div class="col-sm-2">
		#select(objectname="room", property="groupby", label=l("Group By"), options="0")#
		</div>
	</div>

#boxend()#

#includePartial(objectname="room", partial="/common/form/contact")#
#includePartial(objectname="room", partial="/common/form/owner")#

#box(title=l("Preferences"))#
	<div class="row">

		<div class="col-md-3">
			#select(objectName="room", property="timezone", options=getTZListDropDown(), includeBlank=l("Inherit from Building"), label=l("Time Zone"))#
		</div>
		<div class="col-md-3">
			#textField(objectname="room", property="hexcolour", label=l("Hex Colour"))#
		</div>
		<div class="col-md-3">
			#textField(objectname="room", property="icon", label=l("Icon"))#
		</div>
	</div>
	<div class="row">
		<div class="col-md-3">
			#checkBox(objectname="room", property="allowconcurrent", label=l("Allow Concurrent Bookings"))#
			#checkBox(objectname="room", property="initialstatus", label=l("Requires confirmation"))#
			#checkBox(objectname="room", property="isaccessible", label=l("Wheelchair Accessible"))#
			#checkBox(objectname="room", property="hearingloop", label=l("Hearing Loop Enabled"))#
		</div>
		<div class="col-md-3">
			#select(objectname="room", property="bookableby", label=l("Minimum Role Required to Book"), options=allroles, includeBlank="No restriction")#
		</div>
		<div class="col-md-3">
			#select(objectname="room", property="bookableby", label=l("Minimum Role Required to Approve"), options=allroles, includeBlank="Inherit from Permissions")#
		</div>
	</div>
#boxend()#

#box(title=l("Booking Schema"))#
	Time/Slot/Overnight Based etc
#boxend()#

</cfoutput>
