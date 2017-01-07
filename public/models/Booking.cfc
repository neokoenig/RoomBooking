component extends="Model"
/*
	startUTC is the main event start date
	endUTC is the event end date INCLUDING recurrence
	startUTC + Duration will give that instances enddate (obvs).
*/
{
	function init() {
		belongsTo(name="user");
		belongsTo(name="calendar");
		belongsTo(name="building", joinType="outer");
		belongsTo(name="room", joinType="outer");

		property(name="duration", defaultValue=60);
		property(name="startUTC", defaultValue=now());

		beforeValidation(methods="calculateEndUTC");
		validatesPresenceOf(properties="title,startUTC,endUTC,duration", message="There are missing required fields");
		validatesnumericalityof(properties="userid", message="An owner is required for any booking");
		validate(methods="validateDates,validateLocation");

	}

	function validateDates(){
		if(structKeyExists(this, "startUTC") && structKeyExists(this, "endUTC")){
			if(this.startUTC > this.endUTC){
				this.addError(property="startUTC", message="Start Time can't be after End Time");
			}
		}
	}
	function validateLocation(){
		 if(structKeyExists(this, "buildingid") || structKeyExists(this, "roomid")){
		 } else {
			this.addError(property="buildingid", message="Either a Room or Building is required");
		 }
	}
	function calculateEndUTC(){
		if(structKeyExists(this, "repeatpattern")){
			var rrule=parseRRuleString(this.repeatpattern);
			// if there's an UNTIL rrule, set that as the enddate (plus duration?)
			if(structKeyExists(rrule, "UNTIL")){
				this.endUTC=dateAdd("n", this.duration,
					createDateTime(left(rrule.UNTIL, 4),Mid(rrule.UNTIL, 5, 2),Mid(rrule.UNTIL, 7, 2),hour(this.startUTC),minute(this.startUTC),00)
				);
			// if there's a COUNT, calculate the true end date from the iterations
			} else if(structKeyExists(rrule, "COUNT")){
				var d=getRecurringDates(
					replace(this.repeatpattern, "RRULE:", "", "all"),
					createDate(year(this.startUTC), month(this.startUTC), day(this.startUTC)),
					createDate(year(this.startUTC), month(this.startUTC), day(this.startUTC)),
					createDate(9999,12,31)
				);
				var lastDate=d[arrayLen(d)];
				this.endUTC=dateAdd("n", this.duration,
					createDateTime(year(lastDate),month(lastDate),day(lastDate),hour(this.startUTC),minute(this.startUTC),00)
				);
			} else {
			// if there's no rrule end date (UNTIL), and no COUNT, set maxdate
				this.endUTC=createDateTime(9999,12,31,00,00,00);
			}
		} else {
			// Normal event, just add the duration
			this.endUTC=dateAdd("n", this.duration,this.startUTC);
		}

	}
}
