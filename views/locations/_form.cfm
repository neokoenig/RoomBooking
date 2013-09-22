<!--- Location Form--->
<cfoutput>
#errorMessagesFor("location")#
<div class="row">
	<div class="col-lg-3">
		#textField(objectname="location", property="name", placeholder="i.e Lecture Theatre")#
	</div>
	<div class="col-lg-3"> 
		#textField(objectname="location", property="description", placeholder="i.e Ground Floor")#
	</div>
	<div class="col-lg-3">
		#textField(objectname="location", property="class", label="Additional CSS Class", placeholder="i.e theatre")#
	</div>
	<div class="col-lg-3">
		#textField(objectname="location", property="colour", label="HEX colour", placeholder="i.e ##FF6600")#
	</div>
</div>


</cfoutput>