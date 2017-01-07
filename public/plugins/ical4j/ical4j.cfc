component hint="iCal4J" output="false" mixin="global"
{
	public  function init() {
		this.version = "1.4.5";
		return this;
	}

	public function getRecurringDates(required string pattern, required date seed, date from, date to){
		local.recur = $$createRecur(arguments.pattern);
		return local.recur.getDates($$createDate(arguments.seed), $$createDate(arguments.from), $$createDate(arguments.to), $$createValue("DATE"));
	}

	public function $$createRecur(required string string){
		return CreateObject( "java", "net.fortuna.ical4j.model.Recur" ).init(string);
	}
	public function $$createDate(required string date){
		return CreateObject( "java", "net.fortuna.ical4j.model.DateTime" ).init(date);
	}
	public function $$createValue(required string value){
		return CreateObject( "java", "net.fortuna.ical4j.model.parameter.Value" ).init(value);
	}
	/*
	d1=$$createDate("20170101T070000Z");
	    d2=$$createDate("20170101T070000Z");
	    v1=$$createValue("DATE");
	    c1=$$createRecur("DAILY");

	    // Interval
	    c1.setInterval("10");
	    // Date until
	    c1.setUntil(d2);

	 	debug("d1.toString()");
	    //c2=CreateObject( "java", "net.fortuna.ical4j.model.Recur" ).init("DAILY", dateAdd("d", 4, now()))	;
	    debug("c1.toString()");
		//WeekDayList
		debug("c1.getDayList().toString()");
		//Map
		debug("c1.getExperimentalValues()");
		//String
		debug("c1.getFrequency().toString()");
		//NumberList
		debug("c1.getHourList().toString()");
		//int
		debug("c1.getInterval().toString()");
		//NumberList
		debug("c1.getMinuteList().toString()");
		//NumberList
		debug("c1.getMonthDayList().toString()");
		//NumberList
		debug("c1.getMonthList().toString()");
		//NumberList
		debug("c1.getSecondList().toString()");
		//NumberList
		debug("c1.getSetPosList().toString()");
		//Date
		debug("c1.getUntil()");
		//NumberList
		debug("c1.getWeekNoList().toString()");
		//String
		debug("c1.getWeekStartDay()");
		//NumberList
		debug("c1.getYearDayList().toString()");

		//Date
		debug("c1.getNextDate(d1, d2)");
		//Returns the the next date of this recurrence given a seed date and start date.

		//DateList
		debug("c1.getDates(d1, d1, d2, v1)");
		//Returns a list of start dates in the specified period represented by this recur.

		//DateList
		//debug("c1.getDates(Date seed, Date periodStart, Date periodEnd, Value value, int maxCount)");
		//Returns a list of start dates in the specified period represented by this recur.

		//DateList
		//debug("c1.getDates(d1,d2, 'DATE_TIME')");
		//Returns a list of start dates in the specified period represented by this recur.

		//DateList
		//debug("c1.getDates(Date seed, Period period, Value value)");
		//Convenience method for retrieving recurrences in a specified period.
		*/
}
