<cfscript>
cftimer(type="outline"){
	thedate=createDateTime(2010,01,01,10,00,00);
	startdate=createDateTime(2010,01,01,10,00,00);
	enddate=createDateTime(2015,01,10,10,00,00);
	cronExp="0 15 10 ? * 6L 2010-2015";
	loop from="1" to="100" index="i"{
		r=getCronDateRange(thedate, cronExp, startDate, endDate);
	}
}
</cfscript>
<cfoutput>

</cfoutput>
