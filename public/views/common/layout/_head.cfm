<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfoutput>
<!DOCTYPE html>
<html lang="#request.lang.currentCode#">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title><cfif structKeyExists(request, "pagetitle")>#request.pagetitle#</cfif></title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!--- If not in production mode, load non min sources --->
  <cfif get("environment") EQ "production">
    #stylesheetlinkTag("cms.min")#
  <cfelse>
    #stylesheetlinkTag("cms")#
  </cfif>
    #stylesheetlinkTag("skins/#application.rbs.settings.theme_skin#.min,custom")#
  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
  #csrfMetaTags()#
</head>
<body class="#request.bodyClass#">
<cfif structKeyExists(request, "debug")><cfdump var="#request.debug#"></cfif>
<div class="wrapper">
</cfoutput>
