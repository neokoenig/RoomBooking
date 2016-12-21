<cfcomponent extends="Base">
	
	<cffunction name="init" returntype="ColumnDefinition" access="public">
		<cfargument name="adapter" type="any" required="yes" hint="database adapter">
		<cfargument name="name" type="string" required="yes" hint="column name">
		<cfargument name="type" type="string" required="yes" hint="column type">
		<cfscript>
		var loc = {};
		loc.args = "adapter,name,type,limit,precision,scale,default,null,autoIncrement,afterColumn";
		loc.iEnd = ListLen(loc.args);
		for (loc.i=1; loc.i <= loc.iEnd; loc.i++) {
			loc.argumentName = ListGetAt(loc.args,loc.i);
			if(StructKeyExists(arguments,loc.argumentName)) {
				this[loc.argumentName] = arguments[loc.argumentName];
			}
		}
		</cfscript>
		<cfreturn this>
	</cffunction>

	<cffunction name="toSQL" returntype="string" access="public">
		<cfscript>
		var sql = this.adapter.quoteColumnName(this.name) & " " & sqlType();
		sql = addColumnOptions(sql);
		</cfscript>
		<cfreturn sql>
	</cffunction>

	<cffunction name="toColumnNameSQL" returntype="string" access="public">
		<cfscript>
		var sql = this.adapter.quoteColumnName(this.name);
		</cfscript>
		<cfreturn sql>
	</cffunction>
    
    <cffunction name="toPrimaryKeySQL" returntype="string" access="public">
		<cfscript>
		var sql = this.adapter.quoteColumnName(this.name) & " " & sqlType();
		sql = addPrimaryKeyOptions(sql);
		</cfscript>
		<cfreturn sql>
    </cffunction>
	
	<cffunction name="sqlType" returntype="string" access="public">
		<cfscript>
		var loc = {};
		loc.options = {};
		loc.optionalArguments = "limit,precision,scale";
		loc.iEnd = ListLen(loc.optionalArguments);
		for (loc.i=1; loc.i <= loc.iEnd; loc.i++) {
			loc.argumentName = ListGetAt(loc.optionalArguments,loc.i);
			if(StructKeyExists(this,loc.argumentName)) {
				loc.options[loc.argumentName] = this[loc.argumentName];
			}
		}
		loc.sql = this.adapter.typeToSQL(type=this.type,options=loc.options);
		</cfscript>
		<cfreturn loc.sql>
	</cffunction>
	
	<cffunction name="addColumnOptions" returntype="string" access="public">
		<cfargument name="sql" type="string" required="yes" hint="column definition sql">
		<cfscript>
		var loc = {};
		loc.options = {};
		loc.optionalArguments = "type,default,null,afterColumn";
		loc.iEnd = ListLen(loc.optionalArguments);
		for (loc.i=1; loc.i <= loc.iEnd; loc.i++) {
			loc.argumentName = ListGetAt(loc.optionalArguments,loc.i);
			if(StructKeyExists(this,loc.argumentName)) {
				loc.options[loc.argumentName] = this[loc.argumentName];
			}
		}
		arguments.sql = this.adapter.addColumnOptions(sql=arguments.sql,options=loc.options);
		</cfscript>
		<cfreturn arguments.sql>
	</cffunction>
	
	<cffunction name="addPrimaryKeyOptions" returntype="string" access="public">
		<cfargument name="sql" type="string" required="yes" hint="column definition sql">
		<cfscript>
		var loc = {};
		loc.options = {};
		loc.optionalArguments = "autoIncrement,null";
		loc.iEnd = ListLen(loc.optionalArguments);
		for (loc.i=1; loc.i <= loc.iEnd; loc.i++) {
			loc.argumentName = ListGetAt(loc.optionalArguments,loc.i);
			if(StructKeyExists(this,loc.argumentName)) {
				loc.options[loc.argumentName] = this[loc.argumentName];
			}
		}
		arguments.sql = this.adapter.addPrimaryKeyOptions(sql=arguments.sql,options=loc.options);
		</cfscript>
		<cfreturn arguments.sql>
	</cffunction>

</cfcomponent>