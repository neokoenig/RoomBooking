component extends="Test"  hint="Unit Tests" {
 
	function setup(){
		super.setup(); 
		loc.date=createDate(2015,01,28);
	}
	function teardown(){
		super.teardown();
	}

 	// Range: daily - i.e, every day
 	// By Default, repeatDate returns a week of daily dates
 	function Test_Repeat_daily() {
 		loc.r=repeatDate(date=loc.date); 
 		//debug("loc.r");
 		assert("arraylen(loc.r) EQ 7");
	} 

 	function Test_Repeat_daily_every_2() {
 		loc.r=repeatDate(date=loc.date, every=2); 
 		//debug("loc.r");
 		assert("arraylen(loc.r) EQ 4");
	} 

 	function Test_Repeat_daily_every_3() {
 		loc.r=repeatDate(date=loc.date, every=3); 
 		//debug("loc.r");
 		assert("arraylen(loc.r) EQ 3");
	} 

	// Range: weekday - i.e, every weekday
	function Test_Repeat_weekday() { 
 		loc.r=repeatDate(date=loc.date, type="weekday"); 
 		//debug("loc.r");
 		assert("arraylen(loc.r) EQ 5"); 
	} 

	// Range: mwf - i.e, every mon/weds/fri
	function Test_Repeat_mwf() {
 		loc.r=repeatDate(date=loc.date, type="mwf"); 
 		//debug("loc.r");
 		assert("arraylen(loc.r) EQ 3"); 
 		for(date in loc.r){
 			assert("dayOfWeek(date) NEQ 1");
 			assert("dayOfWeek(date) NEQ 3");
 			assert("dayOfWeek(date) NEQ 5");
 			assert("dayOfWeek(date) NEQ 7");
 		} 
	} 

	// Range: tt - i.e every tue/thurs
	function Test_Repeat_tt() {
 		loc.r=repeatDate(date=loc.date, type="tt"); 
 		//debug("loc.r");
 		assert("arraylen(loc.r) EQ 2");   
 		for(date in loc.r){
 			assert("dayOfWeek(date) NEQ 1");
 			assert("dayOfWeek(date) NEQ 2");
 			assert("dayOfWeek(date) NEQ 4");
 			assert("dayOfWeek(date) NEQ 6");
 			assert("dayOfWeek(date) NEQ 7");
 		} 
	} 

	// Range: ss - i.e every sat/sun
	function Test_Repeat_ss() {
 		loc.r=repeatDate(date=loc.date, type="ss"); 
 		//debug("loc.r");
 		assert("arraylen(loc.r) EQ 2"); 
 		for(date in loc.r){
 			assert("dayOfWeek(date) NEQ 2");
 			assert("dayOfWeek(date) NEQ 3");
 			assert("dayOfWeek(date) NEQ 4");
 			assert("dayOfWeek(date) NEQ 5");
 			assert("dayOfWeek(date) NEQ 6");
 		}   
	} 

	// Range: weekly - i.e, same day every week
	function Test_Repeat_weekly() {
		loc.r=repeatDate(date=loc.date, type="weekly", till=dateAdd("ww", 3, loc.date));
		//debug("loc.r");
 		assert("arraylen(loc.r) EQ 4"); 
		for(date in loc.r){
			//debug("DayOfWeekAsString(dayOfWeek(date))");
			assert("dayOfWeek(date) EQ dayOfWeek(loc.date)");
		}
	} 
	// Range: weeklyDOW - i.e, every week on these days
	function Test_Repeat_weekly_dow() {
		loc.r=repeatDate(date=loc.date, type="weeklydow", dow="2,3,4", till=dateAdd("ww", 2, loc.date));
		//debug("loc.r");
 		assert("arraylen(loc.r) EQ 7"); 
		for(date in loc.r){
			//debug("DayOfYear(date)");
			assert("listFind('2,3,4', dayOfWeek(date))");
		}
	} 
 	// Range: weeklyDOW - i.e, every 2 week on these days
	function Test_Repeat_weekly_dow2() {
		loc.r=repeatDate(date=loc.date, type="weeklydow", every=2, dow="2,3,4", till=dateAdd("ww", 8, loc.date));
		//debug("loc.r");
 		//assert("arraylen(loc.r) EQ 7"); 
 
		for(date in loc.r){
			//debug("DayOfYear(date)");
			assert("listFind('2,3,4', dayOfWeek(date))");
		}

 		assert("dayOfYear(loc.r[1]) EQ dayOfYear(createDate(2015,01,28))");
 		// skip w 2
 		assert("dayOfYear(loc.r[2]) EQ dayOfYear(createDate(2015,02,9))");
 		assert("dayOfYear(loc.r[3]) EQ dayOfYear(createDate(2015,02,10))");
 		assert("dayOfYear(loc.r[4]) EQ dayOfYear(createDate(2015,02,11))");
 		// skip
 		assert("dayOfYear(loc.r[5]) EQ dayOfYear(createDate(2015,02,23))");
 		assert("dayOfYear(loc.r[6]) EQ dayOfYear(createDate(2015,02,24))");
 		assert("dayOfYear(loc.r[7]) EQ dayOfYear(createDate(2015,02,25))");
	} 

	// Range: monthly - i.e, every month on this Day of the Month, i.e, the 28th
	function Test_Repeat_monthly() {
		loc.r=repeatDate(date=loc.date, type="monthly", till=dateAdd("ww", 8, loc.date));
		//debug("loc.r");
 		assert("arraylen(loc.r) EQ 2"); 
 		for(date in loc.r){
			//debug("DayOfYear(date)");
			assert("day(date) EQ day(loc.date)");
		}
	} 
	// Range: monthlyDOW - i.e, every month on this Day of the Week: i.e, the 1st Wednesday
	function Test_Repeat_monthly_dow1() {
		loc.r=repeatDate(date=loc.date, type="monthlydow", till=dateAdd("m", 8, loc.date));
		//debug("loc.r");
		assert("arraylen(loc.r) EQ 9");
		for(date in loc.r){
			//debug("day(date)");
			assert("dayOfWeek(date) EQ dayofWeek(loc.date)");
		} 
	} 

	// Range: monthlyDOW - i.e, every month on this Day of the Week: i.e, the 2nd Wednesday
	function Test_Repeat_monthly_dow2() {
		loc.r=repeatDate(date=loc.date, type="monthlydow", till=dateAdd("m", 8, loc.date));
		//debug("loc.r");
		assert("arraylen(loc.r) EQ 9");
		for(date in loc.r){
			//debug("day(date)");
			assert("dayOfWeek(date) EQ dayofWeek(loc.date)");
		} 
	} 

	// Range: monthlyDOW - i.e, every month on this Day of the Week: i.e, the 3rd Wednesday
	function Test_Repeat_monthly_dow3() {
		loc.r=repeatDate(date=loc.date, type="monthlydow", till=dateAdd("m", 8, loc.date));
		//debug("loc.r");
		assert("arraylen(loc.r) EQ 9");
		for(date in loc.r){
			//debug("day(date)");
			assert("dayOfWeek(date) EQ dayofWeek(loc.date)");
		} 
	} 

	// Range: monthlyDOW - i.e, every month on this Day of the Week: i.e, the 4th Wednesday
	function Test_Repeat_monthly_dow4() {
		loc.r=repeatDate(date=loc.date, type="monthlydow", till=dateAdd("m", 8, loc.date));
		//debug("loc.r");
		assert("arraylen(loc.r) EQ 9");
		for(date in loc.r){
			//debug("day(date)");
			assert("dayOfWeek(date) EQ dayofWeek(loc.date)");
		} 
	} 

		// Range: monthlyDOW - i.e, every month on this Day of the Week: i.e, the last Wednesday
	function Test_Repeat_monthly_dow4() {
		loc.r=repeatDate(date=loc.date, type="monthlydow", till=dateAdd("m", 8, loc.date));
		//debug("loc.r");
		assert("arraylen(loc.r) EQ 9");
		for(date in loc.r){
			//debug("day(date)");
			assert("dayOfWeek(date) EQ dayofWeek(loc.date)");
		} 
	} 
	// Range: yearly - i.e, every year on this day
	function Test_Repeat_yearly() {
		loc.r=repeatDate(date=loc.date, type="yearly", till=dateAdd("yyyy", 3, loc.date));
		//debug("loc.r");
 		assert("arraylen(loc.r) EQ 4"); 
 		for(date in loc.r){
			//debug("day(date)");
			assert("dayOfYear(date) EQ dayOfYear(loc.date)");
		}
	}  
} 