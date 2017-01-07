component extends="tests.Test" {

	function setup() {}
	function teardown() {}

	function Test_LSDateFormatDuration(){
		start=createDateTime(2010,01,01,10,00,00);
		end=createDateTime(2010,01,01,12,00,00);
		duration=120;
		r=LSDateFormatDuration(start,end,duration);
		debug("r");
	}

	include template="/views/helpers.cfm";
}
