component extends="tests.Test"  hint="Unit Tests" {

	//include "../../wheels/test.cfm";

/******************** Date Repeats ***********************/

	/*

	All these test specifically try and generate repeat dates with a specificed Range,
	i.e from 2015-01-01 to 2015-02-01, rather than using the number of iterations

	*/

	function setup(){

		super.setup();

		// Default test range of over a month (example as used in Jan 2015 main cal view)
		loc.rangeStart			=	"2014-12-29";
		loc.rangeEnd  			=	"2015-02-09";

		// 3 Day Range
		loc.rangeStart3Day		=	"2015-01-28";
		loc.rangeEnd3Day  		=	"2015-01-30";

		// 10 Day Range
		loc.rangeStart10Day		=	"2015-01-28";
		loc.rangeEnd10Day  		=	"2015-02-06";

		// 10 Day Range
		loc.rangeStart10Day		=	"2015-01-28";
		loc.rangeEnd10Day  		=	"2015-02-06";

		// 5 year Range
		loc.rangeStart5yr		=	"2015-01-28";
		loc.rangeEnd5yr  		=	"2019-02-06";

		// i year
		loc.rangeStart1yr		=	"2015-01-28";
		loc.rangeEnd1yr  		=	"2016-01-28";

		loc.rangeStart2m		=	"2015-01-28";
		loc.rangeEnd2m  		=	"2015-02-28";
		loc.rangeStart4m		=	"2015-01-28";
		loc.rangeEnd4m  		=	"2015-04-28";
	}

	// Daily, For a 3 day range
	function Test_Range_Day_Every1Day_3DayRange(){
		loc.dateArray=dateCalcRange(
			eventStart		=	loc.eventProperties.start,
			eventEnd  		=	loc.eventProperties.end,
			step      		=	1,
			rangeStart		=	loc.rangeStart3Day,
			rangeEnd		=	loc.rangeEnd3Day,
			dow 			=	""
		);
		//debug(expression="loc.dateArray", format="text");
		assert("arraylen(loc.dateArray)   EQ 3");
		assert("loc.dateArray[1]['start'] EQ '2015-01-28 10:00:00'");
		assert("loc.dateArray[1]['end']   EQ '2015-01-28 12:00:00'");
		assert("loc.dateArray[2]['start'] EQ '2015-01-29 10:00:00'");
		assert("loc.dateArray[2]['end']   EQ '2015-01-29 12:00:00'");
		assert("loc.dateArray[3]['start'] EQ '2015-01-30 10:00:00'");
		assert("loc.dateArray[3]['end']   EQ '2015-01-30 12:00:00'");
	}

	// Every 3rd day For a 3 day range (i.e, one result)
	function Test_Range_Day_Every3Day_3DayRange(){
		loc.dateArray=dateCalcRange(
			eventStart		=	loc.eventProperties.start,
			eventEnd  		=	loc.eventProperties.end,
			step      		=	3,
			rangeStart		=	loc.rangeStart3Day,
			rangeEnd		=	loc.rangeEnd3Day,
			dow 			=	""
		);
		//debug(expression="loc.dateArray", format="text");
		assert("arraylen(loc.dateArray)   EQ 1");
		assert("loc.dateArray[1]['start'] EQ '2015-01-28 10:00:00'");
		assert("loc.dateArray[1]['end']   EQ '2015-01-28 12:00:00'");
	}

	// Daily, For a 10 day range
	function Test_Range_Day_Every1Day_10DayRange(){
		loc.dateArray=dateCalcRange(
			eventStart		=	loc.eventProperties.start,
			eventEnd  		=	loc.eventProperties.end,
			step      		=	1,
			rangeStart		=	loc.rangeStart10Day,
			rangeEnd		=	loc.rangeEnd10Day,
			dow 			=	""
		);
		//debug(expression="loc.dateArray", format="text");
		assert("arraylen(loc.dateArray)   EQ 10");
		assert("loc.dateArray[1]['start'] EQ '2015-01-28 10:00:00'");
		assert("loc.dateArray[1]['end']   EQ '2015-01-28 12:00:00'");
		assert("loc.dateArray[2]['start'] EQ '2015-01-29 10:00:00'");
		assert("loc.dateArray[2]['end']   EQ '2015-01-29 12:00:00'");
		assert("loc.dateArray[3]['start'] EQ '2015-01-30 10:00:00'");
		assert("loc.dateArray[3]['end']   EQ '2015-01-30 12:00:00'");
		// etc.
	}

	// Every 3rd day for a 10 day range
	function Test_Range_Day_Every3Day_10DayRange(){
		loc.dateArray=dateCalcRange(
			eventStart		=	loc.eventProperties.start,
			eventEnd  		=	loc.eventProperties.end,
			step      		=	3,
			rangeStart		=	loc.rangeStart10Day,
			rangeEnd		=	loc.rangeEnd10Day,
			dow 			=	""
		);
		//debug(expression="loc.dateArray", format="text");
		assert("arraylen(loc.dateArray)   EQ 4");
		assert("loc.dateArray[1]['start'] EQ '2015-01-28 10:00:00'");
		assert("loc.dateArray[1]['end']   EQ '2015-01-28 12:00:00'");
		assert("loc.dateArray[2]['start'] EQ '2015-01-31 10:00:00'");
		assert("loc.dateArray[2]['end']   EQ '2015-01-31 12:00:00'");
		assert("loc.dateArray[3]['start'] EQ '2015-02-03 10:00:00'");
		assert("loc.dateArray[3]['end']   EQ '2015-02-03 12:00:00'");
	}

	// Every weekday for a 10 day range
 	function Test_Range_WeekDay(){
 		loc.dateArray=dateCalcRange(
 			eventStart		=	loc.eventProperties.start,
 			eventEnd  		=	loc.eventProperties.end,
 			step      		=	1,
 			dow				=	"2,3,4,5,6",
 			rangeStart		=	loc.rangeStart10Day,
 			rangeEnd		=	loc.rangeEnd10Day
 		);
 		//debug(expression="loc.dateArray", format="text");
 		assert("arraylen(loc.dateArray)   EQ 8");
 		assert("loc.dateArray[1]['start'] EQ '2015-01-28 10:00:00'");
 		assert("loc.dateArray[1]['end']   EQ '2015-01-28 12:00:00'");
 		assert("loc.dateArray[2]['start'] EQ '2015-01-29 10:00:00'");
 		assert("loc.dateArray[2]['end']   EQ '2015-01-29 12:00:00'");
 		assert("loc.dateArray[3]['start'] EQ '2015-01-30 10:00:00'");
 		assert("loc.dateArray[3]['end']   EQ '2015-01-30 12:00:00'");
 		assert("loc.dateArray[4]['start'] EQ '2015-02-02 10:00:00'");
 		assert("loc.dateArray[4]['end']   EQ '2015-02-02 12:00:00'");
 		assert("loc.dateArray[5]['start'] EQ '2015-02-03 10:00:00'");
 		assert("loc.dateArray[5]['end']   EQ '2015-02-03 12:00:00'");
 		assert("loc.dateArray[6]['start'] EQ '2015-02-04 10:00:00'");
 		assert("loc.dateArray[6]['end']   EQ '2015-02-04 12:00:00'");
 		assert("loc.dateArray[7]['start'] EQ '2015-02-05 10:00:00'");
 		assert("loc.dateArray[7]['end']   EQ '2015-02-05 12:00:00'");
 		assert("loc.dateArray[8]['start'] EQ '2015-02-06 10:00:00'");
 		assert("loc.dateArray[8]['end']   EQ '2015-02-06 12:00:00'");
 	}

 	function Test_Range_MWF(){
 		loc.dateArray=dateCalcRange(
 			eventStart		=	loc.eventProperties.start,
 			eventEnd  		=	loc.eventProperties.end,
 			step      		=	loc.repeatruleProperties.repeatevery,
 			dow				=	"2,4,6",
 			rangeStart		=	loc.rangeStart,
 			rangeEnd		=	loc.rangeEnd
 		);
 		//debug(expression="loc.dateArray", format="text");
 		assert("arraylen(loc.dateArray) EQ 6");
 		assert("loc.dateArray[1]['start'] EQ '2015-01-28 10:00:00'");
 		assert("loc.dateArray[1]['end']   EQ '2015-01-28 12:00:00'");
 		assert("loc.dateArray[2]['start'] EQ '2015-01-30 10:00:00'");
 		assert("loc.dateArray[2]['end']   EQ '2015-01-30 12:00:00'");
 		assert("loc.dateArray[3]['start'] EQ '2015-02-02 10:00:00'");
 		assert("loc.dateArray[3]['end']   EQ '2015-02-02 12:00:00'");
 		assert("loc.dateArray[4]['start'] EQ '2015-02-04 10:00:00'");
 		assert("loc.dateArray[4]['end']   EQ '2015-02-04 12:00:00'");
 		//etc
 	}

 	/* Tues/Thurs */
 	function Test_Range_TT(){
 		loc.dateArray=dateCalcRange(
 			eventStart		=	loc.eventProperties.start,
 			eventEnd  		=	loc.eventProperties.end,
 			step      		=	loc.repeatruleProperties.repeatevery,
 			dow		=	"3,5",
 			rangeStart		=	loc.rangeStart,
 			rangeEnd		=	loc.rangeEnd
 		);
 		//debug(expression="loc.dateArray", format="text");
 		assert("arraylen(loc.dateArray) EQ 3");
 		assert("loc.dateArray[1]['start'] EQ '2015-01-29 10:00:00'");
 		assert("loc.dateArray[1]['end']   EQ '2015-01-29 12:00:00'");
 		assert("loc.dateArray[2]['start'] EQ '2015-02-03 10:00:00'");
 		assert("loc.dateArray[2]['end']   EQ '2015-02-03 12:00:00'");
 		assert("loc.dateArray[3]['start'] EQ '2015-02-05 10:00:00'");
 		assert("loc.dateArray[3]['end']   EQ '2015-02-05 12:00:00'");
 	}

 	/* Weekly, repeat on MTW */
 	function Test_Range_Weekly_ON_x(){
 		loc.dateArray=dateCalcRange(
 			eventStart		=	loc.eventProperties.start,
 			eventEnd  		=	loc.eventProperties.end,
 			step      		=	loc.repeatruleProperties.repeatevery,
 					dow		=	"2,3,4",
 			rangeStart		=	loc.rangeStart,
 			rangeEnd		=	loc.rangeEnd
 		);
 		//debug(expression="loc.dateArray", format="text");
 		assert("arraylen(loc.dateArray) EQ 5");
 		assert("loc.dateArray[1]['start'] EQ '2015-01-28 10:00:00'");
 		assert("loc.dateArray[1]['end']   EQ '2015-01-28 12:00:00'");
 		assert("loc.dateArray[2]['start'] EQ '2015-02-02 10:00:00'");
 		assert("loc.dateArray[2]['end']   EQ '2015-02-02 12:00:00'");
 		assert("loc.dateArray[3]['start'] EQ '2015-02-03 10:00:00'");
 		assert("loc.dateArray[3]['end']   EQ '2015-02-03 12:00:00'");
 		assert("loc.dateArray[4]['start'] EQ '2015-02-04 10:00:00'");
 		assert("loc.dateArray[4]['end']   EQ '2015-02-04 12:00:00'");
 		assert("loc.dateArray[5]['start'] EQ '2015-02-09 10:00:00'");
 		assert("loc.dateArray[5]['end']   EQ '2015-02-09 12:00:00'");
 	}

 	/* Weekly, repeat on MTW, skip every 2nd week */
 	//function Test_Range_Weekly_ON_x_with_Skip(){
 	//	loc.dateArray=dateCalcRangeWithSkip(
 	//		eventStart		=	loc.eventProperties.start,
 	//		eventEnd  		=	loc.eventProperties.end,
 	//		step      		=	2,
 	//		//		dow		=	"2,3,4",
 	//		rule 			= 	"weekonskip"
 	//	);
 	//	debug(expression="loc.dateArray");
 	//	assert("arraylen(loc.dateArray) EQ 12");
 	//	assert("loc.dateArray[1]['start'] EQ '2015-01-28 10:00:00'");
 	//	assert("loc.dateArray[1]['end']   EQ '2015-01-28 12:00:00'");
 	//	assert("loc.dateArray[2]['start'] EQ '2015-02-09 10:00:00'");
 	//	assert("loc.dateArray[2]['end']   EQ '2015-02-09 12:00:00'");
 	//	assert("loc.dateArray[3]['start'] EQ '2015-02-10 10:00:00'");
 	//	assert("loc.dateArray[3]['end']   EQ '2015-02-10 12:00:00'");
 	//	assert("loc.dateArray[4]['start'] EQ '2015-02-11 10:00:00'");
 	//	assert("loc.dateArray[4]['end']   EQ '2015-02-11 12:00:00'");
 	//	assert("loc.dateArray[5]['start'] EQ '2015-02-23 10:00:00'");
 	//	assert("loc.dateArray[5]['end']   EQ '2015-02-23 12:00:00'");
 	//	assert("loc.dateArray[6]['start'] EQ '2015-02-24 10:00:00'");
 	//	assert("loc.dateArray[6]['end']   EQ '2015-02-24 12:00:00'");
 	//	assert("loc.dateArray[7]['start'] EQ '2015-02-25 10:00:00'");
 	//	assert("loc.dateArray[7]['end']   EQ '2015-02-25 12:00:00'");
 	//	assert("loc.dateArray[8]['start'] EQ '2015-03-09 10:00:00'");
 	//	assert("loc.dateArray[8]['end']   EQ '2015-03-09 12:00:00'");
 	//	assert("loc.dateArray[9]['start'] EQ '2015-03-10 10:00:00'");
 	//	assert("loc.dateArray[9]['end']   EQ '2015-03-10 12:00:00'");
 	//	assert("loc.dateArray[10]['start'] EQ '2015-03-11 10:00:00'");
 	//	assert("loc.dateArray[10]['end']   EQ '2015-03-11 12:00:00'");
 	//	assert("loc.dateArray[11]['start'] EQ '2015-03-23 10:00:00'");
 	//	assert("loc.dateArray[11]['end']   EQ '2015-03-23 12:00:00'");
 	//	assert("loc.dateArray[12]['start'] EQ '2015-03-24 10:00:00'");
 	//	assert("loc.dateArray[12]['end']   EQ '2015-03-24 12:00:00'");
 	//}


 	/* Monthly, DOM */
 	function Test_Range_Month_Day_Of_Month(){
 		loc.dateArray=dateCalcRangeWithSkip(
 			eventStart		=	loc.eventProperties.start,
 			eventEnd  		=	loc.eventProperties.end,
 			step      		=	1,// Repeat every 1 months
 			datePart		= 	"m", // Set months,
 			rangeStart		=	loc.rangeStart2m,
 			rangeEnd		=	loc.rangeEnd2m,
 			dow=""
 		);
 		//debug(expression="loc.dateArray", format="text");
 		assert("arraylen(loc.dateArray) EQ 2");
 		assert("loc.dateArray[1]['start']  EQ  '2015-01-28 10:00:00'");
 		assert("loc.dateArray[1]['end']    EQ  '2015-01-28 12:00:00'");
 		assert("loc.dateArray[2]['start']  EQ  '2015-02-28 10:00:00'");
 		assert("loc.dateArray[2]['end']    EQ  '2015-02-28 12:00:00'");
 	}

 	/* Monthly, DOM w Skip */
 	function Test_Range_Month_Day_Of_Month_with_Skip(){
 		loc.dateArray=dateCalcRangeWithSkip(
 			eventStart		=	loc.eventProperties.start,
 			eventEnd  		=	loc.eventProperties.end,
 			step      		=	2, // Repeat every 2 months
 			datePart		= 	"m", // Set months,
 			rangeStart		=	loc.rangeStart4m,
 			rangeEnd		=	loc.rangeEnd4m,
 			dow=""
 		);
 		//debug(expression="loc.dateArray", format="text");
 		assert("arraylen(loc.dateArray) EQ 2");
 		assert("loc.dateArray[1]['start']  EQ  '2015-01-28 10:00:00'");
 		assert("loc.dateArray[1]['end']    EQ  '2015-01-28 12:00:00'");
 		assert("loc.dateArray[2]['start']  EQ  '2015-03-28 10:00:00'");
 		assert("loc.dateArray[2]['end']    EQ  '2015-03-28 12:00:00'");
 	}

 	/* Monthly, DOW: this one's a bit complex.
 		We're deliberatly testing against the 1st instance in a month
 		So Jan 1st = Thursday, i.e, 1st Thursday of every month;
 		So in Feb = 5th, Mar = 5th, Apr = 2nd May =7th etc.
 	*/
 	function Test_Range_Month_Day_Of_Week_1st(){
 		loc.dateArray=dateCalcRangeWithSkip(
 			eventStart		=	'2015-01-01 10:00:00',
 			eventEnd  		=	'2015-01-01 12:00:00',
 			step      		=	1,// Repeat every 1 months
 			datePart		= 	"m", // Set months
 			rule 			= 	"dow",
 			rangeStart		=	'2015-01-01',
 			rangeEnd		=	'2015-05-01',
 			dow=""
 		);
 		//debug(expression="loc.dateArray", format="text");
 		assert("arraylen(loc.dateArray) EQ 5");
 		assert("loc.dateArray[1]['start']  EQ  '2015-01-01 10:00:00'");
 		assert("loc.dateArray[1]['end']    EQ  '2015-01-01 12:00:00'");
 		assert("loc.dateArray[2]['start']  EQ  '2015-02-05 10:00:00'");
 		assert("loc.dateArray[2]['end']    EQ  '2015-02-05 12:00:00'");
 		assert("loc.dateArray[3]['start']  EQ  '2015-03-05 10:00:00'");
 		assert("loc.dateArray[3]['end']    EQ  '2015-03-05 12:00:00'");
 		assert("loc.dateArray[4]['start']  EQ  '2015-04-02 10:00:00'");
 		assert("loc.dateArray[4]['end']    EQ  '2015-04-02 12:00:00'");
 		assert("loc.dateArray[5]['start']  EQ  '2015-05-07 10:00:00'");
 		assert("loc.dateArray[5]['end']    EQ  '2015-05-07 12:00:00'");
 	}

 	/* Monthly, DOW: this one's a bit complex.
 		We're deliberatly testing against the 2nd instance in a month
 	*/
 	function Test_Range_Month_Day_Of_Week_2nd(){
 		loc.dateArray=dateCalcRangeWithSkip(
 			eventStart		=	'2015-01-08 10:00:00',
 			eventEnd  		=	'2015-01-08 12:00:00',
 			step      		=	1,// Repeat every 1 months
 			datePart		= 	"m", // Set months
 			rule 			= 	"dow",
 			rangeStart		=	'2015-01-08',
 			rangeEnd		=	'2015-05-08',
 			dow=""
 		);
 		//debug(expression="loc.dateArray", format="text");
 		assert("arraylen(loc.dateArray) EQ 5");
 		assert("loc.dateArray[1]['start']  EQ  '2015-01-08 10:00:00'");
 		assert("loc.dateArray[1]['end']    EQ  '2015-01-08 12:00:00'");
 		assert("loc.dateArray[2]['start']  EQ  '2015-02-12 10:00:00'");
 		assert("loc.dateArray[2]['end']    EQ  '2015-02-12 12:00:00'");
 		assert("loc.dateArray[3]['start']  EQ  '2015-03-12 10:00:00'");
 		assert("loc.dateArray[3]['end']    EQ  '2015-03-12 12:00:00'");
 		assert("loc.dateArray[4]['start']  EQ  '2015-04-09 10:00:00'");
 		assert("loc.dateArray[4]['end']    EQ  '2015-04-09 12:00:00'");
 		assert("loc.dateArray[5]['start']  EQ  '2015-05-14 10:00:00'");
 		assert("loc.dateArray[5]['end']    EQ  '2015-05-14 12:00:00'");
 	}

 	/* Monthly, DOW: this one's a bit complex.
 		We're deliberatly testing against the 3rd instance in a month
 	*/
 	function Test_Range_Month_Day_Of_Week_3rd(){
 		loc.dateArray=dateCalcRangeWithSkip(
 			eventStart		=	'2015-01-15 10:00:00',
 			eventEnd  		=	'2015-01-15 12:00:00',
 			step      		=	1,// Repeat every 1 months
 			datePart		= 	"m", // Set months
 			rule 			= 	"dow",
 			rangeStart		=	'2015-01-15',
 			rangeEnd		=	'2015-05-15',
 			dow=""
 		);
 		//debug(expression="loc.dateArray", format="text");
 		assert("arraylen(loc.dateArray) EQ 5");
 		assert("loc.dateArray[1]['start']  EQ  '2015-01-15 10:00:00'");
 		assert("loc.dateArray[1]['end']    EQ  '2015-01-15 12:00:00'");
 		assert("loc.dateArray[2]['start']  EQ  '2015-02-19 10:00:00'");
 		assert("loc.dateArray[2]['end']    EQ  '2015-02-19 12:00:00'");
 		assert("loc.dateArray[3]['start']  EQ  '2015-03-19 10:00:00'");
 		assert("loc.dateArray[3]['end']    EQ  '2015-03-19 12:00:00'");
 		assert("loc.dateArray[4]['start']  EQ  '2015-04-16 10:00:00'");
 		assert("loc.dateArray[4]['end']    EQ  '2015-04-16 12:00:00'");
 		assert("loc.dateArray[5]['start']  EQ  '2015-05-21 10:00:00'");
 		assert("loc.dateArray[5]['end']    EQ  '2015-05-21 12:00:00'");
 	}

 	/* Monthly, DOW: this one's a bit complex.
 		We're deliberatly testing against the 4th instance in a month
 	*/
 	function Test_Range_Month_Day_Of_Week_4th(){
 		loc.dateArray=dateCalcRangeWithSkip(
 			eventStart		=	'2015-01-22 10:00:00',
 			eventEnd  		=	'2015-01-22 12:00:00',
 			step      		=	1,// Repeat every 1 months
 			datePart		= 	"m", // Set months
 			rule 			= 	"dow",
 			rangeStart		=	'2015-01-22',
 			rangeEnd		=	'2015-05-22',
 			dow=""
 		);
 		//debug(expression="loc.dateArray", format="text");
 		assert("arraylen(loc.dateArray) EQ 5");
 		assert("loc.dateArray[1]['start']  EQ  '2015-01-22 10:00:00'");
 		assert("loc.dateArray[1]['end']    EQ  '2015-01-22 12:00:00'");
 		assert("loc.dateArray[2]['start']  EQ  '2015-02-26 10:00:00'");
 		assert("loc.dateArray[2]['end']    EQ  '2015-02-26 12:00:00'");
 		assert("loc.dateArray[3]['start']  EQ  '2015-03-26 10:00:00'");
 		assert("loc.dateArray[3]['end']    EQ  '2015-03-26 12:00:00'");
 		assert("loc.dateArray[4]['start']  EQ  '2015-04-23 10:00:00'");
 		assert("loc.dateArray[4]['end']    EQ  '2015-04-23 12:00:00'");
 		assert("loc.dateArray[5]['start']  EQ  '2015-05-28 10:00:00'");
 		assert("loc.dateArray[5]['end']    EQ  '2015-05-28 12:00:00'");
 	}

 	/* Monthly, DOW: this one's a bit complex.
 		We're deliberatly testing against the 4th instance in a month
 	*/
 	function Test_Range_Month_Day_Of_Week_Last(){
 		loc.dateArray=dateCalcRangeWithSkip(
 			eventStart		=	'2015-01-29 10:00:00',
 			eventEnd  		=	'2015-01-29 12:00:00',
 			step      		=	1,// Repeat every 1 months
 			datePart		= 	"m", // Set months
 			rule 			= 	"dow",
 			rangeStart		=	'2015-01-29',
 			rangeEnd		=	'2015-05-29',
 			dow=""
 		);
 		//debug(expression="loc.dateArray", format="text");
 		assert("arraylen(loc.dateArray) EQ 5");
 		assert("loc.dateArray[1]['start']  EQ  '2015-01-29 10:00:00'");
 		assert("loc.dateArray[1]['end']    EQ  '2015-01-29 12:00:00'");
 		assert("loc.dateArray[2]['start']  EQ  '2015-02-26 10:00:00'");
 		assert("loc.dateArray[2]['end']    EQ  '2015-02-26 12:00:00'");
 		assert("loc.dateArray[3]['start']  EQ  '2015-03-26 10:00:00'");
 		assert("loc.dateArray[3]['end']    EQ  '2015-03-26 12:00:00'");
 		assert("loc.dateArray[4]['start']  EQ  '2015-04-30 10:00:00'");
 		assert("loc.dateArray[4]['end']    EQ  '2015-04-30 12:00:00'");
 		assert("loc.dateArray[5]['start']  EQ  '2015-05-28 10:00:00'");
 		assert("loc.dateArray[5]['end']    EQ  '2015-05-28 12:00:00'");
 	}

 	/* Yearly, DOY  */
 	function Test_Range_Year(){
 		loc.dateArray=dateCalcRangeWithSkip(
 			eventStart		=	loc.eventProperties.start,
 			eventEnd  		=	loc.eventProperties.end,
 			step      		=	1, // Repeat every 1 yr
 			datePart		= 	"yyyy", // Set years,
 			rangeStart		=	loc.rangeStart5yr,
 			rangeEnd		=	loc.rangeEnd5yr,
 			dow 			= 	""
 		);
 		//debug(expression="loc.dateArray", format="text");
 		assert("arraylen(loc.dateArray) EQ 5");
 		assert("loc.dateArray[1]['start']  EQ  '2015-01-28 10:00:00'");
 		assert("loc.dateArray[1]['end']    EQ  '2015-01-28 12:00:00'");
 		assert("loc.dateArray[2]['start']  EQ  '2016-01-28 10:00:00'");
 		assert("loc.dateArray[2]['end']    EQ  '2016-01-28 12:00:00'");
 		assert("loc.dateArray[3]['start']  EQ  '2017-01-28 10:00:00'");
 		assert("loc.dateArray[3]['end']    EQ  '2017-01-28 12:00:00'");
 		assert("loc.dateArray[4]['start']  EQ  '2018-01-28 10:00:00'");
 		assert("loc.dateArray[4]['end']    EQ  '2018-01-28 12:00:00'");
 		assert("loc.dateArray[5]['start']  EQ  '2019-01-28 10:00:00'");
 		assert("loc.dateArray[5]['end']    EQ  '2019-01-28 12:00:00'");
 	}

 	/* Yearly, w Skip  */
 	function Test_Range_Year_with_Skip(){
 		loc.dateArray=dateCalcRangeWithSkip(
 			eventStart		=	loc.eventProperties.start,
 			eventEnd  		=	loc.eventProperties.end,
 			step      		=	3, // Repeat every 3 yr
 			datePart		= 	"yyyy", // Set years,
 			rangeStart		=	loc.rangeStart5yr,
 			rangeEnd		=	loc.rangeEnd5yr,
 			dow  			= 	""
 		);
 		//debug(expression="loc.dateArray", format="text");
 		assert("arraylen(loc.dateArray) EQ 2");
 		assert("loc.dateArray[1]['start']  EQ  '2015-01-28 10:00:00'");
 		assert("loc.dateArray[1]['end']    EQ  '2015-01-28 12:00:00'");
 		assert("loc.dateArray[2]['start']  EQ  '2018-01-28 10:00:00'");
 		assert("loc.dateArray[2]['end']    EQ  '2018-01-28 12:00:00'");
 	}
/******************** END ***********************/
}