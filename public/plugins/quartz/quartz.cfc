component hint="cfWheels Quartz Plugin" output="false" mixin="global"
{
	/**
	 * @hint Constructor.
	 */
	public  function init() {
		this.version = "1.4.5";
		return this;
	}

	// Given a date range, a cron expression and a view port date range, get all dates which fall within that range
	// and satisfy the cron Expression.
	public array function getCronDateRange(
		date startDate=now(),
		date endDate=dateAdd("n", 60, now()),
		date viewPortStartDate=now(),
		date viewPortendDate=dateAdd("d", 30, now()),
		string cron="* * * * * ?"
	){
		local.rv=[];
		local.loopDate=startDate;
		local.cronTabExpression = $$getCrontabExpressionObject( trim(arguments.cron) );

		// Include the original date in the RV if it falls in viewport
		if(dateCompare(local.loopDate, viewPortStartDate) GTE 0 && dateCompare(local.loopDate, viewPortendDate) LTE 0){
			arrayAppend(local.rv, local.loopDate);
		}

		// Loop it
		while(dateCompare(local.loopDate, viewPortendDate) LTE 0) {
			local.loopDate=local.cronTabExpression.getNextValidTimeAfter( loopDate  ).toString();
			if(dateCompare(local.loopDate, viewPortStartDate) GT 0
				&& dateCompare(local.loopDate, viewPortendDate) LTE 0){
				arrayAppend(local.rv, createDateTime(year(loopDate), month(loopDate), day(loopDate), hour(loopDate), minute(loopDate), 00));
			}

		}
		return local.rv;
	}

	// Given a date range, a cron expression and a view port date range, get all dates which fall within that range
	// and satisfy the cron Expression. Limit to number of iterations
	public array function getCronDateIteration(
		date startDate=now(),
		date endDate=dateAdd("n", 60, now()),
		date viewPortStartDate=now(),
		date viewPortendDate=dateAdd("d", 30, now()),
		string cron="* * * * * ?",
		numeric iterations=10
	){
		local.rv=[];
		local.loopDate=startDate;
		local.cronTabExpression = $$getCrontabExpressionObject( trim(arguments.cron) );
		local.iterations=iterations;

		if(!getViewPortConditions(startDate,startDate,viewPortStartDate,viewPortendDate)){
			return [];
		}

		// Include the original date in the RV if in viewport
		if(dateCompare(local.loopDate, viewPortStartDate) GTE 0 && dateCompare(local.loopDate, viewPortendDate) LTE 0){
			arrayAppend(local.rv, local.loopDate);
			local.iterations--;
		}
		// Loop must start with startDate, but only return results between viewPortStartDate + viewPortendDate
		while(arraylen(local.rv) LTE local.iterations) {
			local.loopDate=local.cronTabExpression.getNextValidTimeAfter( loopDate  ).toString();
			if(dateCompare(local.loopDate, viewPortendDate) LT 0){
			arrayAppend(local.rv, createDateTime(year(loopDate), month(loopDate), day(loopDate), hour(loopDate), minute(loopDate), 00));

			}
		}
		return local.rv;
	}

	// View port conditions
	// Given "startDate", return true/false depending on whether it falls within the viewport
	public boolean function getViewPortConditions(
		date start1,
		date end1,
		date start2,
		date end2
	){
		 if(start2 < start1 && end2 < dateAdd("s", 1, start1) || dateAdd("s", 1, start2) > end1 ){
            return false;
        }
        return true;
	}

	// Given a date and a cron expression, get the next valid date
	// Try and avoid looping this as it will create a new object each time
	public function getNextRunDate(date lastRun=Now(), string cron="* * * * * *"){
		local.cronTabExpression = $$getCrontabExpressionObject( trim(arguments.cron) );
		local.date = local.cronTabExpression.getNextValidTimeAfter( lastRun  ).toString();
		return createDateTime(year(local.date), month(local.date), day(local.date), hour(local.date), minute(local.date), 00)
	}
	// Main Quartz Java Lib
	public any function $$getCrontabExpressionObject( required string expression ) {
	    return CreateObject( "java", "org.quartz.CronExpression" ).init( arguments.expression );
	}

	// Java lib to return human readable interpretation of a cron expression
	public string function $$cronTabExpressionToHuman( required string expression ) {
		return CreateObject( "java", "net.redhogs.cronparser.CronExpressionDescriptor").getDescription( arguments.expression );
	}

    /**
    *  @hint Take an array of dates, create start and end dates based on single event date/time and return
    *  @param date eventStart
    *  @param numeric duration (in minutes)
    *  @array dates Existing array of dates
    */
    public array function addEventDuration(
        required date eventStart,
        required numeric duration,
        required array dates) {
        var r=[];
        var repeatingEventStart= "";
        var repeatingEventEnd  = "";
        // Make sure 'date' has no min / hour value
        for(date in dates){
            repeatingEventStart= createDateTime(year(date), month(date), day(date), hour(eventStart), minute(eventStart), 00);
            repeatingEventEnd  = dateAdd("n", duration, repeatingEventStart);
            arrayAppend(r, {
                start: repeatingEventStart,
                end:   repeatingEventEnd,
                duration: duration
            });
        }
        return r;
    }

	/**
	*  @hint Given a date and a type, generate a cron string for Quartz
	*  @param date 		date      	: The Main base Date
	*  @param string 	type      	: one of daily,weekday,mwf,tt,ss,weekly,weeklyDOW,monthly,monthlyDOW,yearly
	*  @param numeric 	every     	: optional i.e, Every 3rd week, or 2nd day etc
	*  @param string 	dow 		: optional; comma delim list for specific days of week, i.e, 2,4,7
	*
	*	daily - i.e, every day
	*	weekday - i.e, every weekday
	*	mwf - i.e, every mon/weds/fri
	*	tt - i.e every tue/thurs
	*	ss - i.e every sat/sun
	*	weekly - i.e, same day every week
	*	weeklyDOW - i.e, every week on these days
	*	monthly - i.e, every month on this Day of the Month
	*	monthlyDOW - i.e, every month on this Day of the Week
	*	yearly - i.e, every year on this day
	*/

	public string function generateCronExpression(
		date 	date=now(),
		string 	type="daily",
		numeric every=1,
		string  dow=""
	){
		local.arr=["*","*","*","*","*","*"];
		// Take seconds from date
		local.arr[1]=second(date);
		// Take minutes from date
		local.arr[2]=minute(date);
		// Take hours from date
		local.arr[3]=hour(date);

		/*
		4 Day-of-month	 	1-31	 	, - * ? / L W
		5 Month	 	1-12 or JAN-DEC	 	, - * /
		6 Day-of-Week	 	1-7 or SUN-SAT	 	, - * ? / L #
		7 Year (Optional)	 	empty, 1970-2199	 	, - * /
		*/
		switch(type){
			case "daily":
				// Crontrigger doesn't support going over months, so switch to 48hours etc if doing every 2 days
				local.arr[4]="*";
				local.arr[6]="?";
			break;
			case "weekday":
				local.arr[4]="?";
				local.arr[6]="MON,TUE,WED,THU,FRI";
			break;
			case "mwf":
				local.arr[4]="?";
				local.arr[6]="MON,WED,FRI";
			break;
			case "tt":
				local.arr[4]="?";
				local.arr[6]="TUE,THU";
			break;
			case "ss":
				local.arr[4]="?";
				local.arr[6]="SAT,SUN";
			break;
			case "weekly":
				local.arr[4]="?";
				local.arr[6]=ucase(dayOfWeekShortAsString(dayofweek(date)));
			break;
			case "weeklydow":
				local.arr[4]="?" & '/' & every;
				local.dow=listToArray(dow);
				local.dowlist="";
				for(d in local.dow){
					local.dowlist=listAppend(local.dowlist, ucase(dayOfWeekShortAsString(d)));
				}
				local.arr[6]=local.dowlist;
			break;
			case "monthly":
				local.arr[4]=day(date);
				local.arr[5]="*" & "/" & every;
				local.arr[6]="?";
			break;
			case "monthlydow":
				local.domAsPosition=$$positionInMonth(date);
				local.arr[4]="?";
				local.arr[5]="*" & "/" & every;
				// Check for "Last"
				if(isNumeric(local.domAsPosition)){
					local.arr[6]=ucase(dayOfWeekShortAsString(dayofweek(date))) & "##" & local.domAsPosition;
				} else {
					local.arr[6]=ucase(dayOfWeekShortAsString(dayofweek(date))) & local.domAsPosition;
				}
			break;
			case "yearly":
				local.arr[4]=day(date);
				local.arr[5]=month(date);
				local.arr[6]="*";
				arrayAppend(local.arr, "*/" & every);
			break;
		}
		// Return a string
		local.rv=arrayToList(local.arr, " ");
		return local.rv;
	}

    /**
     * Returns a date object of the first occurrence of a specified day in the given month and year.
     * v1.0 by Troy Pullis
     * v1.1 by Adam Cameron (improved/simplified logic, added error handling)
     *
     * @param dayOfWeek      An integer in the range 1 - 7. 1=Sun, 2=Mon, 3=Tue, 4=Wed, 5=Thu, 6=Fri, 7=Sat. (Required)
     * @param month      Month value.  (Required)
     * @param year   Year value. (Required)
     * @return The date of the first [dayOfWeek] of the specified month/year
     * @author Troy Pullis (tpullis@yahoo.com)
     * @version 1.1, July 6, 2014
     */
     public date function $$firstXDayOfMonth(required numeric dayOfWeek, required numeric month, required numeric year){
        if (dayOfWeek < 1 || dayOfWeek > 7){
            throw(type="InvalidDayOfWeekException", message="Invalid day of week value", detail="the dayOfWeek argument must be between 1-7 (inclusive).");
        }
        var firstOfMonth    = createDate(year, month,1);
        var dowOfFirst      = dayOfWeek(firstOfMonth);
        var daysToAdd       = (7 - (dowOfFirst - dayOfWeek)) MOD 7;
        var dow = dateAdd("d", daysToAdd, firstOfMonth);
        return dow;
    }
	 /**
    *  @hint Work out whether the date is the 1st/2nd/3rd/4th/Lastth occurance in the month
    */
    public any function $$positionInMonth(
        required date thedate){
        var firstX =  $$firstXDayOfMonth(dayOfWeek(thedate), month(thedate), year(thedate));
        var firstx1 = dateAdd("d", (1 * 7), firstX );
        var firstx2 = dateAdd("d", (2 * 7), firstX );
        var firstx3 = dateAdd("d", (3 * 7), firstX );
        var firstx4 = dateAdd("d", (4 * 7), firstX );
        var isXinMonth=1;
        if(dateFormat(thedate, "dd") EQ dateFormat(firstX1, "dd")){
            isXinMonth=2;
        }
        if(dateFormat(thedate, "dd") EQ dateFormat(firstX2, "dd")){
            isXinMonth=3;
        }
        if(dateFormat(thedate, "dd") EQ dateFormat(firstX3, "dd")){
            isXinMonth=4;
        }
        if(dateFormat(thedate, "dd") EQ dateFormat(firstX4, "dd")){
            isXinMonth="L";
        }
        return isXinMonth;
    }
}
