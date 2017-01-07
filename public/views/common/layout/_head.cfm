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
  <!-- Bootstrap 3.3.6 -->
  <link rel="stylesheet" href="/stylesheets/bootstrap.min.css">
  <!-- Font Awesome -->
 <style name="FontAwesome">
        @font-face {
          font-family: 'FontAwesome';
          src: url('https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/fonts/fontawesome-webfont.eot');
          src: url('https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/fonts/fontawesome-webfont.eot?##iefix') format('embedded-opentype'),
               url('https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/fonts/fontawesome-webfont.woff2') format('woff2'),
               url('https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/fonts/fontawesome-webfont.woff') format('woff'),
               url('https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/fonts/fontawesome-webfont.ttf') format('truetype'),
               url('https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/fonts/fontawesome-webfont.svg?##fontawesomeregular') format('svg');
          font-weight: normal;
          font-style: normal;
        }
  </style>

  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css" rel="stylesheet">
  <link rel="stylesheet" href="/stylesheets/AdminLTE.min.css">
  <!--- FC --->
  <link rel="stylesheet" href="/stylesheets/fullcalendar.min.css">
  <!--- DataTables --->
  <link rel="stylesheet" href="/stylesheets/datatables.min.css">
  <link rel="stylesheet" href="/stylesheets/datepicker3.css">
  <link rel="stylesheet" href="/stylesheets/daterangepicker.css">
  <link rel="stylesheet" href="/stylesheets/timepicker.css">
  <!--- Lang --->
  <link rel="stylesheet" href="/stylesheets/lang.css">

  <link type="text/css" href="/stylesheets/jquery.tools.dateinput.css" rel="stylesheet" />
  <link type="text/css" href="/stylesheets/jquery.tools.overlay.css" rel="stylesheet" />
  <link type="text/css" href="/stylesheets/jquery.recurrenceinput.css" rel="stylesheet" />
  <link type="text/css" href="/stylesheets/rbs.css" rel="stylesheet" />
  <link type="text/css" href="/stylesheets/custom.css" rel="stylesheet" />

  <!-- AdminLTE Skins. We have chosen the skin-blue for this starter
        page. However, you can choose any other skin. Make sure you
        apply the skin class to the body tag so the changes take effect.
  -->

  <link rel="stylesheet" href="/stylesheets/skins/#application.rbs.settings.theme_skin#.min.css">

  <link rel="stylesheet" href="/stylesheets/icheck.css">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
  #csrfMetaTags()#
</head>
<body class="#request.bodyClass#">
<div class="wrapper">
</cfoutput>
