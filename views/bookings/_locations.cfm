<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfoutput><cfparam name="params.key" default="">

<cfif application.rbs.setting.showlocationcolours> 
<style>
<cfloop query="locations"><cfif len(colour)>.#class# {background: #colour#; border-color: #colour#;}</cfif>
</cfloop>
</style>
</cfif>
<cfif application.rbs.setting.showlocationfilter> 
<div class="btn-group append"> 
#linkTo(action="index",  class="btn btn-primary btn-sm location-filter", text="All<br /><small>Show All</small>")#
<cfloop query="locations">
<cfif id EQ params.key>  
        #linkTo(action="index", key=id, class="active btn btn-sm location-filter #class# location#id#", text="#name#<br /><small>#description#</small>")#
<Cfelse>  
        #linkTo(action="index", key=id, class="btn btn-sm location-filter btn-default #class# location#id#", text="#name#<br /><small>#description#</small>")#
</cfif>
</cfloop>
</div> 
</cfif>
</cfoutput>