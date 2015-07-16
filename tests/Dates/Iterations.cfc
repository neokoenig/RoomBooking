component extends="tests.Test"  hint="Unit Tests" {

	//include "../../wheels/test.cfm";

/******************** Date Repeats ***********************/

	/*
	All these tests specifically test number of times, i.e iterations.
	So do 'y' for 'x' times: they're not beholden to a date range
 	*/

	function setup(){

		super.setup();


	}


	// Repeat Every Day
	function Test_IT_Day_Every1Day(){
		loc.dateArray=dateCalcIterations(
			eventStart		=	loc.eventProperties.start,
			eventEnd  		=	loc.eventProperties.end,
			step      		=	1,
			iterations		=	3
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

	// Repeat Every 3rd Day
	function Test_IT_Day_Every3Day(){
		loc.dateArray=dateCalcIterations(
			eventStart		=	loc.eventProperties.start,
			eventEnd  		=	loc.eventProperties.end,
			step      		=	3,
			iterations		=	3
		);
		//debug(expression="loc.dateArray", format="text");
		assert("arraylen(loc.dateArray)   EQ 3");
		assert("loc.dateArray[1]['start'] EQ '2015-01-28 10:00:00'");
		assert("loc.dateArray[1]['end']   EQ '2015-01-28 12:00:00'");
		assert("loc.dateArray[2]['start'] EQ '2015-01-31 10:00:00'");
		assert("loc.dateArray[2]['end']   EQ '2015-01-31 12:00:00'");
		assert("loc.dateArray[3]['start'] EQ '2015-02-03 10:00:00'");
		assert("loc.dateArray[3]['end']   EQ '2015-02-03 12:00:00'");
	}

	// Repeat on weekdays only
	function Test_IT_WeekDay(){
		loc.dateArray=dateCalcIterations(
			eventStart		=	loc.eventProperties.start,
			eventEnd  		=	loc.eventProperties.end,
			step      		=	1,
			iterations		=	6,
			daysOfWeek		=	"2,3,4,5,6"
		);
		//debug(expression="loc.dateArray", format="text");
		assert("arraylen(loc.dateArray)   EQ 6");
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
	}

	// Repeat on Mon/Wed/Fri only
	function Test_IT_MWF(){
		loc.dateArray=dateCalcIterations(
			eventStart		=	loc.eventProperties.start,
			eventEnd  		=	loc.eventProperties.end,
			step      		=	loc.repeatruleProperties.repeatevery,
			iterations		=	4,
			daysOfWeek		=	"2,4,6"
		);
		//debug(expression="loc.dateArray", format="text");
		assert("arraylen(loc.dateArray) EQ 4");
		assert("loc.dateArray[1]['start'] EQ '2015-01-28 10:00:00'");
		assert("loc.dateArray[1]['end']   EQ '2015-01-28 12:00:00'");
		assert("loc.dateArray[2]['start'] EQ '2015-01-30 10:00:00'");
		assert("loc.dateArray[2]['end']   EQ '2015-01-30 12:00:00'");
		assert("loc.dateArray[3]['start'] EQ '2015-02-02 10:00:00'");
		assert("loc.dateArray[3]['end']   EQ '2015-02-02 12:00:00'");
		assert("loc.dateArray[4]['start'] EQ '2015-02-04 10:00:00'");
		assert("loc.dateArray[4]['end']   EQ '2015-02-04 12:00:00'");
	}

	/* Repeat on Tues/Thurs only */
	function Test_IT_TT(){
		loc.dateArray=dateCalcIterations(
			eventStart		=	loc.eventProperties.start,
			eventEnd  		=	loc.eventProperties.end,
			step      		=	loc.repeatruleProperties.repeatevery,
			iterations		=	4,
			daysOfWeek		=	"3,5"
		);
		//debug(expression="loc.dateArray", format="text");
		assert("arraylen(loc.dateArray) EQ 4");
		assert("loc.dateArray[1]['start'] EQ '2015-01-29 10:00:00'");
		assert("loc.dateArray[1]['end']   EQ '2015-01-29 12:00:00'");
		assert("loc.dateArray[2]['start'] EQ '2015-02-03 10:00:00'");
		assert("loc.dateArray[2]['end']   EQ '2015-02-03 12:00:00'");
		assert("loc.dateArray[3]['start'] EQ '2015-02-05 10:00:00'");
		assert("loc.dateArray[3]['end']   EQ '2015-02-05 12:00:00'");
		assert("loc.dateArray[4]['start'] EQ '2015-02-10 10:00:00'");
		assert("loc.dateArray[4]['end']   EQ '2015-02-10 12:00:00'");
	}

	/* Weekly, repeat on MTW */
	function Test_IT_Weekly_ON_x(){
		loc.dateArray=dateCalcIterations(
			eventStart		=	loc.eventProperties.start,
			eventEnd  		=	loc.eventProperties.end,
			step      		=	loc.repeatruleProperties.repeatevery,
			iterations		=	12,
			daysOfWeek		=	"2,3,4"
		);
		//debug(expression="loc.dateArray", format="text");
		assert("arraylen(loc.dateArray) EQ 12");
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
		assert("loc.dateArray[6]['start'] EQ '2015-02-10 10:00:00'");
		assert("loc.dateArray[6]['end']   EQ '2015-02-10 12:00:00'");
		assert("loc.dateArray[7]['start'] EQ '2015-02-11 10:00:00'");
		assert("loc.dateArray[7]['end']   EQ '2015-02-11 12:00:00'");
		assert("loc.dateArray[8]['start'] EQ '2015-02-16 10:00:00'");
		assert("loc.dateArray[8]['end']   EQ '2015-02-16 12:00:00'");
		assert("loc.dateArray[9]['start'] EQ '2015-02-17 10:00:00'");
		assert("loc.dateArray[9]['end']   EQ '2015-02-17 12:00:00'");
		assert("loc.dateArray[10]['start'] EQ '2015-02-18 10:00:00'");
		assert("loc.dateArray[10]['end']   EQ '2015-02-18 12:00:00'");
		assert("loc.dateArray[11]['start'] EQ '2015-02-23 10:00:00'");
		assert("loc.dateArray[11]['end']   EQ '2015-02-23 12:00:00'");
		assert("loc.dateArray[12]['start'] EQ '2015-02-24 10:00:00'");
		assert("loc.dateArray[12]['end']   EQ '2015-02-24 12:00:00'");
	}
	/* Weekly, repeat on MTW, skip every 2nd week - BROKEN */
	function Test_IT_Weekly_ON_x_with_Skip(){
		loc.dateArray=dateCalcIterationsWithSkip(
			eventStart		=	loc.eventProperties.start,
			eventEnd  		=	loc.eventProperties.end,
			step      		=	1,
			iterations		=	12,
			daysOfWeek		=	"2,3,4",
			rule 			= 	"weekonskip",
			weekstep 		= 	2
		);
		//debug(expression="loc.dateArray");
		assert("arraylen(loc.dateArray) EQ 12");
		assert("loc.dateArray[1]['start'] EQ '2015-01-28 10:00:00'");
		assert("loc.dateArray[1]['end']   EQ '2015-01-28 12:00:00'");
		assert("loc.dateArray[2]['start'] EQ '2015-02-09 10:00:00'");
		assert("loc.dateArray[2]['end']   EQ '2015-02-09 12:00:00'");
		assert("loc.dateArray[3]['start'] EQ '2015-02-10 10:00:00'");
		assert("loc.dateArray[3]['end']   EQ '2015-02-10 12:00:00'");
		assert("loc.dateArray[4]['start'] EQ '2015-02-11 10:00:00'");
		assert("loc.dateArray[4]['end']   EQ '2015-02-11 12:00:00'");
		assert("loc.dateArray[5]['start'] EQ '2015-02-23 10:00:00'");
		assert("loc.dateArray[5]['end']   EQ '2015-02-23 12:00:00'");
		assert("loc.dateArray[6]['start'] EQ '2015-02-24 10:00:00'");
		assert("loc.dateArray[6]['end']   EQ '2015-02-24 12:00:00'");
		assert("loc.dateArray[7]['start'] EQ '2015-02-25 10:00:00'");
		assert("loc.dateArray[7]['end']   EQ '2015-02-25 12:00:00'");
		assert("loc.dateArray[8]['start'] EQ '2015-03-09 10:00:00'");
		assert("loc.dateArray[8]['end']   EQ '2015-03-09 12:00:00'");
		assert("loc.dateArray[9]['start'] EQ '2015-03-10 10:00:00'");
		assert("loc.dateArray[9]['end']   EQ '2015-03-10 12:00:00'");
		assert("loc.dateArray[10]['start'] EQ '2015-03-11 10:00:00'");
		assert("loc.dateArray[10]['end']   EQ '2015-03-11 12:00:00'");
		assert("loc.dateArray[11]['start'] EQ '2015-03-23 10:00:00'");
		assert("loc.dateArray[11]['end']   EQ '2015-03-23 12:00:00'");
		assert("loc.dateArray[12]['start'] EQ '2015-03-24 10:00:00'");
		assert("loc.dateArray[12]['end']   EQ '2015-03-24 12:00:00'");
	}


	/* Monthly, repeating on the day of month, i.e, the 28th */
	function Test_IT_Month_Day_Of_Month(){
		loc.dateArray=dateCalcIterationsWithSkip(
			eventStart		=	loc.eventProperties.start,
			eventEnd  		=	loc.eventProperties.end,
			step      		=	1,// Repeat every 1 months
			iterations		=	3, // Repeat 3 times
			datePart		= 	"m" // Set months
		);
		//debug(expression="loc.dateArray", format="text");
		assert("arraylen(loc.dateArray) EQ 3");
		assert("loc.dateArray[1]['start']  EQ  '2015-01-28 10:00:00'");
		assert("loc.dateArray[1]['end']    EQ  '2015-01-28 12:00:00'");
		assert("loc.dateArray[2]['start']  EQ  '2015-02-28 10:00:00'");
		assert("loc.dateArray[2]['end']    EQ  '2015-02-28 12:00:00'");
		assert("loc.dateArray[3]['start']  EQ  '2015-03-28 10:00:00'");
		assert("loc.dateArray[3]['end']    EQ  '2015-03-28 12:00:00'");
	}

	/* Monthly, repeating on the day of month, i.e, the 28th, every 2 months */
	function Test_IT_Month_Day_Of_Month_with_Skip(){
		loc.dateArray=dateCalcIterationsWithSkip(
			eventStart		=	loc.eventProperties.start,
			eventEnd  		=	loc.eventProperties.end,
			step      		=	2, // Repeat every 2 months
			iterations		=	3, // Repeat 3 times
			datePart		= 	"m" // Set months
		);
		//debug(expression="loc.dateArray", format="text");
		assert("arraylen(loc.dateArray) EQ 3");
		assert("loc.dateArray[1]['start']  EQ  '2015-01-28 10:00:00'");
		assert("loc.dateArray[1]['end']    EQ  '2015-01-28 12:00:00'");
		assert("loc.dateArray[2]['start']  EQ  '2015-03-28 10:00:00'");
		assert("loc.dateArray[2]['end']    EQ  '2015-03-28 12:00:00'");
		assert("loc.dateArray[3]['start']  EQ  '2015-05-28 10:00:00'");
		assert("loc.dateArray[3]['end']    EQ  '2015-05-28 12:00:00'");
	}

	/* Monthly, by Day of Week: this one's a bit complex.
		We're deliberatly testing against the 1st instance in a month
		So Jan 1st = Thursday, i.e, 1st Thursday of every month;
		So in Feb = 5th, Mar = 5th, Apr = 2nd May =7th etc.
	*/
	function Test_IT_Month_Day_Of_Week_1st(){
		loc.dateArray=dateCalcIterationsWithSkip(
			eventStart		=	'2015-01-01 10:00:00',
			eventEnd  		=	'2015-01-01 12:00:00',
			step      		=	1,// Repeat every 1 months
			iterations		=	5, // Repeat 5 times
			datePart		= 	"m", // Set months
			rule 			= 	"dow"
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
	function Test_IT_Month_Day_Of_Week_2nd(){
		loc.dateArray=dateCalcIterationsWithSkip(
			eventStart		=	'2015-01-08 10:00:00',
			eventEnd  		=	'2015-01-08 12:00:00',
			step      		=	1,// Repeat every 1 months
			iterations		=	5, // Repeat 5 times
			datePart		= 	"m", // Set months
			rule 			= 	"dow"
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
	function Test_IT_Month_Day_Of_Week_3rd(){
		loc.dateArray=dateCalcIterationsWithSkip(
			eventStart		=	'2015-01-15 10:00:00',
			eventEnd  		=	'2015-01-15 12:00:00',
			step      		=	1,// Repeat every 1 months
			iterations		=	5, // Repeat 5 times
			datePart		= 	"m", // Set months
			rule 			= 	"dow"
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
	function Test_IT_Month_Day_Of_Week_4th(){
		loc.dateArray=dateCalcIterationsWithSkip(
			eventStart		=	'2015-01-22 10:00:00',
			eventEnd  		=	'2015-01-22 12:00:00',
			step      		=	1,// Repeat every 1 months
			iterations		=	5, // Repeat 5 times
			datePart		= 	"m", // Set months
			rule 			= 	"dow"
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
		We're deliberatly testing against the 5th instance in a month;
		Essentially, if someone picks the 5th instance of a day in the week as their start date,
		then we're going to assume they always want the LAST as opposed the the 5th (which wouldn't exist in
		most months)
	*/
	function Test_IT_Month_Day_Of_Week_Last(){
		loc.dateArray=dateCalcIterationsWithSkip(
			eventStart		=	'2015-01-29 10:00:00',
			eventEnd  		=	'2015-01-29 12:00:00',
			step      		=	1,// Repeat every 1 months
			iterations		=	5, // Repeat 5 times
			datePart		= 	"m", // Set months
			rule 			= 	"dow"
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

	/* Yearly - Annually.  */
	function Test_IT_Year(){
		loc.dateArray=dateCalcIterationsWithSkip(
			eventStart		=	loc.eventProperties.start,
			eventEnd  		=	loc.eventProperties.end,
			step      		=	1, // Repeat every 1 yr
			iterations		=	3, // Repeat 3 times
			datePart		= 	"yyyy" // Set years
		);
		//debug(expression="loc.dateArray", format="text");
		assert("arraylen(loc.dateArray) EQ 3");
		assert("loc.dateArray[1]['start']  EQ  '2015-01-28 10:00:00'");
		assert("loc.dateArray[1]['end']    EQ  '2015-01-28 12:00:00'");
		assert("loc.dateArray[2]['start']  EQ  '2016-01-28 10:00:00'");
		assert("loc.dateArray[2]['end']    EQ  '2016-01-28 12:00:00'");
		assert("loc.dateArray[3]['start']  EQ  '2017-01-28 10:00:00'");
		assert("loc.dateArray[3]['end']    EQ  '2017-01-28 12:00:00'");
	}


	/* Yearly, w Skip  */
	function Test_IT_Year_with_Skip(){
		loc.dateArray=dateCalcIterationsWithSkip(
			eventStart		=	loc.eventProperties.start,
			eventEnd  		=	loc.eventProperties.end,
			step      		=	3, // Repeat every 3 yr
			iterations		=	3, // Repeat 3 times
			datePart		= 	"yyyy" // Set years
		);
		//debug(expression="loc.dateArray", format="text");
		assert("arraylen(loc.dateArray) EQ 3");
		assert("loc.dateArray[1]['start']  EQ  '2015-01-28 10:00:00'");
		assert("loc.dateArray[1]['end']    EQ  '2015-01-28 12:00:00'");
		assert("loc.dateArray[2]['start']  EQ  '2018-01-28 10:00:00'");
		assert("loc.dateArray[2]['end']    EQ  '2018-01-28 12:00:00'");
		assert("loc.dateArray[3]['start']  EQ  '2021-01-28 10:00:00'");
		assert("loc.dateArray[3]['end']    EQ  '2021-01-28 12:00:00'");
	}
/******************** END ***********************/
}