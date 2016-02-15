component extends="wheelsMapping.Test"  hint="Unit Tests" {

	include "../wheels/test.cfm";

	function setup(){ 
		// Dummy Data
		//loc.events=queryNew("id,title,startsAt,endsAt,allday,locationid,status,type,isNever,repeatStartsAt,repeatEndsAt,repeatEndsAfter,repeatEvery,repeatOn,repeatBy,class,description,layoutstyle,building,name","integer,varchar,date,date,tinyint,integer,varchar,varchar,tinyint,date,date,integer,integer,varchar,varchar,varchar,varchar,varchar,varchar,varchar");

		//queryAddRow(loc.events);

		// Standard Normal Event
	//	querySetCell(loc.events, "id", 1);
	//	querySetCell(loc.events, "title", "Test Standard Non Repeater");
	//	querySetCell(loc.events, "startsAt", "2015-01-28 10:00:00");
	//	querySetCell(loc.events, "endsAt", "2015-01-28 12:00:00");
	//	querySetCell(loc.events, "allDay", 0);
	//	querySetCell(loc.events, "locationid", 1);
	//	querySetCell(loc.events, "status", "pending"); 
	//	querySetCell(loc.events, "isNever", 0); 
	//	queryAddRow(loc.events);
	//	querySetCell(loc.events, "id", 2);
	//	querySetCell(loc.events, "title", "Test Standard multiday");
	//	querySetCell(loc.events, "startsAt", "2015-01-28 10:00:00");
	//	querySetCell(loc.events, "endsAt", "2015-01-29 12:00:00");
	//	querySetCell(loc.events, "allDay", 0);
	//	querySetCell(loc.events, "locationid", 1);
	//	querySetCell(loc.events, "status", "pending"); 
	//	querySetCell(loc.events, "isNever", 0);  
	//	queryAddRow(loc.events);
	//	querySetCell(loc.events, "id", 3);
	//	querySetCell(loc.events, "title", "Test Standard allDay");
	//	querySetCell(loc.events, "startsAt", "2015-01-28 10:00:00");
	//	querySetCell(loc.events, "endsAt", "2015-01-29 12:00:00");
	//	querySetCell(loc.events, "allDay", 1);
	//	querySetCell(loc.events, "locationid", 1);
	//	querySetCell(loc.events, "status", "pending"); 
	//	querySetCell(loc.events, "isNever", 0); 
	//	queryAddRow(loc.events);
	//	querySetCell(loc.events, "id", 3);
	//	querySetCell(loc.events, "title", "Daily Repeater");
	//	querySetCell(loc.events, "startsAt", "2015-01-28 10:00:00");
	//	querySetCell(loc.events, "endsAt", "2015-01-28 12:00:00");
	//	querySetCell(loc.events, "allDay", 0);
	//	querySetCell(loc.events, "locationid", 1);
	//	querySetCell(loc.events, "status", "pending"); 
	//	querySetCell(loc.events, "type", "day");
	//	querySetCell(loc.events, "isNever", 1); 
	//	querySetCell(loc.events, "repeatevery", 1);
	//	querySetCell(loc.events, "repeatstartsAt", "2015-01-28 10:00:00");  
	//	queryAddRow(loc.events);
	//	querySetCell(loc.events, "id", 3);
	//	querySetCell(loc.events, "title", "Daily Repeater skip 2nd day");
	//	querySetCell(loc.events, "startsAt", "2015-01-28 10:00:00");
	//	querySetCell(loc.events, "endsAt", "2015-01-28 12:00:00");
	//	querySetCell(loc.events, "allDay", 0);
	//	querySetCell(loc.events, "locationid", 1);
	//	querySetCell(loc.events, "status", "pending"); 
	//	querySetCell(loc.events, "type", "day");
	//	querySetCell(loc.events, "isNever", 1); 
	//	querySetCell(loc.events, "repeatstartsAt", "2015-01-28 10:00:00");  
	//	querySetCell(loc.events, "repeatevery", 2);  
	//	queryAddRow(loc.events);
	//	querySetCell(loc.events, "id", 3);
	//	querySetCell(loc.events, "title", "Daily Repeater skip 2nd day");
	//	querySetCell(loc.events, "startsAt", "2015-01-28 10:00:00");
	//	querySetCell(loc.events, "endsAt", "2015-01-28 12:00:00");
	//	querySetCell(loc.events, "allDay", 0);
	//	querySetCell(loc.events, "locationid", 1);
	//	querySetCell(loc.events, "status", "pending"); 
	//	querySetCell(loc.events, "type", "day");
	//	querySetCell(loc.events, "isNever", 1); 
	//	querySetCell(loc.events, "repeatstartsAt", "2015-01-28 10:00:00");  
	//	querySetCell(loc.events, "repeatevery", 2); 
 
		loc.event=model("event").new(
			id=1,
			title="Test",
			startsAt="2015-01-28 10:00:00",
			endsAt="2015-01-28 12:00:00",
			allday=0,
			locationid=1,
			status="approved",
			type="day",
			isNever=1,
			duration=120,
			repeatStartsAt="2015-01-28 10:00:00",
			repeatEndsAt="",
			repeatEndsAfter="",
			repeatEvery=1,
			repeatOn="",
			repeatBy=""
		);

		loc.viewPortStartDate=createDateTime(2014,12,29,00,00,00);
        loc.viewPortEndDate=createDateTime(2015,02,01,00,00,00);
           
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

	function teardown(){
		loc={};
	}
}