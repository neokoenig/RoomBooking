<!-- Log Filter -->

<cfparam name="logfiles">
<cfparam name="logfiletypes">
<cfparam name="users">
<cfoutput>
#startFormTag(method="get")#

	<div class=" well well-small">
	<div class="col-md-2">
	#selectTag(name="type",    placeholder="Type", 	options=logfiletypes,   	includeBlank=true,   prepend="", append="", appendToLabel="", prependToLabel="", selected=params.type)#
	</div>
	<div class="col-md-2">

	#selectTag(name="userid",  	options=users, 	valueField="id",  textField="email",	includeBlank=true,   prepend="", append="", appendToLabel="", prependToLabel="", selected=params.userid)#
	</div>
	<div class="col-md-2">

	#selectTag(name="rows",   	options="50,100,250,500,1000,5000",  prepend="", append="", appendToLabel="", prependToLabel="", selected=params.rows)#
	</div>
	<div class="btn-group">
		#submitTag(value="Filter")#
		#linkTo(text="Reset", class="btn btn-warning", action="index")#
	</div>
	</div>

#endFormTag()#
</cfoutput>