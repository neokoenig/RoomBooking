<!--- Repeat Rules --->
<!---

This concept is blatantly nicked from Google Calendar, but hey.
Thing is, Google uses ends='never', so must presumably generate all the repeating event logic for those every time, as you can't add child events 'forever';

So we need a way to:
 - store the repeat logic for an event, and it should be editable 'after' creation
 - generate (quickly) the repeating events logic for the current viewport;

Assuming we're looking at a calendar view (say From: 01-01-2015 => To: 15-02-2015), we need to get events for the following conditions:
 - Non repeating events which fall within From/To Date: this means checking for events whose *range* falls inbetween the view range.
  	- So, we'd need to do events=model("event")


Repeats can be
 - Daily (type=daily)
 		- Repeat every 'x' days (repeatEvery)
 		- Starting on (starts)
 		- Ends
 			- Never (isNever)
 			- After 'x' occurences (endsAfter)
			- on 'x' (endsOn)
 - Every Weekday (type=weekday)
		- Starting on (starts)
		- Ends
 			- Never (isNever)
 			- After 'x' occurences (endsAfter)
			- on 'x' (endsOn)
 - Every Mon/Weds/Fri (type=mwf)
		- Starting on (starts)
		- Ends
 			- Never (isNever)
 			- After 'x' occurences (endsAfter)
			- on 'x' (endsOn)
 - Every Tue/Thu (type=tt)
		- Starting on (starts)
		- Ends
 			- Never (isNever)
 			- After 'x' occurences (endsAfter)
			- on 'x' (endsOn)
 - Weekly (type=week)
 		- Repeat every 'x' weeks (repeatEvery)
 		- Repeat On (repeatOn)
 			M/T/W/T/F/S/S
 		- Starting on (starts)
 		- Ends
 			- Never (isNever)
 			- After 'x' occurences (endsAfter)
			- on 'x' (endsOn)
 - Monthly (type=monthly)
  		- Repeat every 'x' months (repeatEvery)
 		- Repeat by (repeatBy)
 			- DOM
 			- DOW
 		- Starting on (starts)
 		- Ends
 			- Never (isNever)
 			- After 'x' occurences (endsAfter)
			- on 'x' (endsOn)
 - Yearly (type=yearly)
  		- Repeat every 'x' years (repeatEvery)
 		- Starting on (starts)
 		- Ends
 			- Never (isNever)
 			- After 'x' occurences (endsAfter)
			- on 'x' (endsOn)
--->
<cfscript>
	rTypes=queryNew("value,text");
	queryAddRow(rTypes, 7);
	querySetCell(rTypes, "value", "daily", 1);
	querySetCell(rTypes, "text", "Daily", 1);
	querySetCell(rTypes, "value", "weekday", 2);
	querySetCell(rTypes, "text", "Every Weekday", 2);
	querySetCell(rTypes, "value", "mwf", 3);
	querySetCell(rTypes, "text", "Every Mon/Weds/Fri", 3);
	querySetCell(rTypes, "value", "tt", 4);
	querySetCell(rTypes, "text", "Every Tue/Thu", 4);
	querySetCell(rTypes, "value", "weekly", 5);
	querySetCell(rTypes, "text", "Weekly", 5);
	querySetCell(rTypes, "value", "monthly", 6);
	querySetCell(rTypes, "text", "Monthly", 6);
	querySetCell(rTypes, "value", "year", 7);
	querySetCell(rTypes, "text", "Yearly", 7);

	lazyList="1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30";
	rBylist={dom:"Day of Month", dow: "Day of Week"};
	weekdays=queryNew("value,text");
	x=1;
	while(x LT 8){
		queryAddRow(weekdays);
		querySetCell(weekdays, "value", x, x);
		querySetCell(weekdays, "text", DayOfWeekAsString(x, request.lang.current), x);
		x++;
	}
