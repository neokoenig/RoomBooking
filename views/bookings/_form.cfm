<!--- Form--->
<cfparam name="locations">
<cfparam name="event">
<cfoutput>
<div class="row">
	<div class="col-lg-4 col-md-4"> 
		#textField(objectname="event", property="title", label="Event Title", placeholder="i.e Committee Meeting")# 
	</div> 
	<div class="col-lg-4 col-md-4"> 
		#select(objectname="event", property="locationid", options=locations, label="Location")#	
	</div>
	<div class="col-lg-4 col-md-4"> 
		#select(objectname="event", property="layoutstyle", options="#application.roombooking.roomlayouttypes#", label="Layout")#	
	</div>
</div>
<div class="row">
	<div class="col-lg-4 col-md-4"> 
		#textField(objectname="event", property="contactname", label="Contact Name", placeholder="i.e Joe Bloggs")# 
	</div> 
	<div class="col-lg-4 col-md-4"> 
		#textField(objectname="event", property="contactno", label="Tel No.", placeholder="i.e 01865 287430")# 
	</div> 
	<div class="col-lg-4 col-md-4"> 
		#textField(objectname="event", property="contactemail", label="Email", placeholder="i.e joe@bloggs.com")# 
	</div>
</div> 

#checkbox(objectName="event", property="allDay", label="This is an all day event")#
 
<div class="row">
	<div class="col-lg-4 col-md-4">  
		#textField(objectName="event", property="start")# 
	</div>
	<div class="col-lg-4 col-md-4">  
		#textField(objectName="event", property="end")#  
	</div>
</div>
	
#textArea(objectName="event", property="description", label="Description", placeholder="Optional Notes about this event")#

<cfsavecontent variable="request.js.datepicker">
<script>
$(document).ready(function(){

	var startDateTextBox = $('##event-start');
	var endDateTextBox = $('##event-end');

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
 /* $(function() {
    $( "##datepickerstart" ).datetimepicker({ 
		stepMinute: 5,
		altField: "##event-start",
		altFieldTimeOnly: false,
		hourMin: 7,
		hourMax: 23,
		minDate: new Date(),
	});
	$( "##datepickerend" ).datetimepicker({ 
		stepMinute: 5,
		altField: "##event-end",
		altFieldTimeOnly: false,
		hourMin: 7,
		hourMax: 23,
		minDate: new Date(),
	});
  });*/
</script>
</cfsavecontent>
</cfoutput>