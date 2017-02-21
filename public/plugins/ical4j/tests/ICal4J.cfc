component extends="wheelsMapping.Test"  hint="Unit Tests" {


	function setup(){
		seed=createDate(2017, 01, 01);
		from=createDate(2017, 01, 01);
		to=createDate(2017, 01, 15);
	}
	function teardown(){

	}
	function Test_getRecurringDates_daily(){
		r=getRecurringDates("FREQ=DAILY", seed, from, to);
		assert("arraylen(r) EQ 14");
	}
	function Test_getRecurringDates_weekly(){
		to=createDate(2017, 04, 15);
		r=getRecurringDates("FREQ=WEEKLY", seed, from, to);
		assert("arraylen(r) EQ 15");
	}
	function Test_getRecurringDates_monthly(){
		to=createDate(2017, 04, 15);
		r=getRecurringDates("FREQ=MONTHLY", seed, from, to);
		assert("arraylen(r) EQ 4");
	}
	function Test_getRecurringDates_monthly_month_day(){
		to=createDate(2017, 04, 15);
		r=getRecurringDates("FREQ=MONTHLY;BYMONTHDAY=2", seed, from, to);
		assert("arraylen(r) EQ 5");
	}
	function Test_getRecurringDates_yearly(){
		to=createDate(2018, 04, 15);
		r=getRecurringDates("FREQ=YEARLY", seed, from, to);
		assert("arraylen(r) EQ 2");
	}
	//=====================================================================
	//= 	Recurring Dates with interval
	//=====================================================================

	function Test_getRecurringDates_daily_interval_of_2(){
		r=getRecurringDates("FREQ=DAILY;INTERVAL=2", seed, from, to, 2);
		assert("arraylen(r) EQ 7");
	}
	function Test_getRecurringDates_daily_interval_of_3(){
		r=getRecurringDates("FREQ=DAILY;INTERVAL=3", seed, from, to, 3);
		assert("arraylen(r) EQ 5");
	}
	function Test_getRecurringDates_weekly_tu_th(){
		to=createDate(2017, 04, 15);
		r=getRecurringDates("FREQ=WEEKLY;INTERVAL=1;BYDAY=TU,TH", seed, from, to, 1, "TU,TH");
		assert("arraylen(r) EQ 30");
	}
	function Test_getRecurringDates_weekly_tu_th_interval_of_2(){
		to=createDate(2017, 04, 15);
		r=getRecurringDates("FREQ=WEEKLY;INTERVAL=2;BYDAY=TU,TH", seed, from, to, 2, "TU,TH");
		assert("arraylen(r) EQ 14");
	}
	function Test_getRecurringDates_weekly_interval_of_2(){
		to=createDate(2017, 04, 15);
		r=getRecurringDates("FREQ=WEEKLY;INTERVAL=2", seed, from, to, 2);
		assert("arraylen(r) EQ 8");
	}
	function Test_getRecurringDates_weekly_interval_of_3(){
		to=createDate(2017, 04, 15);
		r=getRecurringDates("FREQ=WEEKLY;INTERVAL=3", seed, from, to, 3);
		assert("arraylen(r) EQ 5");
	}
	function Test_getRecurringDates_monthly_interval_of_2(){
		to=createDate(2017, 04, 15);
		r=getRecurringDates("FREQ=MONTHLY;INTERVAL=2", seed, from, to, 2);
		assert("arraylen(r) EQ 2");
	}
	function Test_getRecurringDates_monthly_interval_of_3(){
		to=createDate(2017, 07, 15);
		r=getRecurringDates("FREQ=MONTHLY;INTERVAL=3", seed, from, to, 3);
		assert("arraylen(r) EQ 3");
	}
	function Test_getRecurringDates_yearly_interval_of_2(){
		to=createDate(2020, 04, 15);
		r=getRecurringDates("FREQ=YEARLY;INTERVAL=2", seed, from, to, 2);
		assert("arraylen(r) EQ 2");
	}
	function Test_getRecurringDates_yearly_interval_of_3(){
		to=createDate(2040, 04, 15);
		r=getRecurringDates("FREQ=YEARLY;INTERVAL=3", seed, from, to, 3);
		assert("arraylen(r) EQ 8");
	}


}
