component extends="wheelsMapping.Test"  hint="Unit Tests" {

	include "../../../wheels/test.cfm";

	function setup(){
		seed=createDate(2017, 01, 01);
		from=createDate(2017, 01, 01);
		to=createDate(2017, 01, 15);
	}
	function teardown(){

	}
		function Test_getRecurringDates_daily(){
		r=getRecurringDates("FREQ=DAILY;COUNT=1000", seed, from, to);
		assert("arraylen(r) == 14");
		//debug("r");
	}
	function Test_getRecurringDates_daily_interval_of_2(){
		r=getRecurringDates("FREQ=DAILY;COUNT=1000;INTERVAL=2", seed, from, to, 2);
		assert("arraylen(r) == 7");
		//debug("r");
	}
	function Test_getRecurringDates_daily_interval_of_3(){
		r=getRecurringDates("FREQ=DAILY;COUNT=1000;INTERVAL=3", seed, from, to, 3);
		assert("arraylen(r) == 5");
		//debug("r");
	}
	function Test_getRecurringDates_weekly(){
		to=createDate(2017, 04, 15);
		r=getRecurringDates("FREQ=WEEKLY;COUNT=1000", seed, from, to);
		assert("arraylen(r) == 15");
		//debug("r");
	}
	function Test_getRecurringDates_weekly_tu_th(){
		to=createDate(2017, 04, 15);
		r=getRecurringDates("FREQ=WEEKLY;COUNT=1000;INTERVAL=1;BYDAY=TU,TH", seed, from, to, 1, "TU,TH");
		//debug("r");
		assert("arraylen(r) == 30");
	}
	function Test_getRecurringDates_weekly_tu_th_interval_of_2(){
		to=createDate(2017, 04, 15);
		r=getRecurringDates("FREQ=WEEKLY;COUNT=1000;INTERVAL=2;BYDAY=TU,TH", seed, from, to, 2, "TU,TH");
		//debug("r");
		assert("arraylen(r) == 14");
	}
	function Test_getRecurringDates_weekly_interval_of_2(){
		to=createDate(2017, 04, 15);
		r=getRecurringDates("FREQ=WEEKLY;COUNT=1000;INTERVAL=2", seed, from, to, 2);
		assert("arraylen(r) == 8");
		//debug("r");
	}
	function Test_getRecurringDates_weekly_interval_of_3(){
		to=createDate(2017, 04, 15);
		r=getRecurringDates("FREQ=WEEKLY;COUNT=1000;INTERVAL=3", seed, from, to, 3);
		assert("arraylen(r) == 5");
		//debug("r");
	}
	function Test_getRecurringDates_monthly(){
		to=createDate(2017, 04, 15);
		r=getRecurringDates("FREQ=MONTHLY;COUNT=1000", seed, from, to);
		assert("arraylen(r) == 4");
		//debug("r");
	}
	function Test_getRecurringDates_monthly_interval_of_2(){
		to=createDate(2017, 04, 15);
		r=getRecurringDates("FREQ=MONTHLY;COUNT=1000;INTERVAL=2", seed, from, to, 2);
		assert("arraylen(r) == 2");
		//debug("r");
	}
	function Test_getRecurringDates_monthly_interval_of_3(){
		to=createDate(2017, 07, 15);
		r=getRecurringDates("FREQ=MONTHLY;COUNT=1000;INTERVAL=3", seed, from, to, 3);
		assert("arraylen(r) == 3");
		//debug("r");
	}
	function Test_getRecurringDates_monthly(){
		to=createDate(2017, 04, 15);
		r=getRecurringDates("FREQ=MONTHLY;COUNT=1000", seed, from, to);
		assert("arraylen(r) == 4");
		//debug("r");
	}
	function Test_getRecurringDates_yearly(){
		to=createDate(2018, 04, 15);
		r=getRecurringDates("FREQ=YEARLY;COUNT=1000", seed, from, to);
		assert("arraylen(r) == 2");
		//debug("r");
	}
	function Test_getRecurringDates_yearly_interval_of_2(){
		to=createDate(2020, 04, 15);
		r=getRecurringDates("FREQ=YEARLY;COUNT=1000;INTERVAL=2", seed, from, to, 2);
		assert("arraylen(r) == 2");
		//debug("r");
	}
	function Test_getRecurringDates_yearly_interval_of_3(){
		to=createDate(2040, 04, 15);
		r=getRecurringDates("FREQ=YEARLY;COUNT=1000;INTERVAL=3", seed, from, to, 3);
		//debug("r");
		assert("arraylen(r) == 8");
	}
	//=====================================================================
	//= 	Recurring Dates with interval
	//=====================================================================
	function Test_getRecurringDates_daily(){
		r=getRecurringDates("FREQ=DAILY;COUNT=1000", seed, from, to);
		assert("arraylen(r) == 14");
		//debug("r");
	}
	function Test_getRecurringDates_daily_interval_of_2(){
		r=getRecurringDates("FREQ=DAILY;COUNT=1000;INTERVAL=2", seed, from, to, 2);
		assert("arraylen(r) == 7");
		//debug("r");
	}
	function Test_getRecurringDates_daily_interval_of_3(){
		r=getRecurringDates("FREQ=DAILY;COUNT=1000;INTERVAL=3", seed, from, to, 3);
		assert("arraylen(r) == 5");
		//debug("r");
	}
	function Test_getRecurringDates_weekly(){
		to=createDate(2017, 04, 15);
		r=getRecurringDates("FREQ=WEEKLY;COUNT=1000", seed, from, to);
		assert("arraylen(r) == 15");
		//debug("r");
	}
	function Test_getRecurringDates_weekly_tu_th(){
		to=createDate(2017, 04, 15);
		r=getRecurringDates("FREQ=WEEKLY;COUNT=1000;INTERVAL=1;BYDAY=TU,TH", seed, from, to, 1, "TU,TH");
		//debug("r");
		assert("arraylen(r) == 30");
	}
	function Test_getRecurringDates_weekly_tu_th_interval_of_2(){
		to=createDate(2017, 04, 15);
		r=getRecurringDates("FREQ=WEEKLY;COUNT=1000;INTERVAL=2;BYDAY=TU,TH", seed, from, to, 2, "TU,TH");
		//debug("r");
		assert("arraylen(r) == 14");
	}
	function Test_getRecurringDates_weekly_interval_of_2(){
		to=createDate(2017, 04, 15);
		r=getRecurringDates("FREQ=WEEKLY;COUNT=1000;INTERVAL=2", seed, from, to, 2);
		assert("arraylen(r) == 8");
		//debug("r");
	}
	function Test_getRecurringDates_weekly_interval_of_3(){
		to=createDate(2017, 04, 15);
		r=getRecurringDates("FREQ=WEEKLY;COUNT=1000;INTERVAL=3", seed, from, to, 3);
		assert("arraylen(r) == 5");
		//debug("r");
	}
	function Test_getRecurringDates_monthly(){
		to=createDate(2017, 04, 15);
		r=getRecurringDates("FREQ=MONTHLY;COUNT=1000", seed, from, to);
		assert("arraylen(r) == 4");
		//debug("r");
	}
	function Test_getRecurringDates_monthly_interval_of_2(){
		to=createDate(2017, 04, 15);
		r=getRecurringDates("FREQ=MONTHLY;COUNT=1000;INTERVAL=2", seed, from, to, 2);
		assert("arraylen(r) == 2");
		//debug("r");
	}
	function Test_getRecurringDates_monthly_interval_of_3(){
		to=createDate(2017, 07, 15);
		r=getRecurringDates("FREQ=MONTHLY;COUNT=1000;INTERVAL=3", seed, from, to, 3);
		assert("arraylen(r) == 3");
		//debug("r");
	}
	function Test_getRecurringDates_monthly(){
		to=createDate(2017, 04, 15);
		r=getRecurringDates("FREQ=MONTHLY;COUNT=1000", seed, from, to);
		assert("arraylen(r) == 4");
		//debug("r");
	}
	function Test_getRecurringDates_yearly(){
		to=createDate(2018, 04, 15);
		r=getRecurringDates("FREQ=YEARLY;COUNT=1000", seed, from, to);
		assert("arraylen(r) == 2");
		//debug("r");
	}
	function Test_getRecurringDates_yearly_interval_of_2(){
		to=createDate(2020, 04, 15);
		r=getRecurringDates("FREQ=YEARLY;COUNT=1000;INTERVAL=2", seed, from, to, 2);
		assert("arraylen(r) == 2");
		//debug("r");
	}
	function Test_getRecurringDates_yearly_interval_of_3(){
		to=createDate(2040, 04, 15);
		r=getRecurringDates("FREQ=YEARLY;COUNT=1000;INTERVAL=3", seed, from, to, 3);
		//debug("r");
		assert("arraylen(r) == 8");
	}


}
