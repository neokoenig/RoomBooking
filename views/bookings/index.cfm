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
                    left: '#application.roombooking.calendarHeaderleft#',
                    center: '#application.roombooking.calendarHeadercenter#',
                    right: '#application.roombooking.calendarHeaderright#' 
                },
                weekends: #returnStringFromBoolean(application.roombooking.calendarWeekends)#,
                firstDay: #application.roombooking.calendarFirstday#,
                slotMinutes: #application.roombooking.calendarSlotMinutes#,
                minTime: "#application.roombooking.calendarMintime#", 
                timeFormat: '#application.roombooking.calendarTimeformat#',
                hiddenDays: #application.roombooking.calendarHiddenDays#,
                weekNumbers: #returnStringFromBoolean(application.roombooking.calendarWeekNumbers)#,
                allDaySlot: #returnStringFromBoolean(application.roombooking.calendarAllDaySlot)#,
                allDayText: '#application.roombooking.calendarAllDayText#',
                defaultView: '#application.roombooking.calendarDefaultView#',
                axisFormat: '#application.roombooking.calendarAxisFormat#',
                slotEventOverlap: #returnStringFromBoolean(application.roombooking.calendarSlotEventOverlap)#,
                columnFormat: {
                        month: '#application.roombooking.calendarColumnFormatMonth#',    // Mon
                        week: '#application.roombooking.calendarColumnFormatWeek#', // Mon 9/7
                        day: '#application.roombooking.calendarColumnFormatDay#'  // Monday 9/7
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
                    if(moment(date).isSame() || moment(date).isAfter()){
                        if (allDay) {  
                            window.location.href = addBookingURL + "/#params.key#?d=" + moment(date).format("YYYY-MM-DD");
                        } else {
                            //alert('Clicked on the slot: ' + date);
                            window.location.href = addBookingURL + "/#params.key#?d=" + moment(date).format("YYYY-MM-DD");
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
