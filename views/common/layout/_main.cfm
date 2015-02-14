<cfoutput>
<!--[if lt IE 7]>
  <p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
<![endif]-->
<section id="main" class="container">
  #flashMessages()#
  #includeContent()#
</section>
<!-----------------------------Footer---------------------------->
<footer>
    <div class="container">
        <hr />
        <p><small>Version #application.rbs.versionNumber# | DB: #application.rbs.setting.version#</small></p>
    </div>
</footer>
</cfoutput>