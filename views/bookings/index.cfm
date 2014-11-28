<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfoutput>
<cfparam name="locations">

<!--- Main Index --->
#includePartial(partial="locations", locations=locations)#
    #panel(title="Calendar")#
        <div id="calendar"></div>
    #panelend()#
#includePartial("eventmodal")#

<cfsavecontent variable="request.js.footer">
<script>
   $(document).ready(function() {

    var mainDataURL="#urlFor(controller='eventdata', action='getEvents')#/";
    var eventDataURL="#urlFor(controller='eventdata', action='getEvent')#/";
    var addBookingURL = "#urlFor(controller='bookings', action='add')#/";
    <!--- IF YOUR SERVER HAS SECURE AJAX CALLS, uncomment this
    $.ajaxSetup({
        dataFilter: function(data, type){
            return data.substring(2, data.length);
        }
    });
    --->
    $('##calendar').fullCalendar({
    //----------------Config--------------
                header: {
                    left: '#application.rbs.setting.calendarHeaderleft#',
                    center: '#application.rbs.setting.calendarHeadercenter#',
                    right: '#application.rbs.setting.calendarHeaderright#'
                },

                weekends: #returnStringFromBoolean(application.rbs.setting.calendarWeekends)#,
                firstDay: #application.rbs.setting.calendarFirstday#,
                slotDuration: '#application.rbs.setting.calendarSlotMinutes#',
                minTime: "#application.rbs.setting.calendarMintime#",
                maxTime: "#application.rbs.setting.calendarMaxtime#",
                timeFormat: '#application.rbs.setting.calendarTimeformat#',
                hiddenDays: #application.rbs.setting.calendarHiddenDays#,
                weekNumbers: #returnStringFromBoolean(application.rbs.setting.calendarWeekNumbers)#,
                allDaySlot: #returnStringFromBoolean(application.rbs.setting.calendarAllDaySlot)#,
                allDayText: '#application.rbs.setting.calendarAllDayText#',
                defaultView: '#application.rbs.setting.calendarDefaultView#',
                axisFormat: '#application.rbs.setting.calendarAxisFormat#',
                slotEventOverlap: #returnStringFromBoolean(application.rbs.setting.calendarSlotEventOverlap)#,
                height: 'auto',
                columnFormat: {
                        month: '#application.rbs.setting.calendarColumnFormatMonth#',    // Mon
                        week: '#application.rbs.setting.calendarColumnFormatWeek#', // Mon 9/7
                        day: '#application.rbs.setting.calendarColumnFormatDay#'  // Monday 9/7
                    } ,

    //----------------Event Sources----------
                eventSources: [
                 {
                        url: mainDataURL + "#params.key#" + "?format=json",
                        type: 'POST',
                        cache: false,
                        error: function() {
                            alert('there was an error while fetching events!');
                        }
                  }
                ],
    //----------------Day Click--------------
                dayClick: function(date, allDay, jsEvent, view) {
                    var thepast=moment().subtract("days", 1);
                    if(moment(date).isAfter(thepast)){
                        if (allDay) {
                            window.location.href = addBookingURL + "#params.key#?d=" + moment(date).format("YYYY-MM-DD");
                        } else {
                            window.location.href = addBookingURL + "#params.key#?d=" + moment(date).format("YYYY-MM-DD");
                        }
                     }
                },
    //----------------Event Click --------------
                eventClick: function(calEvent, jsEvent, view) {
                    $('##eventmodal').modal({
                        remote: eventDataURL +  calEvent.id + "?format=json"
                     });
                },
                editable: false
            });

});
</script>
 </cfsavecontent>
</cfoutput>
