<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Display board --->
<cfparam name="events">
<cfparam name="isToday" default="false">
<cfparam name="isSingleLocation" default="false">
<cfoutput>
  <div class="display-bg">
    <div class="display-header">
      <cfif isToday>
        <h1>Today</h1>
      <cfelse>
        <h1>Upcoming Events:</h1>
      </cfif>
      <cfif isSingleLocation>
        <h2>#events.name#</h2>
      </cfif>
    </div>
  <cfif !events.recordcount>
      <h1>No Events</h1>
  <cfelse>
       <table class="table display-board">
         <thead>
           <tr>
             <th>Time</th>
             <th>Details</th>
           </tr>
         </thead>
         <tbody>
          <cfloop query="events">
          <cfoutput>
            <tr>
             <td><cfif !params.today>
               <cfif dateFormat(start, "dd mmm") EQ dateFormat(now(), "dd mmm")>
                  Today
                 <Cfelse>
                  #dateFormat(start, "dd mmm")#
               </cfif>
             </cfif>#timeFormat(start, "h:MM tt")#<br /><span class="duration"><cfif allday>
             (All Day)
               <cfelse>
                #_durationString(DateDiff("n", start, end))#
             </cfif></span></td>
             <td>#title#<br /><span class="location">#name# (#description#)</small></span></td>
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
