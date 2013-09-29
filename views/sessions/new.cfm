<!--- Login Vars--->
<cfparam name="params.email" default="#request.cookie.username#">
<cfparam name="savedemail" default="false">

<!--- Create Vars --->  

<Cfset request.pagetitle="Sign In">
<cfif len(params.email)> 
	<cfset savedemail = true>
</cfif>
<cfoutput>
<div class="row"> 	 
	<div class="col-lg-4  col-lg-offset-4">
		#panel(title="Sign In")#
			#includePartial("signin")#
		 #panelend()#
	</div>
	 
</div> 

	 
</cfoutput>