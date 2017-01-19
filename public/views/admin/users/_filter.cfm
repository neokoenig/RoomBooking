<cfoutput>
#box(title="Filter")#
#startFormTag(route="adminUsers", method="GET")#
	<div class="row">
		<div class="col-md-2">
			#selectTag(name="roleid",label=l("Role"), options=allroles, includeBlank=l("Any"), selected=params.roleid)#
		</div>
		<div class="col-md-2">
			#selectTag(name="status", selected=params.status, label=l("Account Status"), options={"active":"Active","disabled": "Disabled"}, includeBlank=l("Any"))#
		</div>
		<div class="col-md-2">
			#selectTag(name="perpage", selected=params.perpage, label=l("Records"), options="50,100,500,1000")#
		</div>
		<div class="col-md-2">
			#submitTag(value=l("Filter"), class="btn btn-primary pushdown")#
		</div>
	</div>
#endFormTag()#
#boxEnd()#
</cfoutput>
