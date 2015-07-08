<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!---

Language Switcher

Not using the built in localizator plugin dropdown here, as I want to show the languages in their respective languages. So to speak.
To switch languages, just visit /lang/[lang], where the key is a locale code, i.e en_GB etc.

--->
<cfoutput>
  <li class="dropdown">
  	<a href="##" class="dropdown-toggle" data-toggle="dropdown"><i class="lang-sm" lang="#request.lang.currentCode#" ></i> <b class="caret"></b></a>
        <ul class="dropdown-menu language-picker">
			<cfloop list="#request.lang.languages#" key="i">
				<cfif request.lang.current EQ i>
					<li class="active">
				<cfelse>
					<li>
				</cfif>
				<a href="#urlFor(route="switchlang", lang=i)#" class="lang-sm" lang="#listfirst(i, "_")#"></a>
				 </li>
				</cfloop>
		</ul>
	</li>
</cfoutput>