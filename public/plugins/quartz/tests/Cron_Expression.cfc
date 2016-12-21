component extends="Test"  hint="Unit Tests" {


/*
Seconds	 	0-59	 	, - * /
Minutes	 	0-59	 	, - * /
Hours	 	0-23	 	, - * /
Day-of-month	 	1-31	 	, - * ? / L W
Month	 	1-12 or JAN-DEC	 	, - * /
Day-of-Week	 	1-7 or SUN-SAT	 	, - * ? / L #
Year (Optional)	 	empty, 1970-2199	 	, - * /

Support for specifying both a day-of-week and a day-of-month value is not complete (you must currently use the ‘?’ character in one of these fields).
*/

	function setup(){
		super.setup();
	}
	function teardown(){
		super.teardown();
	}

 	function Test_Convert_Cron_Expression_To_Human_Readable(){
		cronExp="0 0 10 * * MON-SUN";
		r=$$cronTabExpressionToHuman(cronExp);
		assert(r EQ "At 10:00 AM, Monday through Sunday");
 	}

//=====================================================================
//= 	Simple Expression Tests
//=====================================================================

	function Test_Exp_1(){
		cronExp="0 0 12 * * ?";
		// 12 pm (noon) every day
		thedate=createDateTime(2010,01,01,10,00,00);
		expected=createDateTime(2010,01,01,12,00,00);
		r=getNextRunDate(thedate, cronExp);
		assert(r.toString() EQ expected);
	}
	function Test_Exp_2(){
		cronExp="0 15 10 ? * *";
		// 10:15 am every day
		thedate=createDateTime(2010,01,01,10,00,00);
		expected=createDateTime(2010,01,01,10,15,00);
		r=getNextRunDate(thedate, cronExp);
		assert(r.toString() EQ expected);
	}
	function Test_Exp_3(){
		cronExp="0 15 10 * * ?";
		// 10:15 am every day
		thedate=createDateTime(2010,01,01,10,00,00);
		expected=createDateTime(2010,01,01,10,15,00);
		r=getNextRunDate(thedate, cronExp);
		assert(r.toString() EQ expected);
	}
	function Test_Exp_4(){
		cronExp="0 15 10 * * ? *";
		// 10:15 am every day
		thedate=createDateTime(2010,01,01,10,00,00);
		expected=createDateTime(2010,01,01,10,15,00);
		r=getNextRunDate(thedate, cronExp);
		assert(r.toString() EQ expected);
	}
	function Test_Exp_4a(){
		cronExp="0 15 10 * * ? 2010";
		// 10:15 am every day during 2010
		thedate=createDateTime(2010,01,01,10,00,00);
		expected=createDateTime(2010,01,01,10,15,00);
		r=getNextRunDate(thedate, cronExp);
		assert(r.toString() EQ expected);
	}
	function Test_Exp_5(){
		cronExp="0 * 14 * * ?";
		// Every minute starting at 2 pm and ending at 2:59 pm, every day
		thedate=createDateTime(2010,01,01,10,00,00);
		expected=createDateTime(2010,01,01,14,00,00);
		r=getNextRunDate(thedate, cronExp);
		assert(r.toString() EQ expected);
	}
	function Test_Exp_6(){
		cronExp="0 0/5 14 * * ?";
		// Every 5 minutes starting at 2 pm and ending at 2:55 pm, every day
		thedate=createDateTime(2010,01,01,10,00,00);
		expected=createDateTime(2010,01,01,14,00,00);
		r=getNextRunDate(thedate, cronExp);
		assert(r.toString() EQ expected);
	}
	function Test_Exp_7(){
		cronExp="0 0/5 14,18 * * ?";
		// Every 5 minutes starting at 2 pm and ending at 2:55 pm, AND fires every 5 minutes starting at 6 pm and ending at 6:55 pm, every day
		thedate=createDateTime(2010,01,01,10,00,00);
		expected=createDateTime(2010,01,01,14,00,00);
		r=getNextRunDate(thedate, cronExp);
		assert(r.toString() EQ expected);
	}
	function Test_Exp_8(){
		cronExp="0 0-5 14 * * ?";
		// Every minute starting at 2 pm and ending at 2:05 pm, every day
		thedate=createDateTime(2010,01,01,10,00,00);
		expected=createDateTime(2010,01,01,14,00,00);
		r=getNextRunDate(thedate, cronExp);
		assert(r.toString() EQ expected);
	}
	function Test_Exp_9(){
		cronExp="0 10,44 14 ? 3 WED";
		// 2:10 pm and at 2:44 pm every Wednesday in the month of March.
		thedate=createDateTime(2010,01,01,10,00,00);
		expected=createDateTime(2010,03,03,14,10,00);
		r=getNextRunDate(thedate, cronExp);
		assert(r.toString() EQ expected);
	}
	function Test_Exp_10(){
		cronExp="0 15 10 ? * MON-FRI";
		// 10:15 am every Monday, Tuesday, Wednesday, Thursday and Friday
		thedate=createDateTime(2010,01,01,10,00,00);
		expected=createDateTime(2010,01,01,10,15,00);
		r=getNextRunDate(thedate, cronExp);
		assert(r.toString() EQ expected);
	}
	function Test_Exp_11(){
		cronExp="0 15 10 15 * ?";
		// 10:15 am on the 15th day of every month
		thedate=createDateTime(2010,01,01,10,00,00);
		expected=createDateTime(2010,01,15,10,15,00);
		r=getNextRunDate(thedate, cronExp);
		assert(r.toString() EQ expected);
	}
	function Test_Exp_12(){
		cronExp="0 15 10 L * ?";
		// 10:15 am on the last day of every month
		thedate=createDateTime(2010,01,01,10,00,00);
		expected=createDateTime(2010,01,31,10,15,00);
		r=getNextRunDate(thedate, cronExp);
		assert(r.toString() EQ expected);
	}
	function Test_Exp_13(){
		cronExp="0 15 10 ? * 6L";
		// 10:15 am on the last Friday of every month
		thedate=createDateTime(2010,01,01,10,00,00);
		expected=createDateTime(2010,01,29,10,15,00);
		r=getNextRunDate(thedate, cronExp);
		assert(r.toString() EQ expected);
	}
	function Test_Exp_14(){
		cronExp="0 15 10 ? * 6L 2009-2011";
		thedate=createDateTime(2010,01,01,10,00,00);
		expected=createDateTime(2010,01,29,10,15,00);
		r=getNextRunDate(thedate, cronExp);
		assert(r.toString() EQ expected);
	}
	function Test_Exp_15(){
		cronExp="0 15 10 ? * 6##3";
		// 10:15 am on the third Friday of every month
		thedate=createDateTime(2010,01,01,10,00,00);
		expected=createDateTime(2010,01,15,10,15,00);
		r=getNextRunDate(thedate, cronExp);
		assert(r.toString() EQ expected);
	}
	function Test_Exp_16(){
		cronExp="0 0 12 1/5 * ?";
		// 12 pm (noon) every 5 days every month, starting on the first day of the month
		thedate=createDateTime(2010,01,01,10,00,00);
		expected=createDateTime(2010,01,01,12,00,00);
		r=getNextRunDate(thedate, cronExp);
		assert(r.toString() EQ expected);
	}
	function Test_Exp_17(){
		cronExp="0 11 11 11 11 ?";
		// Every November 11th at 11:11 am.
		thedate=createDateTime(2010,01,01,10,00,00);
		expected=createDateTime(2010,11,11,11,11,00);
		r=getNextRunDate(thedate, cronExp);
		assert(r.toString() EQ expected);
	}
	// Support for specifying both a day-of-week AND a day-of-month parameter is not implemented test
	function Test_Exp_18(){
		// Can't be: cronExp="0 0 10 1/1 * MON,TUE,WED,THU,FRI";
		cronExp="0 0 10 ? * MON,TUE,WED,THU,FRI";
		thedate=createDateTime(2010,01,01,10,00,00);
		expected=createDateTime(2010,01,04,10,00,00);
		r=getNextRunDate(thedate, cronExp);
		//debug("r");
		assert(r.toString() EQ expected);
	}


//=====================================================================
//= 	Generate a cron string
//=====================================================================

	function Test_Cron_Expression_daily(){
		r=generateCronExpression(
			date=createDateTime(2010,01,01,10,00,00)
		);
		e=$$cronTabExpressionToHuman(r);
		//debug("e");
		//debug("r");
		assert(e EQ "At 10:00 AM");
		assert(r EQ "0 0 10 * * ?");
	}

	function Test_Cron_Expression_daily_every_3_days(){
		r=generateCronExpression(
			date=createDateTime(2010,01,01,10,00,00),
			every=3
		);
		e=$$cronTabExpressionToHuman(r);
		debug("e");
		debug("r");
		assert(e EQ "At 10:00 AM, every 3 days");
		assert(r EQ "0 0 10 */3 * ?");
	}

	function Test_Cron_Expression_weekday(){
		r=generateCronExpression(
			date=createDateTime(2010,01,01,10,00,00),
			type="weekday"
		);
		e=$$cronTabExpressionToHuman(r);
		//debug("e");
		//debug("r");
		assert(e EQ "At 10:00 AM, only on Monday, Tuesday, Wednesday, Thursday, and Friday");
		assert(r EQ "0 0 10 ? * MON,TUE,WED,THU,FRI");
	}

	function Test_Cron_Expression_mwf(){
		r=generateCronExpression(
			date=createDateTime(2010,01,01,10,00,00),
			type="mwf"
		);
		e=$$cronTabExpressionToHuman(r);
		//debug("e");
		//debug("r");
		assert(e EQ "At 10:00 AM, only on Monday, Wednesday, and Friday");
		assert(r EQ "0 0 10 ? * MON,WED,FRI");
	}

	function Test_Cron_Expression_tt(){
		r=generateCronExpression(
			date=createDateTime(2010,01,01,10,00,00),
			type="tt"
		);
		e=$$cronTabExpressionToHuman(r);
		//debug("e");
		//debug("r");
		assert(e EQ "At 10:00 AM, only on Tuesday and Thursday");
		assert(r EQ "0 0 10 ? * TUE,THU");
	}

	function Test_Cron_Expression_ss(){
		r=generateCronExpression(
			date=createDateTime(2010,01,01,10,00,00),
			type="ss"
		);
		e=$$cronTabExpressionToHuman(r);
		//debug("e");
		//debug("r");
		assert(e EQ "At 10:00 AM, only on Saturday and Sunday");
		assert(r EQ "0 0 10 ? * SAT,SUN");
	}

	function Test_Cron_Expression_weekly(){
		r=generateCronExpression(
			date=createDateTime(2010,01,01,10,00,00),
			type="weekly"
		);
		e=$$cronTabExpressionToHuman(r);
		//debug("e");
		//debug("r");
		assert(e EQ "At 10:00 AM, only on Friday");
		assert(r EQ "0 0 10 ? * FRI");
	}

	/*
	function Test_Cron_Expression_weekly_every_3(){
		r=generateCronExpression(
			date=createDateTime(2010,01,01,10,00,00),
			type="weekly",
			every=3
		);
		e=$$cronTabExpressionToHuman(r);
		//debug("e");
		//debug("r");
		assert(e EQ "At 10:00 AM, only on Friday every 3rd week");
		assert(r EQ "0 0 10 ? * FRI");
	}*/

	function Test_Cron_Expression_weeklydow(){
		r=generateCronExpression(
			date=createDateTime(2010,01,01,10,00,00),
			type="weeklydow",
			dow="1,4,5"
		);
		e=$$cronTabExpressionToHuman(r);
		//debug("e");
		//debug("r");
		assert(e EQ "At 10:00 AM, only on Sunday, Wednesday, and Thursday");
		assert(r EQ "0 0 10 ?/1 * SUN,WED,THU");
	}
	function Test_Cron_Expression_monthly(){
		r=generateCronExpression(
			date=createDateTime(2010,01,12,10,00,00),
			type="monthly"
		);
		e=$$cronTabExpressionToHuman(r);
		//debug("e");
		//debug("r");
		assert(e EQ "At 10:00 AM, on day 12 of the month");
		assert(r EQ "0 0 10 12 */1 ?");
	}
	function Test_Cron_Expression_monthly_every_3_months(){
		r=generateCronExpression(
			date=createDateTime(2010,01,12,10,00,00),
			type="monthly",
			every=3
		);
		e=$$cronTabExpressionToHuman(r);
		//debug("e");
		//debug("r");
		assert(e EQ "At 10:00 AM, on day 12 of the month, every 3 months");
		assert(r EQ "0 0 10 12 */3 ?");
	}
	function Test_Cron_Expression_monthlydow(){
		r=generateCronExpression(
			date=createDateTime(2010,01,12,10,00,00),
			type="monthlydow"
		);
		e=$$cronTabExpressionToHuman(r);
		//debug("e");
		//debug("r");
		assert(e EQ "At 10:00 AM, on the second Tuesday of the month");
		assert(r EQ "0 0 10 ? */1 TUE##2");
	}
	function Test_Cron_Expression_monthlydow2(){
		r=generateCronExpression(
			date=createDateTime(2010,01,06,10,00,00),
			type="monthlydow"
		);
		e=$$cronTabExpressionToHuman(r);
		//debug("e");
		//debug("r");
		assert(e EQ "At 10:00 AM, on the first Wednesday of the month");
		assert(r EQ "0 0 10 ? */1 WED##1");
	}
	function Test_Cron_Expression_monthlydow3(){
		r=generateCronExpression(
			date=createDateTime(2010,01,28,10,00,00),
			type="monthlydow"
		);
		e=$$cronTabExpressionToHuman(r);
		//debug("e");
		//debug("r");
		assert(e EQ "At 10:00 AM, on the fourth Thursday of the month");
		assert(r EQ "0 0 10 ? */1 THU##4");
	}
	function Test_Cron_Expression_monthlydow4(){
		r=generateCronExpression(
			date=createDateTime(2016,11,30,10,00,00),
			type="monthlydow"
		);
		e=$$cronTabExpressionToHuman(r);
		//debug("e");
		//debug("r");
		assert(e EQ "At 10:00 AM, on the last Wednesday of the month");
		assert(r EQ "0 0 10 ? */1 WEDL");
	}
		function Test_Cron_Expression_monthlydow_every_3(){
		r=generateCronExpression(
			date=createDateTime(2010,01,12,10,00,00),
			type="monthlydow",
			every=3
		);
		e=$$cronTabExpressionToHuman(r);
		//debug("e");
		//debug("r");
		assert(e EQ "At 10:00 AM, on the second Tuesday of the month, every 3 months");
		assert(r EQ "0 0 10 ? */3 TUE##2");
	}
	function Test_Cron_Expression_monthlydow2_every_3(){
		r=generateCronExpression(
			date=createDateTime(2010,01,06,10,00,00),
			type="monthlydow",
			every=3
		);
		e=$$cronTabExpressionToHuman(r);
		//debug("e");
		//debug("r");
		assert(e EQ "At 10:00 AM, on the first Wednesday of the month, every 3 months");
		assert(r EQ "0 0 10 ? */3 WED##1");
	}
	function Test_Cron_Expression_monthlydow3_every_3(){
		r=generateCronExpression(
			date=createDateTime(2010,01,28,10,00,00),
			type="monthlydow",
			every=3
		);
		e=$$cronTabExpressionToHuman(r);
		//debug("e");
		//debug("r");
		assert(e EQ "At 10:00 AM, on the fourth Thursday of the month, every 3 months");
		assert(r EQ "0 0 10 ? */3 THU##4");
	}
	function Test_Cron_Expression_monthlydow4_every_3(){
		r=generateCronExpression(
			date=createDateTime(2016,11,30,10,00,00),
			type="monthlydow",
			every=3
		);
		e=$$cronTabExpressionToHuman(r);
		//debug("e");
		//debug("r");
		assert(e EQ "At 10:00 AM, on the last Wednesday of the month, every 3 months");
		assert(r EQ "0 0 10 ? */3 WEDL");
	}
	function Test_Cron_Expression_yearly(){
		r=generateCronExpression(
			date=createDateTime(2016,11,30,10,00,00),
			type="yearly"
		);
		e=$$cronTabExpressionToHuman(r);
		//debug("e");
		//debug("r");
		assert(e EQ "At 10:00 AM, on day 30 of the month, only in November, every year");
		assert(r EQ "0 0 10 30 11 * */1");
	}
	function Test_Cron_Expression_yearly_every_3(){
		r=generateCronExpression(
			date=createDateTime(2016,11,30,10,00,00),
			type="yearly",
			every=3
		);
		e=$$cronTabExpressionToHuman(r);
		//debug("e");
		//debug("r");
		assert(e EQ "At 10:00 AM, on day 30 of the month, only in November, every 3 years");
		assert(r EQ "0 0 10 30 11 * */3");
	}


}
