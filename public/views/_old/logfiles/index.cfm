<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Log file output --->
<cfoutput>
#includePartial("filter")#

<cfif logfiles.recordcount>
	<table class="table table-condensed">
		<thead>
			<tr>
				<th>#l("ID")#</th>
				<th>#l("Message")#</th>
				<th>#l("Type")#</th>
				<th>#l("Created")#</th>
				<th>#l("IP")#</th>
				<th>#l("User")#</th>
				</tr>
			</thead>
			<tbody>
				<cfloop query="logfiles">
					<cfquery dbtype="query" name="thisuser">
						SELECT id, email FROM users WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#userid#">
					</cfquery>
					<cfoutput>
					<tr>

				<td><span class="label-#lcase(Type)# label">#ID#</span></td>
				<td>#Message#</td>
				<td>#linkTo(params="type=#lcase(type)#&userid=&rows=1000", text="#Type#")#</td>
				<td>#dateFormat(CreatedAt, "dd mmm yyyy")# #timeFormat(createdAt, "HH:MM")#</td>
				<td>
					<cfif !application.rbs.setting.isdemomode>
						<a href="http://www.infosniper.net/index.php?ip_address=#IPaddress#&map_source=1&overview_map=1&lang=1&map_type=1&zoom_level=7" target="_blank">#IPaddress#</a>
					<cfelse>
						DemoIP
					</cfif></td>
				<td>
					<cfif thisuser.recordcount>
						#linkTo(params="index?type=&userid=#userid#&rows=1000", text="#thisuser.email#")#
					<cfelse>
						#linkTo(params="index?type=&userid=#userid#&rows=1000", text="Anon")#
				</cfif>
			</thd>

						</tr>
						</cfoutput>
				</cfloop>
				</tbody>
		</table>
	<Cfelse>
		<div class="alert">#l("No log files available")#</div>
</cfif></cfoutput>