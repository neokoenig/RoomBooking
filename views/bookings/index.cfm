<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfoutput>
<cfparam name="params.key" default="">
<cfset cal=application.rbs.setting>
<!--- Main Index --->
<cfif cal.showlocationfilter>
    #includePartial(partial="locations", locations=locations)#
</cfif>
    #panel(title="Calendar", theclass="panel-primary no-top-rounded")#
        <div id="calendar"
            data-eventsurl="#urlFor(route="getEvents", type=params.action, key=params.key, params='format=json')#"
            data-eventurl="#urlFor(controller='eventdata', action='getevent')#"
            data-addurl="#urlFor(controller='bookings', action='add')#"
            data-urlrewriting="#get('urlrewriting')#"></div>

        <div id="settings"
                data-headerleft="#cal.calendarHeaderleft#"
                data-headercenter="#cal.calendarHeadercenter#"
                data-headerright="#cal.calendarHeaderright#"
                data-weekends=#returnStringFromBoolean(cal.calendarWeekends)#
                data-firstDay=#cal.calendarFirstday#
                data-slotDuration="#cal.calendarSlotMinutes#"
                data-minTime="#cal.calendarMintime#"
                data-maxTime="#cal.calendarMaxtime#"
                data-timeFormat="#cal.calendarTimeformat#"
                data-hiddenDays=#cal.calendarHiddenDays#
                data-weekNumbers=#returnStringFromBoolean(cal.calendarWeekNumbers)#
                data-allDaySlot=#returnStringFromBoolean(cal.calendarAllDaySlot)#
                data-allDayText="#cal.calendarAllDayText#"
                data-defaultView="#cal.calendarDefaultView#"
                data-axisFormat="#cal.calendarAxisFormat#"
                data-slotEventOverlap=#returnStringFromBoolean(cal.calendarSlotEventOverlap)#
                data-height="auto"
                data-columnFormatmonth="#cal.calendarColumnFormatMonth#"
                data-columnFormatweek="#cal.calendarColumnFormatWeek#"
                data-columnFormatday="#cal.calendarColumnFormatDay#"
                data-key="#params.key#"
        ></div>
    #panelend()#
#includePartial("eventmodal")#
</cfoutput>