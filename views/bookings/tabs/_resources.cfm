<!--- Event Details --->
<cfoutput>
	<cfparam name="cType" default="">
 	<fieldset>
 		<legend>Bookable Resources</legend>

	<cfif resources.recordcount>
		<table id="resourceTable" class="table table-condensed table-hover">
			<tbody>
				<cfoutput query="resources">
					<tr>
					<th><cfif cType NEQ type>#type#<cfelse>&nbsp;</cfif></th>
					<td
					<cfif len(restrictlocations)>
						 data-restrict="0,#restrictlocations#"
					</cfif>
					<cfif isunique>
						 data-unique="#id#"
					</cfif>
					> #hasManyCheckbox(objectname="event", association="eventresources", label=resources.name, keys="#event.key()#,#id#")#</td>
					<td>
						<cfif len(restrictlocations)>
<button type="button" class="pop btn btn-xs btn-default" data-toggle="popover" title="Location Restricted" data-content="Selection is restricted to certain locations"><i class="glyphicon glyphicon-info-sign"></i></button>
					 </cfif>
					<cfif isunique><button type="button" class="pop btn btn-xs btn-default" data-toggle="popover" title="Unique Item or Service" data-content="Will not allow concurrent booking"><i class="glyphicon glyphicon-exclamation-sign"></i></button>
					</cfif></td>
					<td>#description# </td>
					</tr>
					<cfset cType=type>
				</cfoutput>
			</tbody>
		</table>
	<cfelse>
			<p>No bookable resources available</p>
	</cfif>
 	</fieldset>
</cfoutput>