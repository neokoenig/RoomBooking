<!---================= Room Booking System / https://github.com/neokoenig =======================--->
 <!--- settings --->
<cfparam name="settings">
<cfoutput>
#panel(title="All settings")#

<cfif settings.recordcount>

	<!--- Tabs--->
	<ul class="nav nav-tabs" id="settingstab">
	<cfloop query="settings" group="Category">
			<li class="#iif(currentrow EQ 1, '"active"', '""')#"><a href="###lcase(settings.category)#" data-toggle="tab">#settings.category#</a></li>
	</cfloop>
	</ul>

	<!--- Per Tab Output--->
	<div class="tab-content">
	<cfloop query="settings" group="Category">
	  <!--- Start Tab --->
	  <div class="tab-pane #iif(currentrow EQ 1, '"active"', '""')#" id="#lcase(settings.category)#">
		<h3>#settings.category#</h3>
		<table class="table table-condensed">
			<thead>
				<tr>
					<th>ID</th>
					<th>Current Value</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
			<cfloop>
				<tr>
					<td><strong>#h(id)#</strong><br /><small>#autolink(notes)#</small></td>
					<td><cfif fieldtype EQ "boolean">#tickorcross(value)#<cfelse><code>#h(value)#</code></cfif></td>
					<td>
						<div class="btn-group">
							<cfif editable>
								#linkTo(text="<i class='glyphicon glyphicon-edit'></i> Edit", class="btn btn-xs btn-info", action="edit", key=id)#
							</cfif>
						</div>
					</td>
				</tr>
			</cfloop>
			</tbody>
		</table>
		</div>
		<!--- End Tab--->
	</cfloop>
	</div><!--- End Tab Content--->

<cfelse>
	<p>No settings available yet</p>
</cfif>
#panelEnd()#
</cfoutput>