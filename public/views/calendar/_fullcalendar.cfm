<!--- Main Calendar --->
<cfoutput>
  <cfset settings=application.rbs.settings>
    <!--- This is just a way of getting settings from the DB into Javascript a bit more easily --->
      <div id="settings"
        data-key=#params.key#
        data-dataurl="#urlFor(route="calendarFullcalendardata")#"
        data-resourcedataurl="#urlFor(route="calendarFullcalendarresources")#"
        data-filterdataurl="#urlFor(route="calendarFullcalendarfilters")#"
        data-headerleft="#settings.calendar_headerLeft#,myCustomButton"
        data-headercenter="#settings.calendar_headerCenter#"
        data-headerright="#settings.calendar_headerRight#"
        data-weekends=#settings.calendar_weekends#
        data-eventlimit=#settings.calendar_eventLimit#
        data-firstday=#settings.calendar_firstday#
        data-hiddendays=#settings.calendar_hiddenDays#
        data-fixedweekcount=#settings.calendar_fixedWeekCount#
        data-weeknumbers=#settings.calendar_weekNumbers#
        data-weeknumberswithindays=#settings.calendar_weekNumbersWithinDays#
      ></div>
      <div id="notices"></div>
      <div id="filterbar">
      <div id="filters" class="box box-default">
      <div class="box-body ">
        <button type="button" class="btn btn-xs btn-default locationfilter btn-flat" title="All" data-filtertype="none" data-id="0">#l("All")#</button>
        <!--- JS Appends to this--->
        <div class="btn-group filterholder"></div>
      </div><!--/box-body-->
      </div><!--/filters-->
      </div><!--/filterbar-->

    #includePartial("calendar")#

</cfoutput>

