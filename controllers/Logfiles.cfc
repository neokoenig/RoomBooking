<!--- Manage Logs --->
<cfcomponent	extends="Controller"	hint="Admin Log Files etc">

<cffunction name="init">
	<cfscript>
		filters(through="checkPermissionAndRedirect", permission="accesslogfiles");  
	</cfscript>
</cffunction>

<cffunction name="index">
<cfparam name="params.type" default="">
<cfparam name="params.userid" default="">
<cfparam name="params.rows" default=250>
	<cfscript>  
		LogFileTypes=getLogFileTypes();
		
/* Bug in RC1 with using CONCAT() etc; using email until that's fixed */
		//users=model("user").findAll(select="id,CONCAT(firstname,' ', lastname) AS fullname,email", order="lastname");	 

		users=model("user").findAll(select="id,email", order="lastname");	 
		var wc = arrayNew(1);
		if(structKeyExists(params, "type") AND Len(params.type)){
			arrayAppend(wc, "type = '#params.type#'");
		}
		if(structKeyExists(params, "userid") AND len(params.userid) AND isNumeric(params.userid)){
			arrayAppend(wc, "userid = #params.userid#");
		}
		if(arrayLen(wc)){
			wc = arrayToList(wc, " AND ");
			//writeDump(wc);
			//abort;
			logfiles=model("logfiles").findAll(where="#wc#", maxrows=params.rows,  order="createdAt DESC", includeSoftDeletes=true);
		}
		else {
			logfiles=model("logfiles").findAll(maxrows=500,  maxrows=params.rows, order="createdAt DESC", includeSoftDeletes=true);
		}

	</cfscript>  
</cffunction> 
  
<cffunction name="getLogFileTypes">
	<cfreturn "login,success,error,ajax,cookie">
</cffunction>

</cfcomponent>
