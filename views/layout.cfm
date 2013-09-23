<cfsilent> 
  <cfset currentTheme=application.rbs.bootstraptheme>
<cfif structKeyExists(params, "theme")>
  <cfset currentTheme=h(params.theme)>
</cfif>
</cfsilent>
<cfoutput> 
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>#application.rbs.sitetitle#</title>
        <meta name="description" content="#application.rbs.sitedescription#">
        <meta name="viewport" content="width=device-width, initial-scale=1">
		    <meta name="HandheldFriendly" content="true">
		    <meta name="apple-mobile-web-app-capable" content="yes"><!-- try to forces full-screen for apple devices -->
        <!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
        <cfif application.rbs.usejavascriptfromCDN>
 		     #stylesheetLinkTag("//netdna.bootstrapcdn.com/bootswatch/3.0.0/#currentTheme#/bootstrap.min.css,//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css,//cdnjs.cloudflare.com/ajax/libs/fullcalendar/1.6.4/fullcalendar.css,smoothness/jquery-ui-1.10.3.custom.min,bootstrap-colorpicker,custom")# 
         <cfelse>
          #stylesheetLinkTag("theme,fullcalendar,smoothness/jquery-ui-1.10.3.custom.min,bootstrap-colorpicker,custom")#
         </cfif>
        #javascriptIncludeTag("modernizr-2.6.2.min")# 

<!---//cdnjs.cloudflare.com/ajax/libs/fullcalendar/1.6.4/fullcalendar.print.css--->
    </head>
    <body> 
<!-----------------------------HEADER---------------------------> 
 <div class="navbar navbar-default">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="/">
            <cfif len(application.rbs.sitelogo) GT 1>
              <img src="#application.rbs.sitelogo#" alt="Logo" class="img-responsive pull-left logo" />
            </cfif>
            <cfif len(application.rbs.sitetitle) GT 1>
              #application.rbs.sitetitle#
            </cfif></a>
        </div>
        <nav class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li>#linkTo(route="home", text="<span class='glyphicon glyphicon-calendar'></span> Calendar")#</li> 
            <li>#linkTo(controller="bookings", action="add", text="<span class='glyphicon glyphicon-plus-sign'></span> Book a Room")#</li>
          </ul>   
          <cfif application.rbs.allowSettings OR application.rbs.allowLocations OR application.rbs.allowThemes>
            
          <ul class="nav navbar-nav pull-right">
            <li class="dropdown">
            <a href="##" class="dropdown-toggle" data-toggle="dropdown"><span class='glyphicon glyphicon-cog'></span> Settings <b class="caret"></b></a>
            <ul class="dropdown-menu">  

            <cfif application.rbs.allowSettings>
               <li>#linkTo(controller="settings",  text="<span class='glyphicon glyphicon-cog'></span> Configuration")#</li>
            </cfif>

            <cfif application.rbs.allowLocations>
              <li>#linkTo(controller="locations",  text="<span class='glyphicon glyphicon-plus-sign'></span> Locations")#</li>
            </cfif>

            <cfif application.rbs.allowThemes> 
                <li role="presentation" class="divider"></li>
              <cfloop list="#application.rbs.bootstrapthemeoptions#" index="i">
                <li><a href="?theme=#h(i)#">#i#</a></li>
              </cfloop>
            </cfif>

            </li>
            </ul> 
          </cfif>
          </ul>
        </nav><!--/.nav-collapse --> 
      </div>
    </div>  


<!-----------------------------/HEADER--------------------------->  

<!-----------------------------CONTENT--------------------------->  
        <!--[if lt IE 7]>
            <p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
        <section id="main" class="container">	 
        <cfif structKeyExists(params, "theme")>
          <div class="alert alert-info">This is a theme preview. Save this theme by altering bootstraptheme in settings > configuration</div>
        </cfif>
         #flashMessages()#
       	#includeContent()#
       	</section>
 <!----------------------------/CONTENT--------------------------->

<!-----------------------------Scripts--------------------------->
<cfif application.rbs.usejavascriptfromCDN>
#javascriptIncludeTag("//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js,//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js,jquery-ui-1.10.3.custom.min,//cdnjs.cloudflare.com/ajax/libs/fullcalendar/1.6.4/fullcalendar.min.js,timepicker,bootstrap-colorpicker,moment")# 
<cfelse>
#javascriptIncludeTag("jquery-1.10.2.min,bootstrap.min,jquery-ui-1.10.3.custom.min,fullcalendar,timepicker,bootstrap-colorpicker,moment")# 
</cfif>

        <script>window.jQuery || document.write('<script src="javascripts/jquery-1.10.2.min.js"><\/script>')</script>
<!--- Dynamic Javascript Set in Page --->
<cfif structkeyexists(request, "js")><cfloop list="#structKeyList(request.js)#" index="key"><cfoutput>#request.js[key]#</cfoutput></cfloop></cfif>
    <cfif application.rbs.googleanalytics NEQ "UA-"> 
        <script>
            (function(b,o,i,l,e,r){b.GoogleAnalyticsObject=l;b[l]||(b[l]=
            function(){(b[l].q=b[l].q||[]).push(arguments)});b[l].l=+new Date;
            e=o.createElement(i);r=o.getElementsByTagName(i)[0];
            e.src='//www.google-analytics.com/analytics.js';
            r.parentNode.insertBefore(e,r)}(window,document,'script','ga'));
            ga('create','#application.rbs.googleanalytics#');ga('send','pageview');
        </script> 
    </cfif>
    </body>
</html>

</cfoutput>