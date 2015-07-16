component extends="tests.Test"  hint="Unit Tests" {

	//include "../../wheels/test.cfm";

/******************** Date Repeats ***********************/

	/*
	For ease, we're statically setting the date and going to compare what comes out of the main date calculation functions
	*/

	function setup(){

		super.setup();

	}

	// Day of week filter
	function Test_DOW_Filter_Frue(){
		loc.a=dowFilter(4, loc.eventProperties.start);
		assert(loc.a EQ true);
	}
	function Test_DOW_Filter_False(){
		loc.a=dowFilter(2, loc.eventProperties.start);
		assert(loc.a EQ false);
	}


/******************** END ***********************/
}