
<cffunction returntype="boolean" name="checkAuthKey">
	<cfif fileExists(expandPath("../config/auth.cfm"))>
		 <cfreturn true>
	<cfelse>
		 <cfreturn false>
	</cfif>
</cffunction>

<cffunction returntype="boolean" name="createAuthKey" hint="Create a new authkey">
	<cftry>
	<cffile action="write" file="#expandPath("../config/auth.cfm")#" output="#createUUID()#">
	<cfcatch type="any">
		<cfthrow message="Can't create Auth Key">
		<cfabort>
	</cfcatch>
	</cftry>
	<cfreturn true>
</cffunction>

<cffunction returntype="boolean" name="testDSN">
	<cfargument name="dsn" default="roombooking">
	<!--- Test Q--->
	<cftry>
		<cfquery datasource="#arguments.dsn#" name="testQ">
			SELECT * FROM settings;
		</cfquery>
		<cfcatch>
			<cfreturn false>
		</cfcatch>
	</cftry>
	<cfreturn true>
</cffunction>

<cffunction returntype="boolean" name="checkPrimaryAdmin">
	<cfargument name="dsn" default="roombooking">
		<cfquery datasource="#arguments.dsn#" name="userQ">
			SELECT * FROM users WHERE role = <cfqueryparam cfsqltype="cf_sql_varchar" value="admin">;
		</cfquery>
		<cfif userQ.recordcount>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
</cffunction>

<cffunction name="createInitialAdminUser">
	<cfargument name="dsn" default="roombooking">
	<cfif !len(form.email) OR !len(form.firstname) OR !len(form.lastname)>
		<cfthrow message="Please fill in all fields">
	</cfif>
	<cfif form.password NEQ form.password2>
		<cfthrow message="Passwords do not match">
	</cfif>
	<cfscript>
		form.firstname=trim(form.firstname);
		form.lastname=trim(form.lastname);
		form.email=trim(form.email);
		form.t_salt=createUUID();
		form.password=hashPassword(form.password, form.t_salt);
		form.salt=encrypt(form.t_salt, getAuthKey(), 'CFMX_COMPAT');
	</cfscript>

	<cfquery datasource="#arguments.dsn#" name="adminU">
	INSERT INTO users (
		firstname,lastname,email,salt,password,role,createdAt
	)
	VALUES (
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.firstname#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.lastname#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.email#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.salt#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.password#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="ADMIN">,
		<cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">
	);
	</cfquery>

</cffunction>

<cffunction name="getAuthKey">
	<cffile action="read" file="#expandpath("../config/auth.cfm")#" variable="authkey">
	<cfreturn authkey>
</cffunction>

<cffunction name="createSalt" hint="Create Salt using authkey">
	<cfscript>
	 return encrypt(createUUID(), getAuthKey(), 'CFMX_COMPAT');
	</cfscript>
</cffunction>

<cffunction name="hashPassword" hint="Hash Password using SHA512">
	<cfargument name="string" required="true">
	<cfargument name="salt" required="true">
	<cfscript>
	return hash(arguments.string & arguments.salt, 'SHA-512');
	</cfscript>
</cffunction>
