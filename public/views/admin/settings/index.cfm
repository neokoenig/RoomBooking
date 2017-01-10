<cfparam name="settings">
<cfparam name="settingCategories">
<cfoutput>
#box(title="Your Setup:")#
	<div class="row">
		<div class="col-md-3">
			CFML engine: <code>#application.wheels.servername# #application.wheels.serverversion#</code>
		</div>
		<div class="col-md-3">
			RBS Version: <code>#application.rbs.version#</code>
		</div>
		<div class="col-md-3">
			DB Version: <code>#application.rbs.dbmigrate.current#</code>
		</div>
		<div class="col-md-3">

		</div>
	</div>
#boxEnd()#
<cfloop from="1" to="#arraylen(settingCategories)#" index="i">
#box(title=titleize(settingCategories[i]))#
<table id="settingstable#i#" class="table table-bordered table-striped">
	<thead>
	<tr>
		<th width=15%>#l("Setting")#</th>
		<th width=35%>#l("Description")#</th>
		<th width=25%>#l("Current Value")#</th>
		<th width=5%>#l("Actions")#</th>
	</tr>
	</thead>
	<tbody>
	<cfloop query="settings">
	<cfif listFirst(name, "_") EQ settingCategories[i]>
		<tr>
			<td>#titleize(listLast(name, "_"))#</td>
			<td><cfif len(docs)>#linkTo(href=docs, text=description, target="_blank")#<cfelse>#description#</cfif></td>
			<td><cfif type EQ 'boolean'>#tickorcross(value)#<cfelse><code>#value#</code></cfif></td>
			<td>#linkTo(route="editAdminSetting", key=id, text="<i class='fa fa-edit'></i> " & l("Edit"), class="btn btn-xs btn-primary")#</td>
		</tr>
	</cfif>

	</cfloop>
	</tbody>
	</table>
#boxEnd()#
</cfloop>
</cfoutput>
