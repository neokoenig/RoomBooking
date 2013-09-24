<cfcomponent extends="Base">
	
	<cffunction name="init" returntype="ForeignKeyDefinition" access="public">
		<cfargument name="adapter" type="any" required="yes" hint="database adapter">
		<cfargument name="table" type="string" required="yes" hint="table name">
		<cfargument name="referenceTable" type="string" required="yes" hint="referenced table name">
		<cfargument name="column" type="string" required="yes" hint="column name">
		<cfargument name="referenceColumn" type="string" required="yes" hint="referenced column name">
		<cfargument name="onUpdate" type="string" required="false" default="" hint="how you want the constraint to act on update. possible values include `none`, `null`, or `cascade` which can also be set to `true`.">
		<cfargument name="onDelete" type="string" required="false" default="" hint="how you want the constraint to act on delete. possible values include `none`, `null`, or `cascade` which can also be set to `true`.">

		<cfscript>
		var loc = {};
		loc.args = "adapter,table,referenceTable,column,referenceColumn,onUpdate,onDelete";
		loc.iEnd = ListLen(loc.args);
		for (loc.i=1; loc.i <= loc.iEnd; loc.i++) {
			loc.argumentName = ListGetAt(loc.args,loc.i);
			if(StructKeyExists(arguments,loc.argumentName)) {
				this[loc.argumentName] = arguments[loc.argumentName];
			}
		}
		this.name = "FK_#LCase(this.table)#_#LCase(this.referenceTable)#";
		</cfscript>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="toSQL" returntype="string" access="public">
		loc.args = "adapter,table,referenceTable,column,referenceColumn,onUpdate,onDelete";
	</cffunction>

</cfcomponent>
