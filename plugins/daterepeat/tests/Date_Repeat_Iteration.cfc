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
 	function Test_Repeat_Iteration_daily() {
 		loc.r=repeatDate(date=loc.date, iterations=7); 
 		//debug("loc.r");
 		assert("arraylen(loc.r) EQ 7");
	} 

 	// Range: daily - i.e, every day
 	// Every 2nd Day
 	function Test_Repeat_Iteration_daily_skip() {
 		loc.r=repeatDate(date=loc.date, iterations=15, every=2); 
 		//debug("loc.r");
 		assert("arraylen(loc.r) EQ 15");
 		assert("dayOfYear(loc.r[1]) EQ 28");
 		assert("dayOfYear(loc.r[2]) EQ 30");
 		assert("dayOfYear(loc.r[3]) EQ 32");
 		assert("dayOfYear(loc.r[4]) EQ 34");
 		assert("dayOfYear(loc.r[5]) EQ 36");
	} 

	// Range: weekday - i.e, every weekday
	function Test_Repeat_Iteration_weekday() { 
 		loc.r=repeatDate(date=loc.date, type="weekday", iterations=7); 
 		//debug("loc.r");
 		assert("arraylen(loc.r) EQ 7");
 		for(date in loc.r){
 			assert("dayOfWeek(date) NEQ 1");
 			assert("dayOfWeek(date) NEQ 7");
 		}  
	} 

	// Range: mwf - i.e, every mon/weds/fri
	function Test_Repeat_Iteration_mwf() {
 		loc.r=repeatDate(date=loc.date, type="mwf", iterations=7); 
 		//debug("loc.r");
 		assert("arraylen(loc.r) EQ 7"); 
 		for(date in loc.r){
 			assert("dayOfWeek(date) NEQ 1");
 			assert("dayOfWeek(date) NEQ 3");
 			assert("dayOfWeek(date) NEQ 5");
 			assert("dayOfWeek(date) NEQ 7");
 		} 
	} 

	// Range: tt - i.e every tue/thurs
	function Test_Repeat_Iteration_tt() {
 		loc.r=repeatDate(date=loc.date, type="tt", iterations=7); 
 		//debug("loc.r");
 		assert("arraylen(loc.r) EQ 7");   
 		for(date in loc.r){
 			assert("dayOfWeek(date) NEQ 1");
 			assert("dayOfWeek(date) NEQ 2");
 			assert("dayOfWeek(date) NEQ 4");
 			assert("dayOfWeek(date) NEQ 6");
 			assert("dayOfWeek(date) NEQ 7");
 		} 
	} 

	// Range: ss - i.e every sat/sun
	function Test_Repeat_Iteration_ss() {
 		loc.r=repeatDate(date=loc.date, type="ss", iterations=7); 
 		//debug("loc.r");
 		assert("arraylen(loc.r) EQ 7"); 
 		for(date in loc.r){
 			assert("dayOfWeek(date) NEQ 2");
 			assert("dayOfWeek(date) NEQ 3");
 			assert("dayOfWeek(date) NEQ 4");
 			assert("dayOfWeek(date) NEQ 5");
 			assert("dayOfWeek(date) NEQ 6");
 		}   
	} 
 
	// Range: weekly - i.e, same day every week
	function Test_Repeat_Iteration_weekly() {
		loc.r=repeatDate(date=loc.date, type="weekly",  iterations=7);
		//debug("loc.r");
 		assert("arraylen(loc.r) EQ 7"); 
		for(date in loc.r){
			//debug("DayOfWeekAsString(dayOfWeek(date))");
			assert("dayOfWeek(date) EQ dayOfWeek(loc.date)");
		}
	} 

	// Range: weeklyDOW - i.e, every week on these days
	function Test_Repeat_Iteration_weekly_dow() {
		loc.r=repeatDate(date=loc.date, type="weeklydow", dow="2,3,4", iterations=7);
		//debug("loc.r");
 		assert("arraylen(loc.r) EQ 7"); 
		for(date in loc.r){
			//debug("DayOfWeek(dayOfWeek(date))");
			//debug("DayOfWeekAsString(dayOfWeek(date))");
			assert("listFind('2,3,4', dayOfWeek(date))");
		}
			assert("dayOfWeek(loc.r[1]) EQ 4");
			assert("dayOfWeek(loc.r[2]) EQ 2");
			assert("dayOfWeek(loc.r[3]) EQ 3");
			assert("dayOfWeek(loc.r[4]) EQ 4");
			assert("dayOfWeek(loc.r[5]) EQ 2");
			assert("dayOfWeek(loc.r[6]) EQ 3");
			assert("dayOfWeek(loc.r[7]) EQ 4");
	} 

		// Range: weeklyDOW - i.e, every week on these days, skip 2nd
	function Test_Repeat_Iteration_weekly_dow2() {
		loc.r=repeatDate(date=loc.date, type="weeklydow", every=2, dow="2,3,4", iterations=7);
		//debug("loc.r");
 		assert("arraylen(loc.r) EQ 7"); 
		for(date in loc.r){
			//debug("DayOfWeek(dayOfWeek(date))");
			//debug("DayOfWeekAsString(dayOfWeek(date))");
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
	function Test_Repeat_Iteration_monthly() {
		loc.r=repeatDate(date=loc.date, type="monthly",  iterations=7);
		//debug("loc.r");
 		assert("arraylen(loc.r) EQ 7"); 
 		for(date in loc.r){
			//debug("day(date)");
			assert("day(date) EQ day(loc.date)");
		}
	} 

	// Range: monthlyDOW - i.e, every month on this Day of the Week: i.e, the 2nd Saturday
	function Test_Repeat_Iteration_monthly_dow() {
		loc.r=repeatDate(date=loc.date, type="monthlydow", iterations=7);
		//debug("loc.r");
		assert("arraylen(loc.r) EQ 7");
		for(date in loc.r){
			//debug("day(date)");
			assert("dayOfWeek(date) EQ dayofWeek(loc.date)");
		} 
	} 
	 
	// Range: yearly - i.e, every year on this day
	function Test_Repeat_Iteration_yearly() {
		loc.r=repeatDate(date=loc.date, type="yearly", iterations=7);
		//debug("loc.r");
 		assert("arraylen(loc.r) EQ 7"); 
 		for(date in loc.r){
			//debug("day(date)");
			assert("dayOfYear(date) EQ dayOfYear(loc.date)");
		}
	}  
	 
} 