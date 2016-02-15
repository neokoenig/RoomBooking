component hint="cfWheels Date Repeat Plugin" output="false" mixin="global"
{
	/**
	 * @hint Constructor.
	 */
	public  function init() {
		this.version = "1.4.4"; 
		return this;
	}

	/**
	*  @hint The Main Function
	*  @param date 		date      	: The Main Date to repeat (required)
	*  @param date 		from      	: Date to repeat From (required unless iteration)
	*  @param date 		till      	: Date to repeat Till (required unless iteration)
	*  @param string 	type      	: one of list below
	*  @param numeric 	every     	: i.e, Every 3rd week, or 2nd day etc
	*  @param numeric 	iterations	: optional; return a set number of results instead of range
	*  @param string 	dow 		: optional; on specific days of week
    *  @param date      filterstart : optional, filter results to a specific range (useful for calendars where you want to limit results to a specific viewport)
    *  @param date      filterend   : optional, filter results to a specific range
	*/

	/*
		daily - i.e, every day
		weekday - i.e, every weekday
		mwf - i.e, every mon/weds/fri
		tt - i.e every tue/thurs
		ss - i.e every sat/sun
		weekly - i.e, same day every week
		weeklyDOW - i.e, every week on these days
		monthly - i.e, every month on this Day of the Month
		monthlyDOW - i.e, every month on this Day of the Week
		yearly - i.e, every year on this day
	*/
	public array function repeatDate(
		date 	date=now(),
		string 	type="daily",
		date 	from=date,
		date 	till=dateAdd("d", 6, date),
		numeric every=1,
		numeric iterations=0,
		string  dow="",
        date    filterstart,
        date    filterend
	){ 
		var r=[];

		// How are we calculating dates?
		if(isnumeric(iterations) AND iterations > 0){ 
            /*
            Iterations - i.e, repeat 'x' times - filter logic like which day of the week is applied in the loop itself
            */ 
            switch(type){
                case "daily":
                    r=$returnDateIterativeArray(argumentCollection=arguments);  
                break;
                case "weekday":
                    r=$returnDateIterativeArray(argumentCollection=arguments, dow="2,3,4,5,6"); 
                break;
                case "mwf":
                    r=$returnDateIterativeArray(argumentCollection=arguments, dow="2,4,6");   
                break;
                case "tt":
                    r=$returnDateIterativeArray(argumentCollection=arguments, dow="3,5");  
                break;
                case "ss":
                    r=$returnDateIterativeArray(argumentCollection=arguments, dow="1,7");  
                break;
                case "weekly":
                    r=$returnDateIterativeArray(argumentCollection=arguments, datepart="ww");   
                break;
                case "weeklydow":
                    r=$returnDateIterativeArrayWeekly(argumentCollection=arguments, dow=dow, datepart="ww");
                break; 
                case "monthly":
                    r=$returnDateIterativeArray(argumentCollection=arguments, datepart="m");  
                break; 
                case "monthlydow":
                    r=$returnDateIterativeArrayMonth(argumentCollection=arguments);
                break;
                case "yearly":
                    r=$returnDateIterativeArray(argumentCollection=arguments, datepart="yyyy"); 
                break;
            }
		} else { 
            /*
            By Range: all dates for range are calculated, then filtered as required
            */
			switch(type){
				case "daily":
					r=$returnDateRangeArray(argumentCollection=arguments);  
				break;
				case "weekday":
					r=$returnDateRangeArray(argumentCollection=arguments);  
					r=$filterDatesByDOW(dates=r, dow="2,3,4,5,6");
				break;
				case "mwf":
					r=$returnDateRangeArray(argumentCollection=arguments);  
					r=$filterDatesByDOW(dates=r, dow="2,4,6");
				break;
				case "tt":
					r=$returnDateRangeArray(argumentCollection=arguments);  
					r=$filterDatesByDOW(dates=r, dow="3,5");
				break;
				case "ss":
					r=$returnDateRangeArray(argumentCollection=arguments);  
					r=$filterDatesByDOW(dates=r, dow="1,7");
				break;
				case "weekly":
					r=$returnDateRangeArray(argumentCollection=arguments, datepart="ww");   
				break;
				case "weeklydow":
					r=$returnDateRangeArrayWeek(argumentCollection=arguments, datepart="d"); 
                    r=$filterDatesByWeek(dates=r, every=every);  
                    r=$filterDatesByDOW(dates=r, dow=dow);   
				break;
				case "monthly":
					r=$returnDateRangeArray(argumentCollection=arguments, datepart="m");  
				break;
				case "monthlydow":
					r=$returnDateRangeArrayMonth(argumentCollection=arguments);
				break;
				case "yearly":
					r=$returnDateRangeArray(argumentCollection=arguments, datepart="yyyy"); 
				break;
			}
		}
        if(structKeyExists(arguments, "filterstart") && structKeyExists(arguments, "filterend") && isDate(filterstart) && isDate(filterend) && isArray(r)){
            r=$filterDatesByRange(dates=r, filterstart=filterstart, filterend=filterend);
        }
		return r;
	}



    /**
    *  @hint Take an array of dates, create start and end dates based on single event date/time
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
    *  @hint Work out whether a specified time range overlaps with another;
    *  Don't consider 9-10 & 10-11 to clash.
    */
    public boolean function isTimeClash(
        required date start1,
        required date end1
        required date start2,
        required date end2 
    ) {
        if(start2 < start1 && end2 < dateAdd("s", 1, start1) || dateAdd("s", 1, start2) > end1 ){
            return false;
        }
        return true;
    }

    /**
    *  @hint Simply loop over dates a set number of times
    */
    public array function $returnDateIterativeArray(
        string datepart="d",
        string dow="" 
    ) {
        var r=[];
        var c=1;
        var lDate=dateAdd("d", 0, date);
        while(c LTE iterations){ 
                if(len(arguments.dow)){
                    if( $isInDOW(dow, lDate) ){ 
                        arrayAppend(r, lDate); 
                        lDate=dateAdd(datepart, every, lDate);       
                        c++;
                    } else {
                        lDate=dateAdd(datepart, every, lDate);  
                    }
                } else { 
                    arrayAppend(r, lDate); 
                    lDate=dateAdd(datepart, every, lDate);       
                    c++; 
                } 
        } 
        return r;
    }

    /**
    *  @hint Simply loop over dates a set number of times
    */
    public array function $returnDateIterativeArrayWeekly( 
        string dow="" 
    ) {
        var r=[];
        var c=1;
        var lDate=dateAdd("d", 0, date);
        var firstweek=week(lDate);
        var currentweek=firstweek;
        while(c LTE iterations){ 
            if(len(arguments.dow)){
                if(!(currentWeek - firstweek) MOD every){
                    if( $isInDOW(dow, lDate) ){ 
                        arrayAppend(r, lDate); 
                        lDate=dateAdd("d", 1, lDate);       
                        c++;
                    } else {
                        lDate=dateAdd("d", 1, lDate);  
                    }
                } else {
                    lDate=dateAdd("d", 7, lDate);  
                }
               
            } else { 
                arrayAppend(r, lDate); 
                lDate=dateAdd("d", 1, lDate);       
                c++; 
            } 
            currentWeek=week(ldate);
        } 
        return r;
    }


    /**
    *  @hint Given a start/end date, return all dates which fall in that range
    */
    public array function $returnDateRangeArray(string datepart="d") {
        var r=[];
        var lDate=dateAdd("d", 0, date);
        while(dateCompare(lDate, till) LTE 0){
            if(dateCompare(lDate, from) GTE 0){
                arrayAppend(r, lDate);
            }
            lDate=dateAdd(datepart, every, lDate);
        }  
        return r;
    }
    /**
    *  @hint Given a start/end date, return all dates which fall in that range
    */
    public array function $returnDateRangeArrayWeek(string datepart="d") {
        var r=[];
        var lDate=dateAdd("d", 0, date); 
        while(dateCompare(lDate, till) LTE 0){
            if(dateCompare(lDate, from) GTE 0){
                arrayAppend(r, lDate);
            }
            lDate=dateAdd("d", 1, lDate);
        }  
        return r;
    }
 
 
    /**
    *  @hint Given a number of times, return all dates which satisfy the 'x' of the month
    **/
    public array function $returnDateIterativeArrayMonth() {
        var r=[]; 
        var c=1;
        var lDate=dateAdd("d", 0, date);
        var isXinMonth=$positionInMonth(lDate); 
        while(c LTE iterations){
            isXinMonth=$positionInMonth(lDate); 
            nDate=$GetNthDayOfMonth(Month=lDate, DayOfWeek=dayofWeek(from), Nth=isXinMonth); 
            arrayAppend(r, nDate);
            lDate=dateAdd("m", every, lDate);
            c++;
        } 
        return r;
    }

    /**
    *  @hint Given a start/end date, return all dates which satisfy the 'x' of the month
    **/
    public array function $returnDateRangeArrayMonth() {
        var r=[]; 
        var lDate=dateAdd("d", 0, date);
         var isXinMonth=$positionInMonth(lDate); 
        while(dateCompare(lDate, till) LTE 0){
            if(dateCompare(lDate, from) GTE 0){
                isXinMonth=$positionInMonth(lDate); 
                nDate=$GetNthDayOfMonth(Month=lDate, DayOfWeek=dayofWeek(from), Nth=isXinMonth);  
                arrayAppend(r, nDate);
            }
            lDate=dateAdd("m", every, lDate);
        }   
        return r;
    }

  	/**
    *  @hint Filter an array of dates by days of the week
    */
    public array function $filterDatesByDOW(
        required array dates,
        required string dow ) {
        var r=[];
        for(date in dates){ 
            if( $isInDOW(dow, date) ){
                arrayAppend(r,date);
            }  
        }
        return r;
    } 

    /**
    *  @hint DOW filter
    */
    public boolean function $isInDOW(
        required string dow,
        required date thedate 
    ) {
        return listFind(dow, dayOfWeek(thedate) );
    }
  

    /**
    *  @hint Work out whether the date is the 1st/2nd/3rd/4th/5th occurance in the month
    */
    public number function $positionInMonth(
        required date thedate){
        var firstX =  $firstXDayOfMonth(dayOfWeek(thedate), month(thedate), year(thedate));
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
            isXinMonth=5;
        }
        return isXinMonth;
    }


    /**
    *  @hint I return the Nth instance of the given day of the week for the given month (ex. 2nd Sunday of the month).
    */
    public date function $GetNthDayOfMonth(
        required date Month,
        required numeric dayOfWeek,
        numeric Nth="1") {
        var loc={}; 
        arguments.Month = CreateDate(Year( arguments.Month ), Month( arguments.Month ), 1);
        if (DayOfWeek( arguments.Month ) LTE arguments.DayOfWeek){
            loc.Date = (arguments.Month + (arguments.DayOfWeek - DayOfWeek( arguments.Month )));
        } else {
            loc.Date = (arguments.Month + (7 - DayOfWeek( arguments.Month )) + arguments.DayOfWeek);
        }
        loc.Date += (7 * (arguments.Nth - 1));
        loc.DAte=createDate(year(loc.Date), month(loc.Date), day(loc.date));
        // If Nth == 5, but it gets pushed into next month, treat as 'last' (i.e, 4th)
        if(month(loc.date) EQ Month( arguments.Month )){
            return dateFormat(loc.date, "YYYY-MM-DD") ;            
        } else {
            return $GetNthDayOfMonth(month=arguments.month, dayOfWeek=arguments.dayOfWeek, nth=4);
        }
    } 

    /**
    *  @hint Filter an array of dates so that only those which fall within the start and end date are returned
    */
    public array function $filterDatesByRange(
        required array dates,
        required date filterstart,
        required date filterend
    ) {
        var r=[];
        for(date in dates){
            if(date >= filterstart && date <= filterend){
                arrayAppend(r, date);
            }
        }
        return r;
    }

    /**
    *  @hint Filter an array of Dates so it's 'every 2nd/3rd/4th' week
    */ 
    public array function $filterDatesByWeek(required array dates, required numeric every) {
        var r=[];
        var firstWeek=week(dates[1]);
        var currentWeek=firstweek;
        for(date in dates){
            if(!(currentWeek - firstweek) MOD every){
                arrayAppend(r, date);
            }
            currentWeek=week(date);
        } 
        return r;
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
     public date function $firstXDayOfMonth(required numeric dayOfWeek, required numeric month, required numeric year){
        if (dayOfWeek < 1 || dayOfWeek > 7){
            throw(type="InvalidDayOfWeekException", message="Invalid day of week value", detail="the dayOfWeek argument must be between 1-7 (inclusive).");
        }
        var firstOfMonth    = createDate(year, month,1);
        var dowOfFirst      = dayOfWeek(firstOfMonth);
        var daysToAdd       = (7 - (dowOfFirst - dayOfWeek)) MOD 7;
        var dow = dateAdd("d", daysToAdd, firstOfMonth);
        return dow;
    }
  
}