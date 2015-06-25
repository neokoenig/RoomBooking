<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Custom fields index --->
<cfparam name="customfields">
<cfparam name="customtemplates">

<cfoutput>
	<!--- Custom Templates --->
	#panel(title="All Custom Templates")#

	<div class="row">
		<div class="col-sm-9">
			#startFormTag(method="GET", controller="customfields",  action="addtemplate")#
			#hiddenfieldTag(name="controller", value="customfields")#
			#hiddenfieldTag(name="action", value="addtemplate")#
			<div class="row">
				<div class="col-sm-4">
					#selectTag(name="key", options=application.rbs.modeltypes, label="Template")#
				</div>
				<div class="col-sm-4">
					#selectTag(name="type", options=application.rbs.templatetypes, label="Type")#
				</div>
				<div class="col-sm-2">
					#submitTag(class="pushdown btn btn-primary", value="Create Template")#
				</div>
			</div>
			#endFormTag()#
			<hr />

			<cfif customtemplates.recordcount>
				<table class="table">
					<thead>
						<tr>
							<th>Model</th>
							<th>Type</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						<cfloop query="customtemplates">
							<cfoutput>
								<tr>
									<td>#parentmodel#</td>
									<td>#type#</td>
									<td>
										<div class="btn-group">
											#linkTo(text="<i class='glyphicon glyphicon-edit'></i> Edit", class="btn btn-xs btn-info", action="edittemplate", params="type=#type#", key="#parentmodel#")#
											#linkTo(text="<i class='glyphicon glyphicon-trash'></i> Delete", class="btn btn-xs btn-danger", action="deletetemplate", key="#parentmodel#", params="type=#type#", confirm='Are you Sure?')#
										</div>
									</td>
								</tr>
							</cfoutput>
						</cfloop>
					</tbody>
				</table>
				<cfelse>
					<p>No Custom Templates have been added yet</p>
				</cfif>
			</div>
			<div class="col-sm-3">
				<div class="well well-small">
					<p><strong>About Custom Templates</strong></p>
					<p>You can override the standard templates for form inputs and modal outputs. Simply delete a template to revert back to the defaults.</p>
					<p>You can add both 'system' fields, (i.e, model defaults), and any custom fields entered below</p>
					<p>Remember, changes affect all instances of the model, and you will need to restart the application to see the effect</p>
				</div>
			</div>
		</div>



		#panelEnd()#
		<!--- Custom Fields --->
		#panel(title="All Custom Fields")#
		<div class="row">
			<div class="col-sm-9">


				#linkTo(Text="<i class='glyphicon glyphicon-plus'></i> Create New Custom Field", class="btn btn-primary", action="add")#
				<hr />
				<cfif customfields.recordcount>
					<table class="table">
						<thead>
							<tr>
								<th>ID</th>
								<th>Model</th>
								<th>Name</th>
								<th>Type</th>
								<th>Description</th>
								<th>Actions</th>
							</tr>
						</thead>
						<tbody>
							<cfloop query="customfields">
								<cfoutput>
									<tr>
										<td>#id#</td>
										<td>#parentmodel#</td>
										<td>#name#</td>
										<td>#type#</td>
										<td>#description#</td>
										<td>
											<div class="btn-group">
												#linkTo(text="<i class='glyphicon glyphicon-edit'></i> Edit", class="btn btn-xs btn-info", action="edit", key=id)#
												#linkTo(text="<i class='glyphicon glyphicon-trash'></i> Delete", class="btn btn-xs btn-danger", action="delete", key=id, confirm='Are you Sure?')#
											</div>
										</td>
									</tr>
								</cfoutput>
							</cfloop>
						</tbody>
					</table>
					<cfelse>
						<hr />
						<p>No Custom Fields have been added yet</p>
					</cfif>
				</div>
				<div class="col-sm-3">
					<div class="well well-small">
						<p><strong>About Custom Fields</strong></p>
						<p>You can use custom fields to collect and display data which isn't provided by the system (default) fields. Examples might include "Room Capacity" for locations, or a radio select for Dietary requirements when creating a booking.</p>
						<p>Remember, changes affect all instances of the model, and you will need to restart the application to see the effect</p>
					</div>
				</div>
			</div>
			#panelEnd()#
		</Cfoutput>