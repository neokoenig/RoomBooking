<cfoutput>
<cfparam name="request.bodyClass" default="">
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>#application.rbs.setting.sitetitle# <cfif application.rbs.setting.isDemoMode>(Demo Mode)</cfif></title>
        <meta name="description" content="#application.rbs.setting.sitedescription#">
        <meta name="viewport" content="width=device-width, initial-scale=1">
	    <meta name="HandheldFriendly" content="true">
	    <meta name="apple-mobile-web-app-capable" content="yes">
        <cfif request.bodyClass EQ "displayBoard">
            <meta http-equiv="refresh" content="30">
        </cfif>
        #stylesheetLinkTag("rbs")#
    </head>
<body class="#request.bodyClass#">
</cfoutput>