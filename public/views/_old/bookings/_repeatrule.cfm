<!--- Repeat Rules

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
 	<fieldset id="repeatrules">
 		<legend>#l("Repeat Rules")#</legend>
		<div id="cronexpression"></div>
		#textField(objectName="event", property="cronexpression", label="cronexpression")#

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
$('#cronexpression').cron();
</script>
</cfsavecontent>


