<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Modal Field Picker --->
<cfoutput>
<div id="customfielddata">
<h4>Custom Fields</h4>
<cfif customfields.recordcount>
<cfloop query="customfields">
	<div class="btn-group btn-group-justified">
		<a data-id="#id#" data-type="field" class="fielddata custom btn btn-info">#name# (#type#)<br /><small>#truncate(description, 40)#</small></a>
		<a data-id="#id#" data-type="output"  class="fielddata custom btn btn-warning">#name# (Output)<br /><small>#truncate(description, 40)#</small></a>
	</div>
 </cfloop>
<cfelse>
<p>None available</p>
</cfif>

<h4>System Fields</h4>
<cfif arraylen(systemfields.systemfields)>
<cfloop from="1" to="#arraylen(systemfields.systemfields)#" index="i">
	<div class="btn-group btn-group-justified">
		<a data-id="#systemfields.systemfields[i]['name']#" data-type="field" class="fielddata system btn btn-info btn-block">#systemfields.systemfields[i]['name']# (#systemfields.systemfields[i]['type']#)<br /><small>#truncate(systemfields.systemfields[i]['description'], 40)#</small></a>
		<a data-id="#systemfields.systemfields[i]['name']#" data-type="output"  data-formatter="#systemfields.systemfields[i]['type']#" class="fielddata system btn btn-warning btn-block">#systemfields.systemfields[i]['name']# (Output)<br /><small>#truncate(systemfields.systemfields[i]['description'], 40)#</small></a>
	</div>
 </cfloop>
<cfelse>
	<p>None available</p>
</cfif>
</div>
</cfoutput>
<script>
	$(".fielddata").on("click", function(e){
		$(".fielddata").removeClass("fielddata-selected");
		$(this).addClass("fielddata-selected");
		e.preventDefault();
	});
</script>