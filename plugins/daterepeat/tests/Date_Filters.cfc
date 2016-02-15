component extends="Test"  hint="Unit Tests" {
 
	function setup(){
		super.setup(); 
		loc.date=createDate(2015,01,28);
	}
	function teardown(){
		super.teardown();
	}
 
 	function Test_Filter_By_Range() { 
 		// 45 iterations generated, but should only return 13
 		loc.r=repeatDate(date=loc.date, iterations=45, filterstart=dateAdd("d", 3, loc.date), filterend=dateAdd("d", 15, loc.date)); 
 		//debug("loc.r");
 		assert("arraylen(loc.r) EQ 13");
	} 

	// Should return start + end with 3 hours added
 	function Test_Add_Event_Duration() {  
 		loc.dates=repeatDate(date=loc.date, iterations=15); 
 		loc.r=addEventDuration(dates=loc.dates, duration=180, eventStart=loc.date);
 		//debug("loc.r"); 
 		assert("isDate(loc.r[1]['start'])");
 		assert("isDate(loc.r[2]['end'])");
 		assert("hour(loc.r[1]['start']) EQ 00");
 		assert("hour(loc.r[2]['end']) EQ 3");
	} 

	// Work out whether the date is the 1st/2nd/3rd/4th/5th occurance in the month. If 5th, make it the 'last' appearance. otherwise use 1-4.
	function Test_Calculate_Position_In_Month(){
		loc.sampleDate="2015-01-01";
		loc.result=$positionInMonth(loc.sampleDate);
		//debug(expression="loc.result");
		assert("isNumeric(loc.result) AND loc.result EQ 1");
	}
	function Test_Calculate_Position_In_Month2(){
		loc.sampleDate="2015-01-8";
		loc.result=$positionInMonth(loc.sampleDate);
		//debug(expression="loc.result");
		assert("isNumeric(loc.result) AND loc.result EQ 2");
	}
	function Test_Calculate_Position_In_Month3(){
		loc.sampleDate="2015-01-15";
		loc.result=$positionInMonth(loc.sampleDate);
		//debug(expression="loc.result");
		assert("isNumeric(loc.result) AND loc.result EQ 3");
	}
	function Test_Calculate_Position_In_Month4(){
		loc.sampleDate="2015-01-22";
		loc.result=$positionInMonth(loc.sampleDate);
		//debug(expression="loc.result");
		assert("isNumeric(loc.result) AND loc.result EQ 4");
	}
	// Test for the 5th Thursday!
	function Test_Calculate_Position_In_Month5(){
		loc.sampleDate="2015-01-29";
		loc.result=$positionInMonth(loc.sampleDate);
		//debug(expression="loc.result");
		assert("isNumeric(loc.result) AND loc.result EQ 5");
	}

	function Test_Filter_Dates_by_Week(){
		loc.dates=repeatDate(date=loc.date, iterations=45); 
		loc.r=$filterDatesByWeek(dates=loc.dates, every=2);
		//debug("loc.r");
	
 		assert("dayOfYear(loc.r[1]) EQ dayOfYear(createDate(2015,01,28))"); 
 		assert("dayOfYear(loc.r[2]) EQ dayOfYear(createDate(2015,01,29))");
 		assert("dayOfYear(loc.r[3]) EQ dayOfYear(createDate(2015,01,30))");
 		assert("dayOfYear(loc.r[4]) EQ dayOfYear(createDate(2015,01,31))"); 
 		assert("dayOfYear(loc.r[5]) EQ dayOfYear(createDate(2015,02,01))");
 		assert("dayOfYear(loc.r[6]) EQ dayOfYear(createDate(2015,02,09))");
 		assert("dayOfYear(loc.r[7]) EQ dayOfYear(createDate(2015,02,10))");
 		assert("dayOfYear(loc.r[8]) EQ dayOfYear(createDate(2015,02,11))");
 		assert("dayOfYear(loc.r[9]) EQ dayOfYear(createDate(2015,02,12))");
 		assert("dayOfYear(loc.r[10]) EQ dayOfYear(createDate(2015,02,13))");
 		assert("dayOfYear(loc.r[11]) EQ dayOfYear(createDate(2015,02,14))");
 		assert("dayOfYear(loc.r[12]) EQ dayOfYear(createDate(2015,02,15))");
 		assert("dayOfYear(loc.r[13]) EQ dayOfYear(createDate(2015,02,23))");
	}
 	
 	function Test_IsTimeClash_StartsBefore_EndsBefore(){
 		loc.start1=createDateTime(2015,01,28,10,00,00);
 		loc.end1=createDateTime(2015,01,28,12,00,00);
 		loc.start2=createDateTime(2015,01,28,08,00,00);
 		loc.end2=createDateTime(2015,01,28,10,00,00);
 		loc.result=isTimeClash(argumentCollection=loc);
 		//debug("loc");
 		assert(!loc.result);
 	}
 	function Test_IsTimeClash_StartsBefore_EndsDuring(){
 		loc.start1=createDateTime(2015,01,28,10,00,00);
 		loc.end1=createDateTime(2015,01,28,12,00,00);
 		loc.start2=createDateTime(2015,01,28,08,00,00);
 		loc.end2=createDateTime(2015,01,28,11,00,00);
 		loc.result=isTimeClash(argumentCollection=loc);
 		//debug("loc");
 		assert(loc.result);
 	}
 	function Test_IsTimeClash_StartsOn_EndsOn(){
 		loc.start1=createDateTime(2015,01,28,10,00,00);
 		loc.end1=createDateTime(2015,01,28,12,00,00);
 		loc.start2=createDateTime(2015,01,28,10,00,00);
 		loc.end2=createDateTime(2015,01,28,12,00,00);
 		loc.result=isTimeClash(argumentCollection=loc);
 		//debug("loc");
 		assert(loc.result);
 	}
 	function Test_IsTimeClash_StartsDuring_EndsAfter(){
 		loc.start1=createDateTime(2015,01,28,10,00,00);
 		loc.end1=createDateTime(2015,01,28,12,00,00);
 		loc.start2=createDateTime(2015,01,28,11,00,00);
 		loc.end2=createDateTime(2015,01,28,13,00,00);
 		loc.result=isTimeClash(argumentCollection=loc);
 		//debug("loc");
 		assert(loc.result);
 	}
 	function Test_IsTimeClash_StartsAfter_EndsAfter(){
 		loc.start1=createDateTime(2015,01,28,10,00,00);
 		loc.end1=createDateTime(2015,01,28,12,00,00);
 		loc.start2=createDateTime(2015,01,28,12,00,00);
 		loc.end2=createDateTime(2015,01,28,14,00,00);
 		loc.result=isTimeClash(argumentCollection=loc);
 		//debug("loc"); 
 		assert(!loc.result);
 	}
 	function Test_IsTimeClash_StartsBefore_EndsAFter(){
 		loc.start1=createDateTime(2015,01,28,10,00,00);
 		loc.end1=createDateTime(2015,01,28,12,00,00);
 		loc.start2=createDateTime(2015,01,28,08,00,00);
 		loc.end2=createDateTime(2015,01,28,14,00,00);
 		loc.result=isTimeClash(argumentCollection=loc);
 		//debug("loc");
 		assert(loc.result);
 	}
 	function Test_IsTimeClash_StartsDuring_EndsDuring(){
 		loc.start1=createDateTime(2015,01,28,10,00,00);
 		loc.end1=createDateTime(2015,01,28,12,00,00);
 		loc.start2=createDateTime(2015,01,28,10,30,00);
 		loc.end2=createDateTime(2015,01,28,11,00,00);
 		loc.result=isTimeClash(argumentCollection=loc);
 		//debug("loc");
 		assert(loc.result);
 	}
} 