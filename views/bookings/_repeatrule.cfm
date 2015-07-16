<!--- Repeat Rules --->
<!---

This concept is blatantly nicked from Google Calendar, but hey.
Thing is, Google uses ends='never', so must presumably generate all the repeating event logic for those every time, as you can't add child events 'forever';

So we need a way to:
 - store the repeat logic in the master event for editing (serialize it);
 - generate (quickly) the repeating events logic for 'never' - everything else can have a child event
 - flag events with repeating logic (easy, len(event.repeatlogic))
 - flag events which depend on a master event (easy, len(event.parentid))
 - When events are updated, update all child events if they exist depending on event logic

Repeats can be
 - Daily (type=day)
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
 - Monthly (type=month)
  		- Repeat every 'x' months (repeatEvery)
 		- Repeat by (repeatBy)
 			- DOM
 			- DOW
 		- Starting on (starts)
 		- Ends
 			- Never (isNever)
 			- After 'x' occurences (endsAfter)
			- on 'x' (endsOn)
 - Yearly (type=year)
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
	querySetCell(rTypes, "value", "day", 1);
	querySetCell(rTypes, "text", "Daily", 1);
	querySetCell(rTypes, "value", "weekday", 2);
	querySetCell(rTypes, "text", "Every Weekday", 2);
	querySetCell(rTypes, "value", "mwf", 3);
	querySetCell(rTypes, "text", "Every Mon/Weds/Fri", 3);
	querySetCell(rTypes, "value", "tt", 4);
	querySetCell(rTypes, "text", "Every Tue/Thu", 4);
	querySetCell(rTypes, "value", "week", 5);
	querySetCell(rTypes, "text", "Weekly", 5);
	querySetCell(rTypes, "value", "month", 6);
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
				#select(objectName="event", includeBlank="Never", options=rTypes, association="repeatrule", property="type", label=l("Repeats"))#
 			</div>
 			<div id="repeatrule-fields" class="col-sm-9">

 				<div class="row">
 					<div class="col-sm-4">

				<!--- Repeat Every   days/weeks/months/years--->
 				#select(objectName="event", association="repeatrule", options=lazyList, property="repeatevery", label=l("Repeat Every 'x'") & " <span class='unitoftime'></span>" )#
 					</div>
 					<div class="col-sm-4">

				<!--- Repeat on: m/t/w/t/f/s/s/ --->
				#select(objectName="event", association="repeatrule", options=weekdays, property="repeaton", multiple=true, label=l("Repeat On"))#
 					</div>
 					<div class="col-sm-4">

				<!--- Repeat by --->
				#select(objectName="event", association="repeatrule", options=rBylist, property="repeatby", label="Repeat By" )#
 					</div>
 				</div>

				<!--- Same for all --->
				<div class="row">
					<div class="col-sm-6">

	 				<h4>Starts</h4>
	 				#textField(objectName="event", association="repeatrule", property="starts", label=l("Starts on"))#
					</div>
					<div class="col-sm-6">

					<h4>Ends</h4>
	 				#checkBox(objectname="event", association="repeatrule", property="isnever", label=l("Never"))#

	 				#select(objectname="event", association="repeatrule", property="endsafter", includeBlank="", options=lazyList, label="After 'x' occurences")#

	 				#textField(objectName="event", association="repeatrule", property="endson", label=l("Or on a Certain Date"))#
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

	$("#event-repeatrule-type").on("change", function(e){
		loadEventRuleForm();
	});

	// Generic datepicker
	$("#event-repeatrule-starts, #event-repeatrule-endson").datetimepicker({
		locale: currentLanguage,
		showTodayButton: true,
		format: 'YYYY-MM-DD'
	});

	function enableCommonFields(){
		$("#event-repeatrule-starts, #event-repeatrule-isnever, #event-repeatrule-endsafter, #event-repeatrule-endson").attr({"disabled": false});
	}

	function loadEventRuleForm(){
		var type=$("#event-repeatrule-type").val();
		// Hide all fields by default
		console.log("Loading Rule Form");
		if(typeof type !== "undefined" && type.length){
			disableAllSubFields();
			enableCommonFields();
			console.log(type);
			switch(type) {
			case "day":
				$(".unitoftime").html("Days");
				$("#event-repeatrule-repeatevery").attr({"disabled": false});
				$("#event-repeatrule-repeaton > option").attr("selected",false);
			break;

			case "weekday":
				$("#event-repeatrule-repeaton > option").attr("selected",false);
			break;

			case "mwf":
				$("#event-repeatrule-repeaton > option").attr("selected",false);
			break;

			case "tt":
				$("#event-repeatrule-repeaton > option").attr("selected",false);
			break;

			case "week":
				$(".unitoftime").html("Weeks");
				$("#event-repeatrule-repeatevery, #event-repeatrule-repeaton").attr({"disabled": false});
			break;

			case "month":
				$(".unitoftime").html("Months");
				$("#event-repeatrule-repeatevery, #event-repeatrule-repeatby").attr({"disabled": false});
				$("#event-repeatrule-repeaton > option").attr("selected",false);
			break;

			case "year":
				$(".unitoftime").html("Years");
				$("#event-repeatrule-repeatevery").attr({"disabled": false});
				$("#event-repeatrule-repeaton > option").attr("selected",false);
			break;

			default:
				console.log("Default");
			}
		}
	}

</script>
</cfsavecontent>