</cfscript>
<!--- Repeat Form --->
<cfoutput> 
 	<fieldset> 
 		<legend>#l("Repeat Rules")#</legend>
 		<div class="row">
 			<div class="col-sm-3">
				#select(objectName="event", includeBlank="Never", options=rTypes, property="type", label=l("Repeats"))#
 			</div>
 			<div id="repeatrule-fields" class="col-sm-9">

 				<div class="row">
 					<div class="col-sm-4">

				<!--- Repeat Every   days/weeks/months/years--->
 				#select(objectName="event", options=lazyList, property="repeatevery", label=l("Repeat Every 'x'") & " <span class='unitoftime'></span>" )#
 					</div>
 					<div class="col-sm-4">

				<!--- Repeat on: m/t/w/t/f/s/s/ --->
				#select(objectName="event", options=weekdays, property="repeaton", multiple=true, label=l("Repeat On"))#
 					</div>
 					<div class="col-sm-4">

				<!--- Repeat by --->
				#select(objectName="event", options=rBylist, property="repeatby", label="Repeat By" )#
 					</div>
 				</div>

				<!--- Same for all --->
				<div class="row">
					<div class="col-sm-6">

	 				<h4>Start Repeating On</h4>
	 				#textField(objectName="event", property="repeatstarts", label=l("Starts on"))#
					</div>
					<div class="col-sm-6">

					<h4>Ends</h4>
	 				#checkBox(objectname="event", property="isnever", label=l("Never"))#

	 				#select(objectname="event", property="repeatendsafter", includeBlank="", options=lazyList, label="After 'x' occurences")#

	 				#textField(objectName="event", property="repeatendson", label=l("Or on a Certain Date"))#
					</div>
				</div>  
 			</div>
 		</div>
	</fieldset>
</cfoutput>
<cfsavecontent variable="request.js.repeatrules">
<script>
//RM this when moving to main.js
var currentLanguage=$("html").attr("lang");

	// Try and show/hide the relevant form fields
	disableAllSubFields();
	loadEventRuleForm();

	// Disable everythign by default
	function disableAllSubFields(){
		$("#repeatrule-fields :input").attr({"disabled": true});
	}

	$("#event-type").on("change", function(e){
		loadEventRuleForm();
	});

	// Generic datepicker
	$("#event-repeatstarts, #event-repeatendson").datetimepicker({
		locale: currentLanguage,
		showTodayButton: true,
		format: 'YYYY-MM-DD'
	});

	function enableCommonFields(){
		$("#event-repeatstarts, #event-isnever, #event-repeatendsafter, #event-repeatendson").attr({"disabled": false});
	}

	$("#event-isnever").on("click", function(e){
		var isnever = $("#event-isnever:checked").length;
		if(isnever){
			$("#event-repeatendsafter, #event-repeatendson").attr({disabled:true});
		} else {
			$("#event-repeatendsafter, #event-repeatendson").attr({disabled:false});
		}
	});

	$("#event-repeatendsafter").on("change", function(e){
		if($(this).val().length){
			$("#event-isnever, #event-repeatendson").attr({disabled:true});
		} else {
			$("#event-isnever, #event-repeatendson").attr({disabled:false});
		}
	});

	$("#event-repeatendson").on("click", function(e){
		if($(this).val().length){
			$("#event-isnever, #event-repeatendsafter").attr({disabled:true});
		} else {
			$("#event-isnever, #event-repeatendsafter").attr({disabled:false});
		}
	});

	function loadEventRuleForm(){
		var type=$("#event-type").val();
		// Hide all fields by default
		console.log("Loading Rule Form");
		if(typeof type !== "undefined" && type.length){
			disableAllSubFields();
			enableCommonFields();
			console.log(type);
			switch(type) {
			case "daily":
				$(".unitoftime").html("Days");
				$("#event-repeatevery").attr({"disabled": false});
				$("#event-repeaton > option").attr("selected",false);
			break;

			case "weekday":
				$("#event-repeaton > option").attr("selected",false);
			break;

			case "mwf":
				$("#event-repeaton > option").attr("selected",false);
			break;

			case "tt":
				$("#event-repeaton > option").attr("selected",false);
			break;

			case "weekly":
				$(".unitoftime").html("Weeks");
				$("#event-repeatevery, #event-repeaton").attr({"disabled": false});
			break;

			case "monthly":
				$(".unitoftime").html("Months");
				$("#event-repeatevery, #event-repeatby").attr({"disabled": false});
				$("#event-repeaton > option").attr("selected",false);
			break;

			case "yearly":
				$(".unitoftime").html("Years");
				$("#event-repeatevery").attr({"disabled": false});
				$("#event-repeaton > option").attr("selected",false);
			break;

			default:
				console.log("Default");
			}
		}
	}

</script>
</cfsavecontent>