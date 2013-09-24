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

    $('##calendar').fullCalendar({
    //----------------Config--------------
                header: {
                    left: '#application.rbs.calendarHeaderleft#',
                    center: '#application.rbs.calendarHeadercenter#',
                    right: '#application.rbs.calendarHeaderright#' 
                },
                weekends: #returnStringFromBoolean(application.rbs.calendarWeekends)#,
                firstDay: #application.rbs.calendarFirstday#,
                slotMinutes: #application.rbs.calendarSlotMinutes#,
                minTime: "#application.rbs.calendarMintime#", 
                timeFormat: '#application.rbs.calendarTimeformat#',
                hiddenDays: #application.rbs.calendarHiddenDays#,
                weekNumbers: #returnStringFromBoolean(application.rbs.calendarWeekNumbers)#,
                allDaySlot: #returnStringFromBoolean(application.rbs.calendarAllDaySlot)#,
                allDayText: '#application.rbs.calendarAllDayText#',
                defaultView: '#application.rbs.calendarDefaultView#',
                axisFormat: '#application.rbs.calendarAxisFormat#',
                slotEventOverlap: #returnStringFromBoolean(application.rbs.calendarSlotEventOverlap)#,
                columnFormat: {
                        month: '#application.rbs.calendarColumnFormatMonth#',    // Mon
                        week: '#application.rbs.calendarColumnFormatWeek#', // Mon 9/7
                        day: '#application.rbs.calendarColumnFormatDay#'  // Monday 9/7
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
                            //alert('Clicked on the slot: ' + date);
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
     
    //-------------------------------Remove Old Modal Data------------------//
    $('body').on('hidden.bs.modal', '.modal', function () {
        $(this).removeData('bs.modal');
    }); 
 
});
</script>
 </cfsavecontent>
</cfoutput>
