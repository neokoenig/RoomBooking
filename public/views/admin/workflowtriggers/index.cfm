<cfparam name="workflowtriggers">
<cfparam name="alltriggers">
<cfoutput>
#linkTo(route="adminWorkflows", text="<i class='fa fa-chevron-circle-left'></i> #l('Return to Listing')#", class="btn btn-primary btn-flat")#
<hr />
#box(title=l("Triggers"))#
<h5>#workflow.title#</h5>
<cfif workflowtriggers.recordcount>
<table id="triggerstable" class="table table-bordered table-striped table-condensed">
	<thead>
	<tr>
		<th>#l("Name")#</th>
		<th>#l("Type")#</th>
		<th>#l("On")#</th>
		<th>#l("When")#</th>
		<!---th>#l("Condition")#</th--->
		<th>#l("Do")#</th>
		<th>#l("Actions")#</th>
	</tr>
	</thead>
	<tbody>
	<cfloop query="workflowtriggers">
		<tr>
			<td>#title#</td>
			<td>#triggertype#</td>
			<td>#triggeron#</td>
			<td>#triggerwhen#</td>
			<!---td>#triggercondition#</td--->
			<td><cfloop>#actiontitle#<br /><small>#description#</small><br /></cfloop></td>
			<td>

				<cfif hasPermission("admin.workflowtriggers.delete")>
					#startFormTag(route="adminWorkflowtriggersDelete")#
						#hiddenFieldTag(name="_method", value="delete")#
						#hiddenFieldTag(name="workflowid", value=workflowid)#
						#hiddenFieldTag(name="triggerid", value=triggerid)#
						#hiddenFieldTag(name="actionid", value=actionid)#
						#buttonTag(content="<i class='fa fa-trash-o'></i>", class="btn btn-xs btn-flat btn-danger", confirm=l("Delete This Step?"))#
					#endFormTag()#
				</cfif>
			</td>
		</tr>
	</cfloop>
	</tbody>
	</table>
<cfelse>
	#alert(title="No Steps Found", content="There aren't any workflow steps yet. Maybe create some?")#
</cfif>
#boxEnd()#
<cfif hasPermission("admin.workflowtriggers.create")>
#box(title=l("Add a New Workflow Step"))#

#startFormTag(route="adminWorkflowtriggersCreate")#
		#hiddenFieldTag(name="workflowid", value=workflow.key())#
	<div class="row">
		<div class="col-md-4">
			<cfif !alltriggers.recordcount>
				<p>#alert(title=l("No triggers available"), content="Please create some triggers first")#</p>
			<cfelse>
				#selectTag(name="triggerid", options=alltriggers, label=l("Trigger"), includeBlank=l("...Select"))#
			</cfif>
		</div>
		<div class="col-md-4">
			<cfif !allactions.recordcount>
				<p>#alert(title=l("No actions available"), content="Please configure some actions")#</p>
			<cfelse>
				#selectTag(name="actionid", options=allactions, label=l("Action"), includeBlank=l("...Select"))#
			</cfif>
		</div>
		<div class="col-md-2">

			<cfif allactions.recordcount && alltriggers.recordcount>
			#submitTag(value=l("Add Step"), class="btn btn-primary pushdown")#
			<cfelse>
			#submitTag(value=l("Add Step"), class="btn btn-primary pushdown", disabled=true)#
			</cfif>
		</div>
	</div>
#endFormTag()#
</cfif>
#boxEnd()#
</cfoutput>
