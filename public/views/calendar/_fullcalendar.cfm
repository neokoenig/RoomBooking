<!--- Main Calendar --->
<cfoutput>
  <cfset settings=application.rbs.settings>
    <!--- This is just a way of getting settings from the DB into Javascript a bit more easily --->
      <div id="settings"
        data-dataurl="#urlFor(route="calendarFullcalendardata", key=params.key)#"
        data-headerleft="#settings.calendar_headerLeft#,"
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

    #includePartial("filters")#
    #includePartial("calendar")#

</cfoutput>

<cfsavecontent variable="request.js.calendar">
<script>
$(document).ready(function() {
  var settings=$("#settings").data();
  var filters={}
  var calendar=$('#calendar').fullCalendar({
    // Set Locale from session
    locale: $('html').attr('lang'),

    // All these other options come from the main application settings
    header: {
      left: settings.headerleft,
      center: settings.headercenter,
      right: settings.headerright
    },

    weekends: settings.weekends,
    firstDay: settings.firstday,
    eventLimit: settings.eventlimit,
    hiddenDays: settings.hiddendays,
    fixedWeekCount: settings.fixedweekcount,
    weekNumbers: settings.weeknumbers,
    weekNumbersWithinDays: settings.weeknumberswithindays,
        editable: false,

    // Event Sources: Each Building is an event source?
        eventSources: [
           {
                url: settings.dataurl,
              data: getFilterData,
                error: fetchError
            }
        ],
        eventRender: function(event, element) {
          if(!event.isApproved){
            $(element).find(".fc-time").prepend('<i class="fa fa-question-circle"></i> ');
          }
          if(event.isRepeat){
            $(element).find(".fc-time").prepend('<i class="fa fa-repeat"></i> ');
          }
          if(event.isPast){
            $(element).css({"opacity": 0.6});
          }
      },
      eventClick: function( event, jsEvent, view ){
        //console.log(event);
        $.ajax({
        url: event.detailurl,
        success: function(data){
          //console.log(data);
          $("#sidebar-dynamic-content").html(data);
        }
      });

        $(".rightbar-toggle").trigger("click");
        //alert('Event: ' + elementvent.title);
          //alert('Coordinates: ' + jsEvent.pageX + ',' + jsEvent.pageY);
          //alert('View: ' + view.name);

          // change the border color just for fun
          //$(this).css('border-color', 'red');<!-- Control Sidebar Toggle Button -->
          //<li>
          //  <a href="" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
          //</li>

      }

  });

  $("#filters .locationfilter").on("click", function(e){
    var data=$(this).data();
    console.log(data);
    $("#notices").html("");
    setFilterData(data.filtertype, data.id);
    calendar.fullCalendar( 'refetchEvents' );
    e.preventDefault();
  });

  function setFilterData(filtertype,id){
     filters= {
      filtertype: filtertype,
      id: id
     }
  }

  function getFilterData(){
     return filters;
  }

  function fetchError(){
    var h="<div class='alert alert-warning alert-dismissible '><button type='button' class='close' data-dismiss='alert' aria-hidden='true'><i class='fa fa-times'></i></button><h4><i class='icon fa fa-exclamation-triangle'></i>Error</h4>Error Fetching Bookings...</div>";
      $("#notices").html(h);
  }

//----/document ready
});

 /*----------------Day Click--------------
        dayClick: function(date, allDay, jsEvent, view) {
            var thepast=moment().subtract("days", 1);
            if(moment(date).isAfter(thepast)){
            // Deal with url rewriting differing paths
               if(urlrewriting === "off"){
                window.location.href = addURL + "&key=" + settings.key + "&d=" + moment(date).format("YYYY-MM-DD");
               } else {
                window.location.href = addURL + settings.key + "?d=" + moment(date).format("YYYY-MM-DD");
               }
             }
        },
    //----------------Event Click --------------
        eventClick: function(calEvent, jsEvent, view) {
            var specificEvent="";
            console.log(calEvent, jsEvent, view);
            // Deal with url rewriting differing paths
            if(urlrewriting === "off"){
                specificEvent="&key=" + calEvent.id + "&format=json"+ "&instanceDate=" + moment(calEvent.start).format("YYYY-MM-DD");
            } else {
                specificEvent="/" + calEvent.id + "?format=json"+ "&instanceDate=" + moment(calEvent.start).format("YYYY-MM-DD");
            }
            $('#eventmodal').modal({
               remote: eventURL + specificEvent
             });
        },
    });
    }*/
</script>
</cfsavecontent>
