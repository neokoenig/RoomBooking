<cfcomponent extends="Base">

	<cffunction name="init" returntype="Migration" access="public">
		<cfscript>
			var dbType = $getDBType();
			if(dbType == '') {
				$throw(type="Plugins.dbmigrate.DatabaseNotSupported", message="#dbType# is not supported by DBMigrate plugin.", extendedInfo="Use Microsoft SQL Server, MySQL, Oracle, SQLite or PostgreSQL.");
			} else {
				this.adapter = CreateObject("component","adapters.#dbType#");
			}
		</cfscript>
		<cfreturn this>
	</cffunction>

	<cffunction name="up" returntype="void" access="public" hint="migrates up">
		<cfscript>
			announce("UP MIGRATION NOT IMPLEMENTED");
		</cfscript>
	</cffunction>
	
	<cffunction name="down" returntype="void" access="public" hint="migrates down">
		<cfscript>
			announce("DOWN MIGRATION NOT IMPLEMENTED");
		</cfscript>
	</cffunction>
	
	<cffunction name="createTable" returntype="TableDefinition" access="public" hint="creates a table definition object to store table properties">
		<cfargument name="name" type="string" required="true" hint="table name in pluralized form">
		<cfargument name="force" type="boolean" required="false" default="false" hint="whether or not to drop table of same name before creating new one">
		<cfargument name="id" type="boolean" required="false" default="true" hint="if false, defines a table with no primary key">
		<cfargument name="primaryKey" type="string" required="false" default="id" hint="overrides default primary key name">
		<cfscript>
			arguments.adapter = this.adapter;
		</cfscript>
		<cfreturn CreateObject("component","TableDefinition").init(argumentCollection=arguments)>
	</cffunction>
	
	<cffunction name="changeTable" returntype="TableDefinition" access="public" hint="creates a table definition object to store modifications to table properties">
		<cfargument name="name" type="string" required="true" hint="table name in pluralized form">
		<cfreturn CreateObject("component","TableDefinition").init(adapter=this.adapter,name=arguments.name)>
	</cffunction>

	<cffunction name="renameTable" returntype="void" access="public" hint="renames a table">
		<cfargument name="oldName" type="string" required="true" hint="existing table name">
		<cfargument name="newName" type="string" required="true" hint="new table name">
		<cfscript>
			$execute(this.adapter.renameTable(argumentCollection=arguments));
			announce("Renamed table #arguments.oldName# to #arguments.newName#");
		</cfscript>
	</cffunction>

	<cffunction name="dropTable" returntype="void" access="public" hint="drops a table from the database">
		<cfargument name="name" type="string" required="true" hint="table name">
		<cfscript>
    	var loc = {};
    	if (application.wheels.serverName != "railo")
    	{
				loc.foreignKeys = $getForeignKeys(arguments.name);
				loc.iEnd = ListLen(loc.foreignKeys);
    		for (loc.i=1; loc.i <= loc.iEnd; loc.i++) {
    			loc.foreignKeyName = ListGetAt(loc.foreignKeys,loc.i);
    			dropForeignKey(table=arguments.name,keyname=loc.foreignKeyName);
    		}
    	}
	    $execute(this.adapter.dropTable(name=arguments.name));
	    announce("Dropped table #arguments.name#");
		</cfscript>
	</cffunction>
	
	<cffunction name="addColumn" returntype="void" access="public" hint="adds a column to existing table">
		<cfargument name="table" type="string" required="true" hint="table name">
		<cfargument name="columnType" type="string" required="true" hint="column type">
		<cfargument name="afterColumn" type="string" required="false" default="" />
		<cfargument name="columnName" type="string" required="false" default="" hint="column name">
		<cfargument name="referenceName" type="string" required="false" default="" hint="reference name">
		<cfargument name="default" type="string" required="false" hint="default value">
		<cfargument name="null" type="boolean" required="false" hint="whether nulls are allowed">
		<cfargument name="limit" type="numeric" required="false" hint="character or integer size limit">
		<cfargument name="precision" type="numeric" required="false" hint="number of digits the column can hold">
		<cfargument name="scale" type="numeric" required="false" hint="number of digits that can be placed to the right of the decimal point (must be less than or equal to precision)">
		<cfscript>
			arguments.addColumns = true;
			changeColumn(argumentCollection=arguments);
		</cfscript>
	</cffunction>

	<cffunction name="changeColumn" returntype="void" access="public" hint="changes a column definition">
		<cfargument name="table" type="string" required="true" hint="table name">
		<cfargument name="columnName" type="string" required="true" hint="column name">
		<cfargument name="columnType" type="string" required="true" hint="column type">
		<cfargument name="afterColumn" type="string" required="false" default="" />
		<cfargument name="referenceName" type="string" required="false" default="" hint="reference name">
		<cfargument name="default" type="string" required="false" hint="default value">
		<cfargument name="null" type="boolean" required="false" hint="whether nulls are allowed">
		<cfargument name="limit" type="numeric" required="false" hint="character or integer size limit">
		<cfargument name="precision" type="numeric" required="false" hint="number of digits the column can hold">
		<cfargument name="scale" type="numeric" required="false" hint="number of digits that can be placed to the right of the decimal point (must be less than or equal to precision)">
		<cfargument name="addColumns" type="boolean" required="false" default="false" hint="whether to add new columns or change existing columns">
		<cfscript>
			var t = changeTable(arguments.table);
			if(arguments.columnType == "reference") {
				arguments.columnType = "references";
				arguments.referenceNames = arguments.referenceName;
			} else {
				arguments.columnNames = arguments.columnName;
			}
			Evaluate("t.#arguments.columnType#(argumentCollection=arguments)");
			t.change(addColumns=arguments.addColumns);
		</cfscript>
	</cffunction>
	
	<cffunction name="renameColumn" returntype="void" access="public" hint="renames a table column">
		<cfargument name="table" type="string" required="true" hint="table name">
		<cfargument name="columnName" type="string" required="true" hint="old column name">
		<cfargument name="newColumnName" type="string" required="true" hint="new column name">
		<cfscript>
			$execute(this.adapter.renameColumnInTable(name=arguments.table,columnName=arguments.columnName,newColumnName=arguments.newColumnName));
			announce("Renamed column #arguments.columnName# to #arguments.newColumnName# in table #arguments.table#");
		</cfscript>
	</cffunction>
	
	<cffunction name="removeColumn" returntype="void" access="public" hint="removes a column from a database table">
		<cfargument name="table" type="string" required="true" hint="table name">
		<cfargument name="columnName" type="string" required="false" default="" hint="column name to remove">
		<cfargument name="referenceName" type="string" required="false" default="" hint="reference to column to remove">
		<cfscript>
			if(arguments.referenceName != "") {
				arguments.columnName = arguments.referenceName & "id";
			}
			$execute(this.adapter.dropColumnFromTable(name=arguments.table,columnName=arguments.columnName));
			announce("Removed column #arguments.columnName# from #arguments.table#");
		</cfscript>
	</cffunction>
	
	<cffunction name="addReference" returntype="void" access="public" hint="add a foreign key constraint to the database, using the reference name that was used to create it">
		<cfargument name="table" type="string" required="true" hint="table name">
		<cfargument name="referenceName" type="string" required="true" hint="reference name that was provided to table.reference()">
		<cfscript>
			addForeignKey(table=arguments.table, referenceTable=pluralize(arguments.referenceName), column="#arguments.referenceName#id", referenceColumn="id");
		</cfscript>
	</cffunction>
	
	<cffunction name="addForeignKey" returntype="void" access="public" hint="add a foreign key constraint to the database, using the reference name that was used to create it">
		<cfargument name="table" type="string" required="true" hint="table name">
		<cfargument name="referenceTable" type="string" required="true" hint="reference table name">
		<cfargument name="column" type="string" required="true" hint="column name">
		<cfargument name="referenceColumn" type="string" required="true" hint="reference column name">
		<cfscript>
			var foreignKey = CreateObject("component","ForeignKeyDefinition").init(adapter=this.adapter, argumentCollection=arguments);
			$execute(this.adapter.addForeignKeyToTable(name=arguments.table, foreignKey=foreignKey));
			announce("Added foreign key #foreignKey.name#");
		</cfscript>
	</cffunction>

	<cffunction name="dropReference" returntype="void" access="public" hint="drop a foreign key constraint from the database, using the reference name that was used to create it">
		<cfargument name="table" type="string" required="true" hint="table name">
		<cfargument name="referenceName" type="string" required="true" hint="reference name that was provided to table.reference()">
		<cfscript>
			dropForeignKey(arguments.table,"FK_#arguments.table#_#pluralize(arguments.referenceName)#");
		</cfscript>
	</cffunction>
	
	<cffunction name="dropForeignKey" returntype="void" access="public" hint="drops a foreign key constraint from the database">
		<cfargument name="table" type="string" required="true" hint="table name">
		<cfargument name="keyName" type="string" required="true" hint="foreign key name">
		<cfscript>
			$execute(this.adapter.dropForeignKeyFromTable(name=arguments.table,keyName=arguments.keyName));
			announce("Dropped foreign key #arguments.keyName#");
		</cfscript>
	</cffunction>

	<cffunction name="addIndex" returntype="void" access="public" hint="add database index on a table column">
		<cfargument name="table" type="string" required="true" hint="table name">
		<cfargument name="columnNames" type="string" required="true" hint="column names to index">
		<cfargument name="unique" type="boolean" required="false" default="false" hint="create unique index">
		<cfargument name="indexName" type="string" required="false" default="#LCase(arguments.table)#_#ListFirst(arguments.columnNames)#" hint="override the default index name">
		<cfscript>
			$execute(this.adapter.addIndex(argumentCollection=arguments));
			announce("Added index to column(s) #arguments.columnNames# in table #arguments.table#");
		</cfscript>
	</cffunction>
	
	<cffunction name="removeIndex" returntype="void" access="public" hint="remove a database index">
		<cfargument name="table" type="string" required="true" hint="table name">
		<cfargument name="indexName" type="string" required="true" hint="index name">
		<cfscript>
			$execute(this.adapter.removeIndex(argumentCollection=arguments));
			announce("Removed index #arguments.indexName# from table #arguments.table#");
		</cfscript>
	</cffunction>

	<cffunction name="execute" returntype="void" access="public" hint="executes a raw sql query">
		<cfargument name="sql" type="string" required="true">
		<cfscript>
			$execute(arguments.sql);
			announce("Executed SQL: #arguments.sql#");
		</cfscript>
	</cffunction>

	<cffunction name="addRecord" returntype="void" access="public" hint="adds a record to a table">
		<cfargument name="table" type="string" required="true" hint="table name">
		<cfscript>
			var loc = {};
			loc.columnNames = "";
			loc.columnValues = "";
			for (loc.key in arguments) {
				if(loc.key neq "table") {
					loc.columnNames = ListAppend(loc.columnNames,this.adapter.quoteColumnName(loc.key));
					if(IsNumeric(arguments[loc.key])) {
						loc.columnValues = ListAppend(loc.columnValues,arguments[loc.key]);
					} else if(IsBoolean(arguments[loc.key])) {
						loc.columnValues = ListAppend(loc.columnValues,IIf(arguments[loc.key],1,0));
					} else if(IsDate(arguments[loc.key])) {
						loc.columnValues = ListAppend(loc.columnValues,"#arguments[loc.key]#");
					} else {
						loc.columnValues = ListAppend(loc.columnValues,"'#ReplaceNoCase(arguments[loc.key],"'","''","all")#'");
					}
				}
			}
			if(loc.columnNames != '') {
				if(ListContainsNoCase(loc.columnnames, "[id]")) {
					$execute(this.adapter.addRecordPrefix(arguments.table));
				}
				$execute("INSERT INTO #this.adapter.quoteTableName(LCase(arguments.table))# ( #loc.columnNames# ) VALUES ( #loc.columnValues# )");
				if(ListContainsNoCase(loc.columnnames, "[id]")) {
					$execute(this.adapter.addRecordSuffix(arguments.table));
				}
				announce("Added record to table #arguments.table#");
			}
		</cfscript>
	</cffunction>

	<cffunction name="updateRecord" returntype="void" access="public" hint="updates an existing record in a table">
		<cfargument name="table" type="string" required="true" hint="table name">
		<cfargument name="where" type="string" required="false" default="" hint="where condition">
		<cfscript>
			var loc = {};
			loc.columnUpdates = "";
			for (loc.key in arguments) {
				if(loc.key neq "table" && loc.key neq "where") {
					loc.update = "#this.adapter.quoteColumnName(loc.key)# = ";
					if(IsNumeric(arguments[loc.key])) {
						loc.update = loc.update & "#arguments[loc.key]#";
					} else if(IsBoolean(arguments[loc.key])) {
						loc.update = loc.update & "#IIf(arguments[loc.key],1,0)#";
					} else if(IsDate(arguments[loc.key])) {
						loc.update = loc.update & "#arguments[loc.key]#";
					} else {
						arguments[loc.key] = ReplaceNoCase(arguments[loc.key], "'", "''", "all");
						loc.update = loc.update & "'#arguments[loc.key]#'";
					}
					loc.columnUpdates = ListAppend(loc.columnUpdates,loc.update);
				}
			}
			if(loc.columnUpdates != '') {
				loc.sql = 'UPDATE #this.adapter.quoteTableName(LCase(arguments.table))# SET #loc.columnUpdates#';
				loc.message = 'Updated record(s) in table #arguments.table#';
				if(arguments.where != '') {
					loc.sql = loc.sql & ' WHERE #arguments.where#';
					loc.message = loc.message & ' where #arguments.where#';
				}
				$execute(loc.sql);
				announce(loc.message);
			}
		</cfscript>
	</cffunction>

	<cffunction name="removeRecord" returntype="void" access="public" hint="removes existing records from a table">
		<cfargument name="table" type="string" required="true" hint="table name">
		<cfargument name="where" type="string" required="false" default="" hint="where condition">
		<cfscript>
			var loc = {};
			loc.sql = 'DELETE FROM #this.adapter.quoteTableName(LCase(arguments.table))#';
			loc.message = 'Removed record(s) from table #arguments.table#';
			if(arguments.where != '') {
				loc.sql = loc.sql & ' WHERE #arguments.where#';
				loc.message = loc.message & ' where #arguments.where#';
			}
			$execute(loc.sql);
			announce(loc.message);
		</cfscript>
	</cffunction>

</cfcomponent>