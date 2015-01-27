<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- System Field output--->
<cfoutput>
	<cfif structKeyExists(evaluate(request.modeltype), attr.id)>
		#evaluate('#request.modeltype#.#attr.id#')#
	</cfif>
</cfoutput>
