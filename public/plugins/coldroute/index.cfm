<h1>ColdRoute</h1>
<h2>Route List:</h2>
<style>
	div.scroll-box {
		overflow: scroll;
		height: 600px;
	}
	
	table#route-dump {
		font-family: monospace;
	}
	
	table#route-dump th,
	table#route-dump td {
		text-align: left;
		padding: 0.1em 1em;
	}
	
	table#route-dump th.right,
	table#route-dump td.right {
		text-align: right;
	}
</style>
<cfoutput>
<div class="scroll-box">
	<table id="route-dump" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<th class="right">Name</th>
			<th>Method</th>
			<th>Pattern</th>
			<th>Controller</th>
			<th>Action</th>
		</tr>
		<cfloop array="#application.wheels.routes#" index="i">
			<tr>
				<td class="right">
					<cfif StructKeyExists(i, "name")>
						#i.name#
					</cfif>
				</td>
				<td>
					<cfif StructKeyExists(i, "methods")>
						#UCase(i.methods)#
					</cfif>
				</td>
				<td>#i.pattern#</td>
				<td>
					<cfif StructKeyExists(i, "controller")>
						#i.controller#
					</cfif>
				</td>
				<td>
					<cfif StructKeyExists(i, "action")>
						#i.action#
					</cfif>
				</td>
			</tr>
		</cfloop>
	</table>
</div>
</cfoutput>