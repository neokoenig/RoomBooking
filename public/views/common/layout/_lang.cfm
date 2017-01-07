<cfoutput>
<li class="dropdown tasks-menu">
<a href="##" class="dropdown-toggle" data-toggle="dropdown">
    <i class="lang-sm" lang="#request.lang.currentCode#" ></i>
</a>
 <ul class="dropdown-menu language-picker">
 <li class="header">#l("Switch Language")#</li>
 <li>
    <!-- Inner menu: contains the languages -->
    <ul class="menu">
      <cfloop list="#request.lang.languages#" key="i">
        <cfif request.lang.current EQ i>
          <li class="active">
        <cfelse>
          <li>
        </cfif>
        <a href="#urlFor(route="languageSwitch", lang=i)#" >
          <span class="lang-sm lang-lbl" lang="#listfirst(i, "_")#"></span>
        </a>
         </li>
      </cfloop>
    </ul><!-- .menu-->
</li><!-- /inner-->
</ul><!--- .language-picker--->
</li><!-- .language-switcher-->
</cfoutput>
