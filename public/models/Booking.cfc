component extends="Model"
/*
	startUTC is the main event start date
	endUTC is the event end date INCLUDING recurrence
	startUTC + Duration will give that instances enddate (obvs).
*/
{
	function init() {
		// Associations
		belongsTo(name="user");
		belongsTo(name="calendar");
		belongsTo(name="building", joinType="outer");
		belongsTo(name="room", joinType="outer");

		property(name="duration", defaultValue=60);
		property(name="startUTC", defaultValue=now());
		property(name="isallday", defaultValue=0);

		afterFind(methods="splitStartUTC");
		beforeValidation(methods="mergeStartUTC,calculateEndUTC");
		validatesPresenceOf(properties="title,startUTC,endUTC,duration,isallday", message="There are missing required fields");
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

	function splitStartUTC(){
		arguments['startUTCDate']=createDate(year(startUTC),month(startUTC),day(startUTC));
		arguments['startUTCDate']=LSdateFormat(arguments.startUTC, "YYYY-MM-DD");
		arguments['startUTCTime']=createTime(hour(startUTC),minute(startUTC),00);
		arguments['startUTCTime']=LSTimeFormat(arguments.startUTC, "HH:MM");
		return arguments;
	}

	function mergeStartUTC(){
		if(structKeyExists(this, "startUTCDate") && structKeyExists(this, "startUTCTime")){
			this.startUTC=createDateTime(year(this.startUTCDate),month(this.startUTCDate),day(this.startUTCDate),hour(this.startUTCTime),minute(this.startUTCTime),00);
		}
	}
	function calculateEndUTC(){

		if(structKeyExists(this, "repeatpattern") && len(this.repeatpattern) && this.isrepeat){
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
				this.endUTC=createDateTime(9999,12,31,23,59,59);
			}
			// Add Day Event? Set the start/end time appropriately
			if(this.isallday) this.startUTC=createDateTime(year(this.startUTC), month(this.startUTC), day(this.startUTC), 00,00,00);

		} else {
			// Add Day Event? Set the start/end time appropriately
			if(this.isallday){
				// Event duration is in minutes; if duration is under 1440, then ceiling to one day
				var days=(ceiling(this.duration/1440) - 1);
				this.startUTC=createDateTime(year(this.startUTC),month(this.startUTC),day(this.startUTC),00,00,00);
				this.endUTC=dateAdd("d", days, createDateTime(year(this.startUTC),month(this.startUTC),day(this.startUTC),23,59,59));
			} else {
				// Normal event, just add the duration;
				this.endUTC=dateAdd("n", this.duration, this.startUTC);

			}
		}

	}
}
