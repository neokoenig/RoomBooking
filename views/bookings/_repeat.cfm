<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfoutput>
<div class="well" id="bulk">
	<h4>Bulk create events:</h4>
	<div class="row">
		<div class="col-lg-2">

	#radioButtonTag(name="repeat", value="none", label="Don't Repeat", checked=true)# 
	#radioButtonTag(name="repeat", value="week", label="Weekly")# 
	#radioButtonTag(name="repeat", value="month", label="Monthly")# 
		</div>

	 <div class="col-lg-3">
	#selectTag(name="repeatno", label="How Many More Times?", options="1,2,3,4,5,6,7,8,9,10,11,12,13,14,15", includeBlank=true)#
	</div>
	</div>
	<div id="repeatable-dates"></div>
</div>
<cfsavecontent variable="request.js.repeat">
<script>
$(document).ready(function(){
	/*
	// Trigger JS date creation when these form controls are changed:
	$("input[name=repeat]:radio").change(generateDates);
	$("##repeatno").change(generateDates); 

	// This is purely for display purposes, the actual date creation used is done serverside
	function generateDates(){ 
			var dYear=$("##event-start-year").val();
			var dMonth=($("##event-start-month").val() -1);
			var dDay=$("##event-start-day").val();
			var dHour=$("##event-start-hour").val();
			var dMinute=$("##event-start-minute").val();
			//var d = new Date(dYear,dMonth,dDay,dHour,dMinute,00,00); 
			var d=moment({years: dYear, months: dMonth, days: dDay, hours: dHour, minutes: dMinute});
	 
			// How many iterations?
			var counter = $("##repeatno").val();
			// Weekly or monthly? 
			var repeat=$('##bulk input[name=repeat]:checked').val();
			
			$("##repeatable-dates").html("");
				if(repeat != "none" &  counter > 0){ 
					$("##repeatable-dates").append("<p><strong>Proposed Dates:</p>");
					for(var i = 0; i < counter; i++) {
					 	// New date
					  	var nd = moment({years: dYear, months: dMonth, days: dDay, hours: dHour, minutes: dMinute});
						 	if(repeat == "week"){  
						 		nd.add('days', ((i+1) * 7) ); 
						 	} 
						 	if(repeat == "month"){  
						 		nd.add('months', (i+1)); 
						 	} 
							$("##repeatable-dates").append( 
								"<p>" +  nd.format() + "</p>");
					}
				}
	};
*/

});
</script>
</cfsavecontent>
</cfoutput> 