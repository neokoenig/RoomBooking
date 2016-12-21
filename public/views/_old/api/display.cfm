<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Display board --->
<cfparam name="events">
<cfparam name="isToday" default="false">
<cfparam name="isSingleLocation" default="false">
<cfoutput>
  <div class="display-bg">
    <div class="display-header">
      <cfif isToday>
        <h1>#l("Today")#</h1>
      <cfelse>
        <h1>#l("Upcoming Events")#:</h1>
      </cfif>
      <cfif isSingleLocation && arraylen(events)>
        <h2>#events[1]['locationname']#</h2>
      </cfif>
    </div>
  <cfif !arraylen(events)>
      <h1>#l("No Events")#</h1>
  <cfelse>
       <table class="table display-board">
         <thead>
           <tr>
             <th>#l("Time")#</th>
             <th>#l("Details")#</th>
           </tr>
         </thead>
         <tbody>
          <cfloop from="1" to="#arraylen(events)#" index="i">
          <cfoutput>
            <tr>
             <td><cfif !params.today>
               <cfif LSdateFormat(events[i]['start'], "dd mmm") EQ LSdateFormat(now(), "dd mmm")>
                  #l("Today")#
                 <Cfelse>
                  #LSdateFormat(events[i]['start'], "dd mmm")#
               </cfif>
             </cfif>#LStimeFormat(events[i]['start'], "h:MM tt")#<br /><span class="duration"><cfif events[i]['allday']>
             (#l("All Day")#)
               <cfelse>
                #_durationString(DateDiff("n", events[i]['start'], events[i]['end']))#
             </cfif></span></td>
             <td>#events[i]['title']#<br /><span class="location">#events[i]['name']# (#events[i]['locationdescription']#)</small></span></td>
           </tr>
         </cfoutput>
        </cfloop>
         </tbody>
       </table>
      </div>
    </div>
  </cfif>
  </div>
</cfoutput>