<cfsavecontent variable="request.js.calendar">
<script>
$(document).ready(function() {

//=====================================================================
//=   Initialise
//=====================================================================
  var settings =initSettings();
  var filters  =initFilterBar();
  var calendar =initCalendar();
                getCalendar();

  // Sidebar Links
  $(".calendarswitcher").on("click", function(e){
     setSetting("key", $(this).data("key"));
     $(".calendarswitcher").parent().removeClass("active");
     $(this).parent().addClass("active");
     $('.popover').popover('destroy');
     getFilterBar();
     getCalendar();
     e.preventDefault();
  });
//=====================================================================
//=   Settings
//=====================================================================
  function initSettings(){
    //console.log("initSettings()");
    var settings=$("#settings").data();
    return settings;
  }

  function setSetting(name, value){ settings[name]=value;}
  function getSetting(name){ return settings[name]; }

//=====================================================================
//=   Filter Bar + Filters
//=====================================================================
  function initFilterBar(){
    //console.log("initFilterBar()");
    getFilterBar();
  }

  function getFilterBar(){
    //console.log("getFilterBar()");
    $.ajax({
        url: settings.filterdataurl,
        cache: false,
        data: {
          key: settings.key
        },
        success: function(data){
          //$("#filterbar").html(data);
          renderFilterBar(data);
          //console.log(data);
        },
        error: function(e){
          console.log(e);
          fetchError("Filter Bar");
        }
    });
  }

  function renderFilterBar(data){
    //console.log("renderFilterBar()");
    var e=$("#filters .box-body .filterholder");
        e.html("");
    var h="";
    for(i in data){
      if(data[i]["type"] == 'building'){
        h+="<div class='btn-group'>";
        h+=renderBtn(data[i]);
          h+=renderBtnDD();
          h+=" <ul class='dropdown-menu'>";
          for(g in data[i]["groupby"]){
            if(g != 0){
              h+='<li class="dropdown-header">' + g + '</li><li class="divider"></li>';
            }
            for(r in data[i]["groupby"][g]){
              h+=renderLi(data[i]["groupby"][g][r]);
            }
          }
          h+="</ul>";
        h+="</div>";
      } else {
        if(typeof data[i]["type"] != 'undefined'){
          h+=renderBtn(data[i]);
        }
      }
    }
    $(e).append(h);
    assignFilterClickHandlers();
  }

  function renderBtn(btn){
    var b=$("<button>")
        .addClass("btn btn-xs btn-default btn-flat locationfilter")
        .attr({"title":btn.description, "data-id":btn.id, "data-filtertype": btn.type})
        .html("<i style='color:#" + btn.hexcolour + ";' class='fa " + btn.icon + "'></i> " + btn.title)
        ;
    return b[0]["outerHTML"];
  }
  function renderBtnDD(){
    var b=$("<button>")
        .addClass("btn btn-xs btn-default btn-flat dropdown-toggle")
        .attr({"data-toggle":"dropdown", "aria-expanded": "false"})
        .html('<span class="caret"></span><span class="sr-only">Toggle Dropdown</span>')
        ;
    return b[0]["outerHTML"];
  }

  function renderLi(btn){
    var b=$("<a>")
        .addClass("locationfilter")
        .attr({"title":btn.description, "data-id":btn.id, "data-filtertype": btn.type})
        .html("<i style='color:#" + btn.hexcolour + ";' class='fa " + btn.icon + "'></i> " + btn.title)
        ;
    var rv="<li>" + b[0]["outerHTML"] + "<li>";
    return rv;
  }

  function assignFilterClickHandlers(){
    //console.log("assignFilterClickHandlers()");
      $("#filters .locationfilter").off("click").on("click", function(e){
        var data=$(this).data();
        //console.log(data);
        $("#notices").html("");
        $('.popover').popover('destroy');
        setFilterData(settings.key, data.filtertype, data.id);
        calendar.fullCalendar( 'removeEventSources');
        calendar.fullCalendar( 'addEventSource', {
          url: settings.dataurl,
          data: getFilterData,
          error: function(e){
            console.log(e);
           fetchError("Filtered Events");
          }
         });
        e.preventDefault();
      });
  }

  function setFilterData(key,filtertype,id){ filters= {key:key, filtertype: filtertype,id: id}}
  function getFilterData(){ return filters;}
//=====================================================================
//=   Full Calendar
//=====================================================================

  function initCalendar(){
    //console.log("initCalendar()");
     return $('#calendar').fullCalendar(getCalendarSettings());
  }

  function fetchError(string){
    var h="<div class='alert alert-warning alert-dismissible '><button type='button' class='close' data-dismiss='alert' aria-hidden='true'><i class='fa fa-times'></i></button><h4><i class='icon fa fa-exclamation-triangle'></i>Error</h4>Error Fetching " + string + "...</div>";
      $("#notices").html(h);
  }

  function getCalendar(){
    calendar.fullCalendar( 'removeEventSources');
    calendar.fullCalendar( 'addEventSource', {
      url: settings.dataurl,
      data: {
        key: getSetting("key")
      },
      error: function(e){
        console.log(e);
       fetchError("Bookings");
      }
     });
  }
  /*

      resources: {
          url: getSetting("resourcedataurl"),
          data: {
            key: getSetting("key")
          },
          error: fetchError
      },
      */

  function getCalendarSettings(){
    var settings={
      locale: $('html').attr('lang'),
      header: {
        left: getSetting("headerleft"),
        center: getSetting("headercenter"),
        right: getSetting("headerright")
      },
      weekends: getSetting("weekends"),
      firstDay: getSetting("firstday"),
      eventLimit: getSetting("eventlimit"),
      hiddenDays: getSetting("hiddendays"),
      fixedWeekCount: getSetting("fixedweekcount"),
      weekNumbers: getSetting("weeknumbers"),
      weekNumbersWithinDays: getSetting("weeknumberswithindays"),
      editable: false,
      customButtons: {
        cPrev: {
          icon: "fa fa-chevron-circle-left", click: function(){ calendar.fullCalendar('prev');}},
        cToday: {
          icon: "fa fa-bullseye", click: function(){ calendar.fullCalendar('today');}},
        cNext: {
          icon: "fa fa-chevron-circle-right", click: function(){ calendar.fullCalendar('next');}},
        cMonth: {
          icon: "fa fa-calendar", click: function(){ calendar.fullCalendar('changeView', 'month');}},
        cAgendaWeek: {
          icon: "fa fa-calendar-o", click: function(){ calendar.fullCalendar('changeView', 'agendaWeek');}},
        cAgendaDay: {
          icon: "fa fa-calendar-o", click: function(){ calendar.fullCalendar('changeView', 'agendaDay');}},
        cListMonth: {
          icon: "fa fa-th-list", click: function(){ calendar.fullCalendar('changeView', 'listMonth');}},
        cListWeek: {
          icon: "fa fa-th-list", click: function(){ calendar.fullCalendar('changeView', 'listWeek');}},
        cListDay: {
          icon: "fa fa-th-list", click: function(){ calendar.fullCalendar('changeView', 'listDay');}},
        cTimelineDay: {
          icon: "fa fa-list-alt", click: function(){ calendar.fullCalendar('changeView', 'timelineDay');}},
        cTimelineWeek: {
          icon: "fa fa-list-alt", click: function(){ calendar.fullCalendar('changeView', 'timelineWeek');}},
        cTimelineMonth: {
          icon: "fa fa-list-alt", click: function(){ calendar.fullCalendar('changeView', 'timelineMonth');}}
      },
      eventRender: function(event, element) {
        if(!event.isApproved){
          $(element).find(".fc-content").prepend('<i class="fa fa-question-circle"></i> ');
        }
        if(event.isRepeat){
          $(element).find(".fc-content").prepend('<i class="fa fa-repeat"></i> ');
        }
        if(event.isPast){
          $(element).css({"opacity": 0.6});
        }
      },
      eventClick: function( event, jsEvent, view ){
        var t=this;
        $.ajax({
          url: event.detailurl,
          success: function(data){
            //console.log(event, data);
            var title="";
            if(!event.isApproved){
              title+=('<i class="fa fa-question-circle"></i> ');
            }
            if(event.isRepeat){
                title+=('<i class="fa fa-repeat"></i> ');
            }
            title+=event.title;
            $('.popover').popover('hide');
            $(t).popover({ title:title, content: data, html :true, placement: "auto top", container:'#calendar'}).popover("show");
          }
          });
        },
      dayClick: function(date, jsEvent, view) {
          console.log('Clicked on: ' + date.format());
          console.log(jsEvent);
          console.log(view);
          $('.popover').popover('hide');
      },
      viewRender: function(view, element){
        $('.popover').popover('destroy');
      }
    }
    //console.log(settings);
    return settings;
  }


/*
  var calendar=$('#calendar').fullCalendar({
    // Set Locale from session
    locale: $('html').attr('lang'),

    // All these other options come from the main application settings
    //header: {
    //  left: settings.headerleft,
    //  center: settings.headercenter,
    //  right: settings.headerright
    //},

    header: {
      left: "cPrev,cToday,cNext title",
      center: "",
      right: "cMonth,cListMonth,cTimelineMonth cAgendaWeek,cListWeek,cTimelineWeek cAgendaDay,cListDay,cTimelineDay, cListYear"
    },
    weekends: settings.weekends,
    firstDay: settings.firstday,
    eventLimit: settings.eventlimit,
    hiddenDays: settings.hiddendays,
    fixedWeekCount: settings.fixedweekcount,
    weekNumbers: settings.weeknumbers,
    weekNumbersWithinDays: settings.weeknumberswithindays,
    editable: false,

    // Scheduler
    //resourceGroupField: 'building',
    resources: {
        url: settings.resourcedataurl
        //,
        //error: fetchError
    },

    eventSources: [
       {
          url: settings.dataurl,
          data: getFilterData
          //error: fetchError
        }
    ],
    customButtons: {
      cPrev: {
        icon: "fa fa-chevron-circle-left", click: function(){ calendar.fullCalendar('prev');}},
      cToday: {
        icon: "fa fa-bullseye", click: function(){ calendar.fullCalendar('today');}},
      cNext: {
        icon: "fa fa-chevron-circle-right", click: function(){ calendar.fullCalendar('next');}},
      cMonth: {
        icon: "fa fa-calendar", click: function(){ calendar.fullCalendar('changeView', 'month');}},
      cAgendaWeek: {
        icon: "fa fa-calendar-o", click: function(){ calendar.fullCalendar('changeView', 'agendaWeek');}},
      cAgendaDay: {
        icon: "fa fa-calendar-o", click: function(){ calendar.fullCalendar('changeView', 'agendaDay');}},
      cListMonth: {
        icon: "fa fa-th-list", click: function(){ calendar.fullCalendar('changeView', 'listMonth');}},
      cListWeek: {
        icon: "fa fa-th-list", click: function(){ calendar.fullCalendar('changeView', 'listWeek');}},
      cListDay: {
        icon: "fa fa-th-list", click: function(){ calendar.fullCalendar('changeView', 'listDay');}},
      cTimelineDay: {
        icon: "fa fa-list-alt", click: function(){ calendar.fullCalendar('changeView', 'timelineDay');}},
      cTimelineWeek: {
        icon: "fa fa-list-alt", click: function(){ calendar.fullCalendar('changeView', 'timelineWeek');}},
      cTimelineMonth: {
        icon: "fa fa-list-alt", click: function(){ calendar.fullCalendar('changeView', 'timelineMonth');}}
    },
    eventRender: function(event, element) {
      if(!event.isApproved){
        $(element).find(".fc-content").prepend('<i class="fa fa-question-circle"></i> ');
      }
      if(event.isRepeat){
        $(element).find(".fc-content").prepend('<i class="fa fa-repeat"></i> ');
      }
      if(event.isPast){
        $(element).css({"opacity": 0.6});
      }
    },
    eventClick: function( event, jsEvent, view ){
      $.ajax({
        url: event.detailurl,
        success: function(data){
          //$("#sidebar-dynamic-content").html(data);
          //$(".rightbar-toggle").trigger("click");
        }
        });
      },
    dayClick: function(date, jsEvent, view) {
        //console.log('Clicked on: ' + date.format());
        //console.log(jsEvent);
        //console.log(view);
    }
  // end FC
  });
*/
/*

  function assignFilterClickHandlers(){
      $("#filters .locationfilter").on("click", function(e){
        var data=$(this).data();
        console.log(data);
        $("#notices").html("");
        setFilterData(settings.key, data.filtertype, data.id);
        calendar.fullCalendar( 'refetchEvents' );
        e.preventDefault();
      });
  }

  function renderFilters(){
     $.ajax({
        url: settings.filterdataurl,
        data: getFilterData,
        cache: false,
        success: function(data){
          $("#filterbar").html(data);
          assignFilterClickHandlers();
        },
        error: fetchError
        });
  }

  function setFilterData(key, filtertype,id){
     filters= {
      key: settings.key,
      filtertype: filtertype,
      id: id
     }
  }

  function getFilterData(){
     return filters;
  }

  function resetFilterData(){
     filters={};
  }

  function fetchError(){
    var h="<div class='alert alert-warning alert-dismissible '><button type='button' class='close' data-dismiss='alert' aria-hidden='true'><i class='fa fa-times'></i></button><h4><i class='icon fa fa-exclamation-triangle'></i>Error</h4>Error Fetching Bookings...</div>";
      $("#notices").html(h);
  }

  $(".calendarswitcher").on("click", function(e){
     console.log("Change Calendar");
     e.preventDefault();
     $(".calendarswitcher").parent().removeClass("active");
     $(this).parent().addClass("active");
     settings.dataurl=$(this).data("dataurl");
     settings.resourcedataurl=$(this).data("resourceurl");
     calendar.fullCalendar( 'removeEventSources');
     resetFilterData();
     renderFilters();
     calendar.fullCalendar( 'addEventSource', {
      url: settings.dataurl,
      data: getFilterData,
      error: fetchError
     });
     //calendar.fullCalendar( 'refetchEvents' );
  });
*/
//----/document ready
});
</script>
</cfsavecontent>
