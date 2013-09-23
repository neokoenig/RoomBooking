 <!--- settings --->
<cfparam name="settings">
<Cfoutput>
	

#panel(title="All settings")# 
 
<cfif settings.recordcount>
	
<table class="table table-condensed">
	<thead>
		<tr>
			<th>ID</th>
			<th>Current Value</th> 
			<th>Actions</th>
		</tr>
	</thead>
	<tbody>
	<cfloop query="settings">
		<cfoutput>
		<tr>
			<td><strong>#id#</strong><br />#autolink(notes)#</td>
			<td>#value#</td> 
			<td>
				<div class="btn-group">
					<cfif editable>
						#linkTo(text="Edit", class="btn btn-sm btn-info", action="edit", key=id)# 
					</cfif>
				</div>
			</td>
		</tr>
		</cfoutput>
	</cfloop>
		
	</tbody>
</table>
	<cfelse>
		<p>No settings available yet</p>
</cfif>
#panelEnd()#

</Cfoutput>