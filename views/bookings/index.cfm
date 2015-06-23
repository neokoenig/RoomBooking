<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfoutput>
<!--- Main Index --->
#includePartial(partial="locations", locations=locations)#
    #panel(title="Calendar", theclass="panel-primary no-top-rounded")#
        <div id="calendar"
            data-eventsurl="#urlFor(route="getEvents", type=params.action, key=params.key, params='format=json')#"
            data-eventurl="#urlFor(controller='eventdata', action='getevent')#"
            data-addurl="#urlFor(controller='bookings', action='add')#"
            data-urlrewriting="#get('urlrewriting')#"></div>

        <div id="settings"
                data-headerleft="#application.rbs.setting.calendarHeaderleft#"
                data-headercenter="#application.rbs.setting.calendarHeadercenter#"
                data-headerright="#application.rbs.setting.calendarHeaderright#"
                data-weekends=#returnStringFromBoolean(application.rbs.setting.calendarWeekends)#
                data-firstDay=#application.rbs.setting.calendarFirstday#
                data-slotDuration="#application.rbs.setting.calendarSlotMinutes#"
                data-minTime="#application.rbs.setting.calendarMintime#"
                data-maxTime="#application.rbs.setting.calendarMaxtime#"
                data-timeFormat="#application.rbs.setting.calendarTimeformat#"
                data-hiddenDays=#application.rbs.setting.calendarHiddenDays#
                data-weekNumbers=#returnStringFromBoolean(application.rbs.setting.calendarWeekNumbers)#
                data-allDaySlot=#returnStringFromBoolean(application.rbs.setting.calendarAllDaySlot)#
                data-allDayText="#application.rbs.setting.calendarAllDayText#"
                data-defaultView="#application.rbs.setting.calendarDefaultView#"
                data-axisFormat="#application.rbs.setting.calendarAxisFormat#"
                data-slotEventOverlap=#returnStringFromBoolean(application.rbs.setting.calendarSlotEventOverlap)#
                data-height="auto"
                data-columnFormatmonth="#application.rbs.setting.calendarColumnFormatMonth#"
                data-columnFormatweek="#application.rbs.setting.calendarColumnFormatWeek#"
                data-columnFormatday="#application.rbs.setting.calendarColumnFormatDay#"
                data-key="#params.key#"
        ></div>
    #panelend()#
#includePartial("eventmodal")#
</cfoutput>