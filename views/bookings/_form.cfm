<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Form--->
<cfparam name="locations">
<cfparam name="resources">
<cfparam name="event">
<cfparam name="customfields">

<cfoutput>
	<cfif structKeyExists(application.rbs.templates, "event") AND structKeyExists(application.rbs.templates.event, "form")>
		<!--- Custom output--->
		#processShortCodes(application.rbs.templates.event.form)#
		<cfelse>

			<!--- Default Template--->
			<cfsavecontent variable="eventTemplate">
				<fieldset>
					<legend>Event Details</legend>
					<div class="row">
						<div class="col-md-4">
							[systemfield id='title']
						</div>
						<div class="col-md-4">
							[systemfield id='locationid']
						</div>
						<div class="col-md-4">
							[systemfield id='layoutstyle']
						</div>
					</div>
					<div class="row">
						<div class="col-md-4">
							[systemfield id='start']
						</div>
						<div class="col-md-4">
							[systemfield id='end']
						</div>
						<div class="col-md-4">
							[systemfield id='allDay']
						</div>
					</div>
					</fieldset>
					[systemfield id='description']
					<fieldset>
						<legend>Contact Details</legend>
						<div class="row">
							<div class="col-md-4">
								[systemfield id='contactname']
 							</div>
							<div class="col-md-4">
								[systemfield id='contactno']
 							</div>
							<div class="col-md-4">
								[systemfield id='contactemail']
							</div>
						</div>
						<!--- How to do this as shortcode? --->
						<cfif params.action EQ "add" OR params.action EQ "create">
							#checkbox(objectName="event", property="emailContact", label="Send Confirmation Email to Contact")#
							<cfif application.rbs.setting.isDemoMode>
								<p class="help-block">No emails will be sent in demo mode</p>
							</cfif>
						</cfif>
					</fieldset>
				</cfsavecontent>
			</fieldset>
			#processShortCodes(eventTemplate)#
			#includePartial(partial="/customfields/common")#
		</cfif>

		<!--- Event Resources output irrespective of template, for now--->
		<cfif application.rbs.setting.allowResources>
			#includePartial("tabs/resources")#
		</cfif>

		<!--- Ditto repeat fields --->
		<cfif params.action EQ "add" OR params.action EQ "create">
			#includePartial("tabs/repeat")#
		</cfif>
	</cfoutput>

	<cfsavecontent variable="request.js.datepicker">
		<script>
		$(document).ready(function(){

	// Deselect resources if restricted
	restrictResources(false);

	function restrictResources(uncheck){
		var selectedLocation=getSelectedLocation(),
		rows=$("#resourceTable").find("td[data-restrict]");
		rows.find("input").attr({"disabled": true});
		if(uncheck){
			rows.find("input").attr({"checked": false});
		}
		$.each(rows, function(i, val){
			var restrict=$(val).data("restrict");
			if(restrict.length > 1){
				if ($.inArray(selectedLocation, restrict.replace(/,\s+/g, ',').split(',')) >= 0) {
					$(val).find("input").attr({"disabled": false});
				}
			}
		});
	}

	function getSelectedLocation(){
		return $("#event-locationid").val();
	}

	$("#event-locationid").on("change", function(e){
		restrictResources(true);
	});

	// Remote resource availability check
	$("#resourceTable td[data-unique] input").on("click", function(e){
		var id=$(this).closest("td").data("unique"),
		eventid=<cfoutput><cfif params.action EQ "add">0<cfelse>#event.key()#</cfif></cfoutput>,
		start=$("#event-start").val(),
		end=$("#event-end").val();
		if(start.length === 0 || end.length === 0){
			alert("You must enter a start and end date/time before attempting to book this resource");
			return false;
		}
		//console.log(id + " Unique Check");
		$.ajax({
			url: "<cfoutput>#urlFor(controller='resources', action='checkavailability', params='format=json')#</cfoutput>",
			data: {
				id: id,
				eventid: eventid,
				start: start,
				end: end
			},
			success: function(data){
				var resource=$("#resourceTable td[data-unique=" + id  +"] input");
				resource.parent().find(".rCheck").remove();
				if(data == 1){
					resource.attr({"checked": true}).parent().append("<p class='rCheck text-success'><i class='glyphicon glyphicon-ok'></i> Available</p>");
				} else {
					resource.attr({"checked": false}).parent().append("<p class='rCheck text-danger'><i class='glyphicon glyphicon-warning-sign'></i> Item is already reserved for another booking!</p>");
				}
			}
		})
	});
});
</script>
</cfsavecontent>