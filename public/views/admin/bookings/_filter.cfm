<cfoutput>
#box(title="Filter")#
#startFormTag(route="adminBookings", method="GET")#
	<div class="row">
		<div class="col-md-2">
			#textFieldTag(name="from", value=params.from, label="From")#
		</div>
		<div class="col-md-2">
			#textFieldTag(name="to", value=params.to, label="To")#
		</div>
		<div class="col-md-2">
			#selectTag(name="buildingid", selected=params.buildingid, label="Building", options=allbuildings, textField="title", valueField="id", label=l("Building"), includeBlank=l("Any")
			)#
		</div>
		<div class="col-md-2">
			#selectTag(name="roomid", selected=params.roomid, label="Building", options=allrooms, textField="title", valueField="id", label=l("Room"), includeBlank=l("Any"))#
		</div>
		<div class="col-md-2">
			#selectTag(name="status",  selected=params.status, label=l("Status"), includeBlank=l("Any"), options="Approved,Pending")#
			#checkBoxTag(name="includerepeats", checked=params.includerepeats, label=l("Generate Repeats"), value=1)#
		</div>
		<div class="col-md-2">
			#submitTag(l("Filter"))#
		</div>
	</div>
#endFormTag()#
#boxEnd()#
</cfoutput>
<cfsavecontent variable="request.js.picker">
<script>
// Date picker
$("#from,#to").datepicker({
	language: $('html').attr('lang'),
	format: 'yyyy-mm-dd',
    autoclose: true
});
</script>
</cfsavecontent>
