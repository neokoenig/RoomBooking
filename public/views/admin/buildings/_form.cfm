<cfoutput>
#box(title=l("Main Building Details"))#
	<div class="row">
		<div class="col-sm-4">
			#textField(objectname="building", property="title", label=l("Title") & " *", placeholder="My Building", required="true")#
		</div>
		<div class="col-sm-4">
			#textField(objectname="building", property="description", label=l("Description"), placeholder="Optional Description")#
		</div>
		<div class="col-sm-2">
		</div>
	</div>
#boxend()#


#includePartial(objectname="building", partial="/common/form/address")#
#includePartial(objectname="building", partial="/common/form/contact")#
#includePartial(objectname="building", partial="/common/form/owner")#

#box(title=l("Preferences"))#
	<div class="row">

		<div class="col-md-3">
			#select(objectName="building", property="timezone", options=getTZListDropDown(), includeBlank=l("Use Default"), label=l("Time Zone"))#
		</div>
		<div class="col-md-3">
			#textField(objectname="building", property="googleplaceid", label=l("Google Place ID"))#
		</div>
		<div class="col-md-3">
			#textField(objectname="building", property="hexcolour", label=l("Hex Colour"))#
		</div>
		<div class="col-md-3">
			#textField(objectname="building", property="icon", label=l("Icon"))#
		</div>
	</div>
#boxend()#

</cfoutput>
