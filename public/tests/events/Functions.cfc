component extends="tests.Test" {

	function setup() {}
	function teardown() {}

	function Test_parseRRuleString_1(){
		rule="RRULE:FREQ=DAILY;UNTIL=20170120T000000";
		r=parseRRuleString(rule);
		assert("structKeyExists(r, 'FREQ')");
		assert("structKeyExists(r, 'UNTIL')");
	}
}
