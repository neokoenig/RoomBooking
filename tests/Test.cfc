component extends="wheelsMapping.Test"  hint="Unit Tests" {

	include "../wheels/test.cfm";

	function setup(){

		loc.eventProperties={
			id=1,
			title="Test Event",
			// NB 28th Jan 28 was a wednesday
			start="2015-01-28 10:00:00",
			end="2015-01-28 12:00:00",
			allday=0,
			description="",
			location=1
		};
		loc.repeatruleProperties={
			id=1,
			eventid=1,
			type="day",
			starts=now(),
			isnever=0,
			endsAfter=3,
			endsOn="",
			repeatevery=1,
			repeatBy=""
		};
	}

	function teardown(){

	}
}