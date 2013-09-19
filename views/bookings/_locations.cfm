<cfoutput>
<cfparam name="params.key" default="">
<div class="btn-group"> 
#linkTo(action="index",  class="btn btn-primary btn-md location-filter", text="All")#
<cfloop query="locations">
<cfif id EQ params.key>  
#linkTo(action="index", key=id, class="active btn btn-md location-filter #class#", text=name)#
<Cfelse>  
#linkTo(action="index", key=id, class="btn btn-md location-filter #class#", text=name)#
</cfif>
</cfloop>
</div>
<hr />
</cfoutput>