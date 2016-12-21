component extends="Test"  hint="Unit Tests" {

	function setup(){
		super.setup();
	}
	function teardown(){
		super.teardown();
	}
	// Given startDate (which can span multiple days) return true/false depending on whether it falls within the viewport
	// This daterange starts and ends before the viewport, so should never be displayed
 	function Test_getViewPortConditions_StartsBefore_EndsBefore(){
 		loc.start1=createDateTime(2015,01,01,10,00,00);
 		loc.end1=createDateTime(2015,01,01,12,00,00);
 		loc.start2=createDateTime(2015,01,28,08,00,00);
 		loc.end2=createDateTime(2015,02,28,10,00,00);
 		result=getViewPortConditions(argumentCollection=loc);
 		//debug("loc");
 		assert(!result);
 	}
 	// This daterange starts and ends within the viewport, so should be displayed
 	function Test_getViewPortConditions_StartsBefore_EndsDuring(){
 		loc.start1=createDateTime(2015,01,20,10,00,00);
 		loc.end1=createDateTime(2015,01,28,12,00,00);
 		loc.start2=createDateTime(2015,01,22,08,00,00);
 		loc.end2=createDateTime(2015,02,10,11,00,00);
 		result=getViewPortConditions(argumentCollection=loc);
 		//debug("loc");
 		assert(result);
 	}
 	// This daterange starts and ends on the viewport, so should be displayed
 	function Test_getViewPortConditions_StartsOn_EndsOn(){
 		loc.start1=createDateTime(2015,01,15,10,00,00);
 		loc.end1=createDateTime(2015,01,28,12,00,00);
 		loc.start2=createDateTime(2015,01,15,10,00,00);
 		loc.end2=createDateTime(2015,01,28,12,00,00);
 		result=getViewPortConditions(argumentCollection=loc);
 		//debug("loc");
 		assert(result);
 	}
 	// This daterange starts within and ends after the viewport, so should be displayed
 	function Test_getViewPortConditions_StartsDuring_EndsAfter(){
 		loc.start1=createDateTime(2015,01,28,10,00,00);
 		loc.end1=createDateTime(2015,02,28,12,00,00);
 		loc.start2=createDateTime(2015,01,01,11,00,00);
 		loc.end2=createDateTime(2015,02,15,13,00,00);
 		result=getViewPortConditions(argumentCollection=loc);
 		//debug("loc");
 		assert(result);
 	}
 	// This daterange starts and ends after the viewport, so should not be displayed
 	function Test_getViewPortConditions_StartsAfter_EndsAfter(){
 		loc.start1=createDateTime(2015,02,28,10,00,00);
 		loc.end1=createDateTime(2015,02,28,12,00,00);
 		loc.start2=createDateTime(2015,01,28,12,00,00);
 		loc.end2=createDateTime(2015,01,28,14,00,00);
 		result=getViewPortConditions(argumentCollection=loc);
 		//debug("loc");
 		assert(!result);
 	}
 	// This daterange starts before and ends after the viewport, so should be displayed
 	function Test_getViewPortConditions_StartsBefore_EndsAFter(){
 		loc.start1=createDateTime(2015,01,01,10,00,00);
 		loc.end1=createDateTime(2015,02,28,12,00,00);
 		loc.start2=createDateTime(2015,01,15,08,00,00);
 		loc.end2=createDateTime(2015,02,15,14,00,00);
 		result=getViewPortConditions(argumentCollection=loc);
 		//debug("loc");
 		assert(result);
 	}
 	// This daterange starts during and ends during the viewport, so should be displayed
 	function Test_getViewPortConditions_StartsDuring_EndsDuring(){
 		loc.start1=createDateTime(2015,01,28,10,00,00);
 		loc.end1=createDateTime(2015,01,28,12,00,00);
 		loc.start2=createDateTime(2015,01,01,10,30,00);
 		loc.end2=createDateTime(2015,02,01,11,00,00);
 		result=getViewPortConditions(argumentCollection=loc);
 		//debug("loc");
 		assert(result);
 	}

}
