<cfoutput>
<div class="well" id="bulk">
	<h4>Bulk create events:</h4>
	#radioButtonTag(name="repeat", value="false", label="Don't Repeat", checked=true)# 
	#radioButtonTag(name="repeat", value="week", label="Weekly")# 
	#radioButtonTag(name="repeat", value="month", label="Monthly")# 
	#selectTag(name="repeatno", label="How Many More Times?", options="1,2,3,4,5,6,7,8,9,10,11,12,13,14,15", includeBlank=true)#
	<div id="repeatable-dates"></div>
</div>
<cfsavecontent variable="request.js.repeat">
<script>
$(document).ready(function(){
	// Show javascript dates if selected
	$("##repeatno").change(generateDates);

	function generateDates(){
		var dYear=$("##event-start-year").val();
		var dMonth=($("##event-start-month").val() -1);
		var dDay=$("##event-start-day").val();
		var dHour=$("##event-start-hour").val();
		var dMinute=$("##event-start-minute").val();
		var d = new Date(dYear,dMonth,dDay,dHour,dMinute,00,00); 
		// How many iterations?
		var counter = $(this).val();
		// Weekly or monthly? 
		var repeat=$('##bulk input[name=repeat]:checked').val();
		// Create Dates
		alert(repeat);
		// Clear existing display
		$("##repeatable-dates").html("");
		for(var i = 0; i < counter; i++) {
		 	// New date
		  	var nd = new Date(dYear,dMonth,dDay,dHour,dMinute,00,00);
		 	if(repeat == "week"){  
		 		nd.setDate( nd.getDate( ) + ((i+1) * 7) ); 
		 	} 
		 	if(repeat == "month"){ 
				nd.setMonth( nd.getMonth( ) + ((i+1)) ); 
		 	}
			$("##repeatable-dates").append("<p>" + nd + "</p>");
		}
	}
});
</script>
</cfsavecontent>
</cfoutput> 