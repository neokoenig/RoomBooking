<cfoutput>
#box(title=l("Main Account Details"))#
	<div class="row">
		<div class="col-sm-2">
			#textField(objectname="user", property="title", label=l("Title"), placeholder="e.g Mr")#
		</div>
		<div class="col-sm-3">
			#textField(objectname="user", property="firstname", label=l("First Name") & " *", required="true", placeholder="e.g Joe")#
		</div>
		<div class="col-sm-3">
			#textField(objectname="user", property="lastname", label=l("Last Name") & " *", required="true", placeholder="e.g Bloggs")#
		</div>
		<div class="col-sm-3">
			#textField(objectname="user", property="username", label=l("Username") & " *", required="true", placeholder="e.g joebloggs")#
		</div>
	</div>
#boxend()#

#includePartial(objectname="user", partial="/common/form/contact")#
#includePartial(objectname="user", partial="/common/form/address")#

#box(title=l("Preferences"))#
	<div class="row">
		<div class="col-md-4">
			#select(objectName="user", property="lang", options=request.lang.availableLanguages, includeBlank=l("Use Default"), label=l("Interface Language"))#
		</div>
		<div class="col-md-4">
			#select(objectName="user", property="locale", options=getLocaleListDropDown(), includeBlank=l("Use Default"), label=l("Locale"))#
		</div>
		<div class="col-md-4">
			#select(objectName="user", property="timezone", options=getTZListDropDown(), includeBlank=l("Use Default"), label=l("Time Zone"))#
		</div>
	</div>
#boxend()#

</cfoutput>
