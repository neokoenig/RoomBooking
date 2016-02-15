<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Form--->
<cfparam name="locations">
<cfparam name="resources">
<cfparam name="event">
<cfparam name="customfields">

<cfoutput>
	#hiddenFieldTag(name="tempkey", value=event.key())#
	<div id="concurrencyCheckResult" 
		data-checkurl="#urlFor(controller='bookings', action='check')#"
		data-doConcurrencyCheck=#application.rbs.setting.doConcurrencyCheckForBookings# 
		data-allowOverlappingBookings=#application.rbs.setting.allowOverlappingBookings# 
		data-includeAllDayEventsinConcurrency=#application.rbs.setting.includeAllDayEventsinConcurrency#></div>
	<cfif structKeyExists(application.rbs.templates, "event") AND structKeyExists(application.rbs.templates.event, "form")>
		<!--- Custom output--->
		#processShortCodes(application.rbs.templates.event.form)#
		<cfelse>

			<!--- Default Template--->
			<cfsavecontent variable="eventTemplate">
				<fieldset>
					<legend>#l("Event Details")#</legend>
					<div class="row">
						<div class="col-md-4">
							[field id='title']
						</div>
						<div class="col-md-4">
							[field id='locationid']
						</div>
						<div class="col-md-2">
							[field id='layoutstyle']
						</div>
					</div>
					<div class="row">
						<div class="col-md-4">
							[field id='startsat']
						</div>
						<div class="col-md-4">
							[field id='endsat']
						</div>
						<div class="col-md-4">
							[field id='allDay']
						</div>
					</div>
					</fieldset>
						[field id='description']
					<fieldset>
						<legend>#l("Contact Details")#</legend>
						<div class="row">
							<div class="col-sm-4">
								[field id='contactname']
 							</div>
							<div class="col-sm-4">
								[field id='contactno']
 							</div>
							<div class="col-sm-4">
								[field id='contactemail']
							</div>
						</div>
						<div class="row">
							<div class="col-sm-6">
								[field id='emailcontact']
							</div>
						</div>
					</fieldset>
				</cfsavecontent>
			</fieldset>
			#processShortCodes(eventTemplate)#
			#includePartial(partial="/common/form/customfields")#
		</cfif>

		<!--- Event Resources output irrespective of template, for now--->
		<cfif application.rbs.setting.allowResources>
			#includePartial("resources")#
		</cfif>

		<!--- Ditto repeat fields --->
		 #includePartial("repeatrule")#

<!---
	TODO: localiser is adding a line break before this?
	//<cfoutput>#l('Available')#</cfoutput>
	//<cfoutput>#l('Item is already reserved for another booking!')#</cfoutput>

	--->
	</cfoutput>

	<cfsavecontent variable="request.js.datepicker">
		<script>
		$(document).ready(function(){
	    var layouts={
	    	<cfloop query="locations">
				<cfoutput>#id#: '#layouts#'<cfif locations.recordcount NEQ currentrow>
					,
				</cfif></cfoutput>
			</cfloop>
	    }


	// Concurrency Check
	concurrencyCheck();
	// Deselect resources if restricted
	restrictResources(false);
	// Override default Layouts if appropriate
	checkLayouts();
	// When the datepicker changes, rerun concurrency checks
	$("#event-startsat, #event-endsat").on("dp.hide", function(e){ 
		concurrencyCheck();  
	}); 

	function concurrencyCheck(){
		var start=$("#event-startsat").val(),
			end=$("#event-endsat").val(),
			location=$("#event-locationid").val(),
			id=$("#tempkey").val();
			display=$("#concurrencyCheckResult"),
			checkurl=display.data("checkurl");
		if(start.length && end.length){ 
			if(display.data("doconcurrencycheck")){
				console.log("Concurrency Check",  start, end); 
				$.ajax({
					url: checkurl,
					data: {
						start: start,
						end: end,
						location: location,
						id: id
					},
					success: function(r){  
						if(r.length > 0 && display.data("allowoverlappingbookings")){
							$(".submitEvent").addClass("disabled");
						} else {						
							$(".submitEvent").removeClass("disabled");
						}
						$(display).html(r); 
					}
				});
			} else {
				console.log("CC Skipped");
			}
			
		}  
	};

	function checkLayouts(){
			// Get location, i.e 6
		var location=getSelectedLocation(),
			// PLaceholder Array
			layoutArr = new Array(),
			// Get possible layouts for that location
			strlayout=layouts[location],
			// Dropdown to replace
			$el = $("#event-layoutstyle"),
			// Old dropdown value
			oldValue=$el.val();
			// Set default if no custom layouts
			if(!strlayout.length){
				strlayout=<cfoutput>"#application.rbs.setting.roomlayouttypes#"</cfoutput>;
			}
			// Turn list to array
			layoutArr=strlayout.split(',');
			$el.empty(); // remove old options
			$.each(layoutArr, function(value,key) {
				$el.append($("<option></option>").attr("value", key).text(key));
			});
			// Try and match previously selected value to new list
			$el.val(oldValue);
	}

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
		checkLayouts();
		concurrencyCheck();
		restrictResources(true);
	});

	// Remote resource availability check
	$("#resourceTable td[data-unique] input").on("click", function(e){
		var id=$(this).closest("td").data("unique"),
		eventid=<cfoutput><cfif params.action EQ "add">0<cfelse>#event.key()#</cfif></cfoutput>,
		start=$("#event-startsat").val(),
		end=$("#event-endsat").val();
		if(start.length === 0 || end.length === 0){
			alert("You must enter a start and end date/time before attempting to book this resource");
			return false;
		}
		$.ajax({
			url: "<cfoutput>#urlFor(controller='resources', action='checkavailability')#</cfoutput>",
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
					resource.attr({"checked": true}).parent().append("<p class='rCheck text-success'><i class='glyphicon glyphicon-ok'></i></p>");
				} else {
					resource.attr({"checked": false}).parent().append("<p class='rCheck text-danger'><i class='glyphicon glyphicon-warning-sign'></i></p>");
				}
			}
		})
	});
});
</script>
</cfsavecontent>