<!--- Test--->
<cfscript>
	request.modeltype="location";
	params.key=4;
	variables["#request.modeltype#"]=model(request.modeltype).findOne(where="id = #params.key#");
	customfields=getCustomFields(objectname=request.modeltype, key=params.key);
</cfscript>
<cfsavecontent variable="template">
	<div class="row">
		<div class="col-sm-4">
			<p>One</p>
			<p>[customfield id=10]</p>
		</div>
		<div class="col-sm-4">
			<p>Two</p>
			<p>[systemfield name="name"]</p>
		</div>
		<div class="col-sm-4">
			<p>[customfield id=9]</p>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-4">
			<p>[systemfield name="description"]</p>

		</div>
		<div class="col-sm-4">
			<p>[systemfield name="colour"]</p>

		</div>
		<div class="col-sm-4">
			<p>[systemfield name="class"]</p>

		</div>
	</div>
</cfsavecontent>
<cfoutput>
#processShortCodes(template)#
</cfoutput>