component extends="Controller"
{
  function init() {
    super.init();
    filters(through="f_getCalendarLocations", only="show");
    verifies(only="show", params="key", paramsTypes="integer", handler="objectNotFound");
    provides("html,json");
    usesLayout(template=false, only="detail");
  }

  // Index defaults to first available calendar
  function index(){
    redirectTo(route="calendarShow", key=request.allcalendars.id);
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

  // Render data specifically for year calendar
  function yearcalendardata(){
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
  }


  function detail(){
    booking=model("booking").findByKey(params.key);
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

    // Merge Buildings and Rooms, seperate by groupby etc
  array function mergeLocations(calendarbuildings, calendarrooms){
    local.rv=[];
    local.cb=1;
    for(local.b in calendarbuildings){
      arrayAppend(local.rv, {
        "id": local.b.id,
        "title": local.b.title,
        "hexcolour": local.b.hexcolour,
        "icon": local.b.icon,
        "description": local.b.description,
        "type": "building",
        "groupby": {}
      });

      for(local.r in calendarrooms){
        // Rooms attached to buildings
        if(local.r.buildingid == local.b.id && local.b.id != 0 && local.b.id != ""){
          if( structKeyExists(local.rv[local.cb], "groupby") ){
            if( !structKeyExists(local.rv[local.cb]["groupby"], local.r.groupby) ){
              local.rv[local.cb]["groupby"][local.r.groupby]=[];
            }
            arrayAppend(local.rv[local.cb]["groupby"][local.r.groupby], {
              "id": local.r.id,
              "title": local.r.title,
              "hexcolour": local.r.hexcolour,
              "icon": local.r.icon,
              "description": local.r.description,
              "type": "room"
            });
          }
        }
      }
      local.cb++;
    }
    // Check for orphaned rooms and append to end
    for(local.r in calendarrooms){
      if(local.r.buildingid == 0 || local.r.buildingid == ""){
        // Orphaned Rooms
        arrayAppend(local.rv, {
          "id": local.r.id,
          "title": local.r.title,
          "hexcolour": local.r.hexcolour,
          "icon": local.r.icon,
          "description": local.r.description,
          "type": "room"
        });
      }
    }
    return local.rv;
   }

}
