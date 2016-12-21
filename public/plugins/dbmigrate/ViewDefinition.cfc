<cfcomponent extends="Base">
	
	<cffunction name="init" returntype="any" access="public">
		<cfargument name="adapter" type="any" required="yes" hint="database adapter">
		<cfargument name="name" type="string" required="yes" hint="table name in pluralized form">
		<cfscript>
			var loc = {};
			loc.args = "adapter,name,selectSql";
			
			this.selectSql = "";
			
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
	
	<cffunction name="selectStatement" returntype="any" access="public" hint="select statement to build view">
		<cfargument name="sql" type="string" required="yes" hint="select sql">
		<cfscript>
			this.selectSql = arguments.sql;
		</cfscript>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" returntype="void" access="public" hint="creates the table in the database">
		<cfscript>
			$execute(this.adapter.createView(name=this.name, sql=this.selectSql));
			announce("Created view #LCase(this.name)#");
		</cfscript>
	</cffunction>

</cfcomponent>