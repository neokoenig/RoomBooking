<cfscript>
    //=====================================================================
    //=     Main Calendar Data & Event Repeat Functions
    //=====================================================================
    public array function getEventsForRange(required start, required end){

      // Events Search Range
      local.start=createDateTime(year(arguments.start), month(arguments.start), day(arguments.start), hour(arguments.start),minute((arguments.start)),00);
      local.end=createDateTime(year(arguments.end), month(arguments.end), day(arguments.end), hour(arguments.end),minute((arguments.end)),59);
      local.where=[];
      local.filters=[];
      local.wc="";
      local.events="";

      //=   Date Filters (OR)
      // Bookings which fall into viewPort range: remember endUTC is the end date including the repeats, and not necessarily the true duration
      ArrayAppend(local.where, "(startUTC >= '#local.start#' AND startUTC <= '#local.end#')");
      ArrayAppend(local.where, "(startUTC <= '#local.start#' AND endUTC <= '#local.end#')");
      ArrayAppend(local.where, "(startUTC <  '#local.start#' AND endUTC > '#local.end#')");

      //=   Filters (AND)
      // By Calendar (required)
      ArrayAppend(local.filters, "(calendarbuildings.calendarid = #params.key# OR calendarrooms.calendarid = #params.key#)");

      // By Building
      if(structKeyExists(params, "filtertype") && params.filtertype == "building"){
        ArrayAppend(local.filters, "buildingid = #params.id#");
      }
      // By Room
      if(structKeyExists(params, "filtertype") && params.filtertype == "room"){
        ArrayAppend(local.filters, "roomid = #params.id#");
      }

      // Create Where Clause
      if(arraylen(local.where)){
        local.wc="(" & whereify(local.where, "OR") & ")";
      } else {
        local.wc="";
      }
      if(arraylen(local.filters)){
          local.wc &= "AND " & whereify(local.filters, "AND");
      }
      // Can't do returnas structs here as we need the deeper associations
      local.bookings=model("booking").findAll(where=local.wc, order="startUTC ASC", include="building(calendarbuildings),room(calendarrooms)");
      local.bookings=queryToArray(local.bookings, false, false, false);
      local.bookings=generateRepeatingDates(local.bookings, local.start, local.end);
      return local.bookings;
    }

    // Generate repeating dates
    public array function generateRepeatingDates(required array bookings, required date start, required date end){
      local.bookings=arguments.bookings;
      local.rv=[];
      for(b in local.bookings){
        arrayAppend(local.rv, b);
        // Flag to check whether it's gone via this system properly
        b["parsedrepeat"]=b.isrepeat && len(b.repeatpattern) ? true:false;
        // Only do repeat logic if repeat = true, and there is a repeattype
        if(b.parsedrepeat){
          b["repeats"]=addEventDuration(b.startUTC, b.duration,
                         getRecurringDates(replace(b.repeatpattern, "RRULE:", "", "all"), b.startUTC, start, end)
                      );

          for(r in b.repeats){
            copy=duplicate(b);
            copy.startUTC=r.start;
            copy.endUTC=r.end;
            structDelete(copy, "repeats");
            arrayAppend(local.rv, copy);
            copy={};
          }
        }
      }
      return local.rv;
    }

    /**
    *  @hint Take an array of dates, create start and end dates based on single event date/time and return
    *  @param date eventStart
    *  @param numeric duration (in minutes)
    *  @array dates Existing array of dates
    */
    public array function addEventDuration(
        required date eventStart,
        required numeric duration,
        required array dates) {
        var r=[];
        var repeatingEventStart= "";
        var repeatingEventEnd  = "";
        // Make sure 'date' has no min / hour value
        for(date in dates){
            repeatingEventStart= createDateTime(year(date), month(date), day(date), hour(eventStart), minute(eventStart), 00);
            repeatingEventEnd  = dateAdd("n", duration, repeatingEventStart);
            arrayAppend(r, {
                "start": repeatingEventStart,
                "end":   repeatingEventEnd
            });
        }
        return r;
    }

    // Massage array/struct for return to fullcalendar
    // This is the only cross platform consistent way of preserving case
    public array function formatDataForCalendar(required array bookings){
      local.rv=[];
      for(b in arguments.bookings){
        t["id"]             =b.id;
        t["title"]          =b.title;
        t["start"]          =ISODateFormat(b.startUTC);
        t["end"]            =ISODateFormat(dateAdd("n", b.duration, b.startUTC));
        t["detailurl"]      =urlFor(route='calendarDetail', key=b.id);
        t["isPast"]         =b.startUTC < now() ? true:false;
        t["isApproved"]     =b.isapproved;
        t["isRepeat"]       =b.isrepeat;
        t["duration"]       =b.duration;
        t["allDay"]         =b.isallday;
        t["buildingid"]     =b.buildingid;
        t["hexcolour"]      =b.hexcolour;
        t["roomhexcolour"]  =b.roomhexcolour;
        t["roomid"]         =b.roomid;
        // calculate colours
        if(len(b.buildingid) && isNumeric(b.buildingid))
          t["color"]        =   "###b.hexcolour#";
        if(len(b.roomid) && isNumeric(b.roomid)){
          t["backgroundColor"]    =   "white";
          t["textColor"]          =   "###b.roomhexcolour#";
          if(len(b.roomhexcolour)){
            t["borderColor"]        =   "###b.roomhexcolour#";
          } else {
            t["borderColor"]        =   "white";
          }
        }
        // Append the final struct
        arrayAppend(local.rv, t);
        t={};
      }
      return local.rv;
    }
    </cfscript>
