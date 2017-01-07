<cfparam name="allusers">
<cfoutput>
#box(title=l("Owner"))#
	<div class="row">
		<div class="col-md-4 ">
			#select(objectname=arguments.objectname, property="userid", label=l("Owner"), valueField="id", textField="fullname", options=allusers, includeBlank=l("No Specific Owner"))#
		</div>
	</div>
#boxEnd()#
</cfoutput>
