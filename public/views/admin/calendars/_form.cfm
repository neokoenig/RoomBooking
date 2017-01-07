<cfoutput>
#box(title=l("Main Calendar Details"))#
	<div class="row">
		<div class="col-sm-4">
			#textField(objectname="calendar", property="title", label=l("Title") & " *", placeholder="My Calendar", required="true")#
		</div>
		<div class="col-sm-8">
			#textField(objectname="calendar", property="description", label=l("Description"), placeholder="Optional Description")#
		</div>
	</div>
#boxend()#

#includePartial(objectname="calendar", partial="/common/form/owner")#

#box(title=l("Preferences"))#
	<div class="row">
		<div class="col-md-3">
			#textField(objectname="calendar", property="icon", label=l("Icon"))#
		</div>
	</div>
#boxend()#

</cfoutput>
