component extends="Controller"
{
  function init() {
    super.init();
    filters(through="f_getCalendarLocations", only="show,fullcalendarresources");
    verifies(only="show", params="key", paramsTypes="integer", handler="objectNotFound");
    provides("html,json");
    usesLayout(template=false, only="detail,fullcalendarfilters");
  }

  // Index defaults to first available calendar
  function index(){
    param name="params.key" default=allcalendars.id;
    f_getCalendarLocations();
    calendar=model("calendar").findByKey(params.key);
  }

  // Show a specific calendar
  function show(){
    calendar=model("calendar").findByKey(params.key);
    if(!isObject(calendar)){
      objectNotFound();
    }
    request.pagetitle=calendar.title;
  }

  // Render data specifically for full calendar
  function fullcalendardata(){
    param name="params.start" default="#dateFormat(now(), 'YYYY-MM-DD')#";
    param name="params.end" default="#dateFormat(dateAdd('d', 30, now()), 'YYYY-MM-DD')#";
    params.format="json";
    if(structKeyExists(params, "key") && isNumeric(params.key)){
      // Return Array of Structs including repeats
      renderWith( formatDataForCalendar( getEventsForRange(start=params.start, end=params.end) ) );
    } else {
      renderWith(data="{'error': 'No Calendar ID Specified'}", status=500);
    }
  }

  // Get Resource(Locations) JSON specifically for full calendar
  function fullcalendarresources(){
    params.format="json";
    if(structKeyExists(params, "key") && isNumeric(params.key)){
      // Return Array of Structs including repeats
      renderWith( formatResourcesForCalendar(locations));
    } else {
      renderWith(data="{'error': 'No Calendar ID Specified'}", status=500);
    }
  }

  // Get filters HTML specifically for full calendar
  function fullcalendarfilters(){
    params.format="json";
    if(structKeyExists(params, "key") && isNumeric(params.key)){
      f_getCalendarLocations();
      renderWith(locations);
      //renderPartial(partial="/calendar/filters/");
    } else {
      renderWith(data={'error': 'No Calendar ID Specified'}, status=500);
    }
  }
  // Render data specifically for year calendar
  /*function yearcalendardata(){
    param name="params.year" default=year(now());
    params.format="json";
    local.start="2017-01-01";
    local.end="2017-12-31";
    local.bookings=getEventsForRange(start=local.start, end=local.end );
    if(structKeyExists(params, "key") && isNumeric(params.key)){
      // Return Array of Structs including repeats
      renderWith( formatDataForYearCalendar( getEventsForRange(start=local.start, end=local.end) ) );
    } else {
      renderWith(data="{'error': 'No Calendar ID Specified'}", status=500);
    }
  }*/


  function detail(){
    booking=model("booking").findByKey(key=params.key, include="building,room");
    if(!isObject(booking)){
      renderText("Booking Not Found");
    }
  }

  function objectNotFound() {
    return redirectTo(action="index", error="That calendar wasn't found");
  }


  private function f_getCalendarLocations(){
    calendarbuildings=model("calendarbuilding").findAll(where="calendarid = #params.key#", include="building", order="title");
    calendarrooms=model("calendarroom").findAll(where="calendarid = #params.key#", include="room", order="title");
    locations=mergeLocations(calendarbuildings, calendarrooms);
  }

}
