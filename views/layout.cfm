<cfoutput>
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>#application.roombooking.sitetitle#</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
		    <meta name="HandheldFriendly" content="true">
		    <meta name="apple-mobile-web-app-capable" content="yes"><!-- try to forces full-screen for apple devices -->
        <!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
 		     #stylesheetLinkTag("theme,http://cdnjs.cloudflare.com/ajax/libs/fullcalendar/1.6.4/fullcalendar.css,smoothness/jquery-ui-1.10.3.custom.min,custom,jquery.growl.css")# 
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
          <a class="navbar-brand" href="">#application.roombooking.sitetitle#</a>
        </div>
        <nav class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li>#linkTo(route="home", text="<span class='glyphicon glyphicon-calendar'></span> Calendar")#</li> 
            <li>#linkTo(controller="bookings", action="add", text="<span class='glyphicon glyphicon-plus-sign'></span> Book a Room")#</li>
            <li>#linkTo(controller="locations",  text="<span class='glyphicon glyphicon-plus-sign'></span> Locations")#</li>
            <li>#linkTo(controller="settings",  text="<span class='glyphicon glyphicon-plus-sign'></span> Settings")#</li>
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
        <div id="growls" class="default"></div>
          #flashMessages()#
       	#includeContent()#
       	</section>
 <!----------------------------/CONTENT--------------------------->

<!-----------------------------Scripts--------------------------->
       	#javascriptIncludeTag("http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js,bootstrap.min,jquery-ui-1.10.3.custom.min,http://cdnjs.cloudflare.com/ajax/libs/fullcalendar/1.6.4/fullcalendar.min.js,jquery.growl,timepicker,moment")# 
        <script>window.jQuery || document.write('<script src="javascripts/jquery-1.10.2.min.js"><\/script>')</script>
<!--- Dynamic Javascript Set in Page --->
<cfif structkeyexists(request, "js")><cfloop list="#structKeyList(request.js)#" index="key"><cfoutput>#request.js[key]#</cfoutput></cfloop></cfif>

        <!-- Google Analytics: change UA-XXXXX-X to be your site's ID. 
        <script>
            (function(b,o,i,l,e,r){b.GoogleAnalyticsObject=l;b[l]||(b[l]=
            function(){(b[l].q=b[l].q||[]).push(arguments)});b[l].l=+new Date;
            e=o.createElement(i);r=o.getElementsByTagName(i)[0];
            e.src='//www.google-analytics.com/analytics.js';
            r.parentNode.insertBefore(e,r)}(window,document,'script','ga'));
            ga('create','UA-XXXXX-X');ga('send','pageview');
        </script>-->
    </body>
</html>

</cfoutput>