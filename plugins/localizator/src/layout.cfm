<!DOCTYPE html>
	<head>
		<meta charset="utf-8">
		<title><cfoutput>#capitalize(loc.config.settings.plugin.name)# #loc.config.settings.plugin.version#</cfoutput></title>
		
		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
		<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
		
		<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">

		<script language="javascript" type="text/javascript">
	        $(function() {
	        	$('style:first').remove();
	        });
	    </script>
		
		<style>
			#logo {display:none;}
			.logo-corner {float:right; margin:10px;}
			.pad {padding:20px; border:1px solid #ddd; border-top:none;}
			ul.list-custom {padding-left:20px;}
			.list-custom li {margin-bottom:6px;}
			.list-custom li .well {margin-top:20px;}
			.alert-sm {padding:8px;}
		</style>

		<cfinclude template="js.cfm">
	</head>
	
	<body>
		<cfoutput>
			<div class="container">
				<img alt="CFWheels" height="121" src="http://www.cfwheels.org/images/cfwheels-logo.png" width="93" class="logo-corner">

				<div class="jumbotron" style="padding-top:10px; padding-bottom:20px;">
					<h1>#capitalize(loc.config.settings.plugin.name)# #loc.config.settings.plugin.version#</h1>
					
					<p>This plugin offer a complete solution to add localization (translation) capabilities to your application.</p>
					
					<h2>Benefits of using this plugin:</h2>
					
					<ul class="small">
						<li>Get text translation from a localization database or localization file(s).</li>
						<li>Populate your localization database or localization file(s) by "harvesting" the text of your application.</li>
						<li>Use the editor to add translation to your localization database and localization file(s).</li>
						<li>Generate localization file(s) from your localization database.</li>
					</ul>
				</div>
				
				<a id="generate" style="margin:0; padding:0;"></a>
				
				<div class="row">
					<cfif isDefined("loc.message.generator")>
						<div>&nbsp;</div>
						<div class="span12">
							<div class="alert alert-success" style="text-align:center;">#loc.message.generator#</div>
						</div>
					</cfif>

					<div class="col-sm-8">
						<h1>Plugin usage</h1>
						
						<ul class="nav nav-tabs" role="tablist">
							<li class="active"><a href="##Settings" data-toggle="tab">Settings</a></li>
							<li><a href="##Translator" data-toggle="tab">Translator</a></li>
							<li><a href="##Harvester" data-toggle="tab">Harvester</a></li>
							<li><a href="##Editor" data-toggle="tab">Editor</a></li>
							<li><a href="##Generator" data-toggle="tab">Generator</a></li>
							<li><a href="##Functions" data-toggle="tab">Functions</a></li>
							<li><a href="##Log" data-toggle="tab">Change Log</a></li>
							<li><a href="##Credits" data-toggle="tab">Credits</a></li>
						</ul>
						
						<div class="tab-content">
							<cfinclude template="tabs/settings.cfm">
							<cfinclude template="tabs/translator.cfm">
							<cfinclude template="tabs/harvester.cfm">
							<cfinclude template="tabs/editor.cfm">
							<cfinclude template="tabs/generator.cfm">
							<cfinclude template="tabs/functions.cfm">
							<cfinclude template="tabs/log.cfm">
							<cfinclude template="tabs/credits.cfm">
						</div>
					</div>
					
					<div class="col-sm-4">
						<h1>&nbsp;</h1>
						
						<ul class="nav nav-tabs" id="subtabs">

							<li class="#loc.config.settings.isDB EQ true ? 'active' : ''#"><a href="##Database" data-toggle="tab">Localization database</a></li>
							<li class="#loc.config.settings.isDB NEQ true ? 'active' : ''#"><a href="##Files" data-toggle="tab">Localization files</a></li>
						</ul>
						
						<div class="tab-content" id="subcontent">
							<cfinclude template="tabs/database.cfm">
							<cfinclude template="tabs/files.cfm">
						</div>
					</div>
				</div>
				
				<a id="edit"></a>
				
				<cfif flashKeyExists("message")>
					<div>&nbsp;</div>
					<div class="alert alert-#flash('messageType')#" style="text-align:center;">
						#flash("message")#
					</div>
				</cfif>
				
				<div class="row">
					<cfif !loc.fromFile && loc.config.settings.isDB>
						<cfinclude template="forms/database.cfm">
					<cfelse>
						<cfinclude template="forms/files.cfm">
					</cfif>
				</div>
			</div>
		</cfoutput>
	</body>
</html>