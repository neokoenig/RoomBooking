<!--- we include wheels global functions for:-
	pluralize
	model
	$dbinfo
	 --->
<cfif not StructKeyExists(variables, "$wddx")>
	<cfinclude template="../../wheels/global/functions.cfm">
</cfif>

<cffunction name="announce" access="public">
	<cfargument name="message" type="string" required="yes">
	<cfparam name="Request.migrationOutput" default="">
	<cfset Request.migrationOutput = Request.migrationOutput & arguments.message & chr(13)>
</cffunction>

<cffunction name="$execute" access="private">
	<cfargument name="sql" type="string" required="yes">
	<!--- trim and remove trailing semicolon (appears to cause problems for Oracle thin client JDBC driver) --->
	<cfset arguments.sql = REReplace(trim(arguments.sql),";$","","ONE")>
	<cfif StructKeyExists(Request, "migrationSQLFile")>
		<cffile action="append" file="#Request.migrationSQLFile#" output="#arguments.sql#;" addNewLine="yes" fixNewLine="yes">
	</cfif>
	<cfquery datasource="#application.wheels.dataSourceName#" username="#application.wheels.dataSourceUserName#" password="#application.wheels.dataSourcePassword#">
	#PreserveSingleQuotes(arguments.sql)#
	</cfquery>
</cffunction>

<cffunction name="$getDBType" returntype="string" access="private" output="false">
	<cfscript>
	var loc = {};
	loc.info = $dbinfo(type="version",datasource=application.wheels.dataSourceName,username=application.wheels.dataSourceUserName,password=application.wheels.dataSourcePassword);
	if (loc.info.driver_name Contains "SQLServer" || loc.info.driver_name Contains "Microsoft SQL Server" || loc.info.driver_name Contains "MS SQL Server" || loc.info.database_productname Contains "Microsoft SQL Server")
		loc.adapterName = "MicrosoftSQLServer";
	else if (loc.info.driver_name Contains "MySQL")
		loc.adapterName = "MySQL";
	else if (loc.info.driver_name Contains "Oracle")
		loc.adapterName = "Oracle";
	else if (loc.info.driver_name Contains "PostgreSQL")
		loc.adapterName = "PostgreSQL";
	else if (loc.info.driver_name Contains "SQLite")
			loc.adapterName = "SQLite";
	else {
		loc.adapterName = "";
	}
	</cfscript>
	<cfreturn loc.adapterName>
</cffunction>

<cffunction name="$getForeignKeys" returntype="string" access="private" output="false">
	<cfargument name="table" type="string" required="yes">
	<cfscript>
	var loc = {};
	loc.foreignKeys = $dbinfo(type="foreignkeys",table=arguments.table,datasource=application.wheels.dataSourceName,username=application.wheels.dataSourceUserName,password=application.wheels.dataSourcePassword);
	loc.foreignKeyList = ValueList(loc.foreignKeys.FKCOLUMN_NAME);
	</cfscript>
	<cfreturn loc.foreignKeyList>
</cffunction>

<cffunction name="$getColumns" returntype="string" access="public" output="false">
	<cfargument name="tableName" type="string" required="yes" hint="table name">
	<cfset var loc = {}>
  	<cfif $getDBType() eq "Oracle">
  		<!--- oracle thin client jdbc throws error when usgin cfdbinfo to access column data --->
  		<!--- because of this error wheels can't load models anyway so maybe we don't need to support this driver --->
  		<cfquery name="loc.columns" datasource="#application.wheels.dataSourceName#" username="#application.wheels.dataSourceUserName#" password="#application.wheels.dataSourcePassword#">
  		SELECT COLUMN_NAME FROM ALL_TAB_COLUMNS WHERE TABLE_NAME = '#this.name#'
  		</cfquery>
  	<cfelse>
  		<!--- use cfdbinfo --->
  		<cfset loc.columns = $dbinfo(type="columns",table=arguments.tableName,datasource=application.wheels.dataSourceName,username=application.wheels.dataSourceUserName,password=application.wheels.dataSourcePassword)>
  	</cfif>
	<cfreturn ValueList(loc.columns.COLUMN_NAME)>
</cffunction>

<cffunction name="$getColumnDefinition" returntype="string" access="private">
	<cfargument name="tableName" type="string" required="yes" hint="table name">
	<cfargument name="columnName" type="string" required="yes" hint="column name">
	<cfset var loc = {}>
	<cfdbinfo name="loc.columns" type="columns" table="#arguments.tableName#" datasource="#application.wheels.dataSourceName#" username="#application.wheels.dataSourceUserName#" password="#application.wheels.dataSourcePassword#">
    <!--- <cfdump var="#loc#" abort> --->
	<cfscript>
	loc.columnDefinition = "";
	loc.iEnd = loc.columns.RecordCount;
	for (loc.i=1; loc.i <= loc.iEnd; loc.i++) {
		if(loc.columns["COLUMN_NAME"][loc.i] == arguments.columnName) {
			loc.columnType = loc.columns["TYPE_NAME"][loc.i];
			loc.columnDefinition = loc.columnType;
			if(ListFindNoCase("char,varchar,int,bigint,smallint,tinyint,binary,varbinary",loc.columnType)) {
				loc.columnDefinition = loc.columnDefinition & "(#loc.columns["COLUMN_SIZE"][loc.i]#)";
			} else if(ListFindNoCase("decimal,float,double",loc.columnType)) {
				loc.columnDefinition = loc.columnDefinition & "(#loc.columns["COLUMN_SIZE"][loc.i]#,#loc.columns["DECIMAL_DIGITS"][loc.i]#)";
			}
			if(loc.columns["IS_NULLABLE"][loc.i]) {
				loc.columnDefinition = loc.columnDefinition & " NULL";
			} else {
				loc.columnDefinition = loc.columnDefinition & " NOT NULL";
			}
			if(Len(loc.columns["COLUMN_DEFAULT_VALUE"][loc.i]) == 0) {
				loc.columnDefinition = loc.columnDefinition & " DEFAULT NULL";
			} else if(ListFindNoCase("char,varchar,binary,varbinary",loc.columnType)) {
				loc.columnDefinition = loc.columnDefinition & " DEFAULT '#loc.columns["COLUMN_DEFAULT_VALUE"][loc.i]#'";
			} else if(ListFindNoCase("int,bigint,smallint,tinyint,decimal,float,double",loc.columnType)) {
				loc.columnDefinition = loc.columnDefinition & " DEFAULT #loc.columns["COLUMN_DEFAULT_VALUE"][loc.i]#";
			}
			break;
		}
	}
	</cfscript>
	<cfreturn loc.columnDefinition>
</cffunction>
