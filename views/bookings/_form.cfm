<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Form--->
<cfparam name="locations">
<cfparam name="resources">
<cfparam name="event">
<cfoutput>


  	#includePartial("tabs/details")#
	#includePartial("tabs/contact")#
	<cfif application.rbs.setting.allowResources>
	#includePartial("tabs/resources")#
	</cfif>
	<cfif params.action EQ "add" OR params.action EQ "create">
		#includePartial("tabs/repeat")#
	</cfif>

</cfoutput>

<cfsavecontent variable="request.js.datepicker">
<script>
$(document).ready(function(){
	// Popovers
	$('.pop').popover({});
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

	// Tabs
	$(function () {
		$('#myTab a:first').tab('show')
	})

	// Alter Time on All Day checkbox
	$("#event-allDay").on("click", function(e){
		var s=startDateTextBox.datetimepicker('getDate'),
		 	e=endDateTextBox.datetimepicker('getDate');
		 	if(s !== null){
				s.setHours(0,0,0,0);
				$('#event-start').datetimepicker('setDate', (s));
		 	}
		 	if(e !== null){
				e.setHours(23,59,0,0);
				$('#event-end').datetimepicker('setDate', (e));
		 	}
	});

	// Date Pickers
	var startDateTextBox = $('#event-start');
	var endDateTextBox = $('#event-end');

	startDateTextBox.datetimepicker({
		timeFormat: 'HH:mm',
		dateFormat: 'yy-mm-dd',
		hourMin: 7,
		stepMinute: 5,
		hourMax: 23,
		minDate: new Date(),
		onClose: function(dateText, inst) {
			if (endDateTextBox.val() != '') {
				var testStartDate = startDateTextBox.datetimepicker('getDate');
				var testEndDate = endDateTextBox.datetimepicker('getDate');
				if (testStartDate > testEndDate)
					endDateTextBox.datetimepicker('setDate', testStartDate);
			}
			else {
				endDateTextBox.val(dateText);
			}
		},
		onSelect: function (selectedDateTime){
			endDateTextBox.datetimepicker('option', 'minDate', startDateTextBox.datetimepicker('getDate') );
		}
	});
	endDateTextBox.datetimepicker({
		timeFormat: 'HH:mm',
		dateFormat: 'yy-mm-dd',
		onClose: function(dateText, inst) {
			if (startDateTextBox.val() != '') {
				var testStartDate = startDateTextBox.datetimepicker('getDate');
				var testEndDate = endDateTextBox.datetimepicker('getDate');
				if (testStartDate > testEndDate)
					startDateTextBox.datetimepicker('setDate', testEndDate);
			}
			else {
				startDateTextBox.val(dateText);
			}
		},
		onSelect: function (selectedDateTime){
			startDateTextBox.datetimepicker('option', 'maxDate', endDateTextBox.datetimepicker('getDate') );
		}
	});

});
</script>
</cfsavecontent>