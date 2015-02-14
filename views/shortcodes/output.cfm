<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Custom Field Output--->
<cfscript>
param name="attr.id"		default="";
param name="attr.formatter" default="";
param name="attr.label"		default="";
param name="attr.modeltype" default="#request.modeltype#";
param name="attr.prepend" 	default="";
param name="attr.append" 	default="";
param name="attr.value"		default="";

	// Is it a Custom or a system field?
	if(isnumeric(attr.id)){
		attr.field="custom";
			q2 = new Query();
			q2.setDBType('query');
			q2.setAttributes(rs=customfields);
			q2.addParam(name='fieldid', value=attr.id, cfsqltype='cf_sql_numeric');
			q2.setSQL('SELECT * FROM rs where id = :fieldid');
			customfieldoutput = q2.execute().getResult();
			attr.value=customfieldoutput.value;
	} else {
		attr.field="system";
		attr.value=variables[attr.modeltype][attr.id];
	}
</cfscript>

<cfoutput>
	<cfswitch expression="#attr.formatter#">
		<cfdefaultcase>
			<!--- Hide if empty--->
			<cfif len(attr.value)>
				<!--- Show label if passed in--->
				<cfif len(attr.label)>
					<strong>#h(attr.label)#:</strong>
				</cfif>
				<!--- Prepend --->
				<cfif len(attr.prepend)>
					#trim(attr.prepend)#
				</cfif>
				<!--- Format output--->
				<cfif isDate(attr.value)>
					#_formatDateTime(attr.value)#
				<cfelse>
					#trim(autolink(attr.value))#
				</cfif>
				<!--- Append --->
				<cfif len(attr.append)>
					#trim(attr.append)#
				</cfif>
			</cfif>
		</cfdefaultcase>
	</cfswitch>
</cfoutput>