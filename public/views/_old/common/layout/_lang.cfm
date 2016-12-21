<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!---

Language Switcher

Not using the built in localizator plugin dropdown here, as I want to show the languages in their respective languages. So to speak.
To switch languages, just visit /lang/[lang], where the key is a locale code, i.e en_GB etc.

We're limited by what's available for fullcalendar.js:

<option value="en">en</option>
<option value="ar-ma">ar-ma</option>
<option value="ar-sa">ar-sa</option>
<option value="ar-tn">ar-tn</option>
<option value="ar">ar</option>
<option value="bg">bg</option>
<option value="ca">ca</option>
<option value="cs">cs</option>
<option value="da">da</option>
<option value="de-at">de-at</option>
<option value="de">de</option>
<option value="el">el</option>
<option value="en-au">en-au</option>
<option value="en-ca">en-ca</option>
<option value="en-gb">en-gb</option>
<option value="es">es</option>
<option value="fa">fa</option>
<option value="fi">fi</option>
<option value="fr-ca">fr-ca</option>
<option value="fr">fr</option>
<option value="he">he</option>
<option value="hi">hi</option>
<option value="hr">hr</option>
<option value="hu">hu</option>
<option value="id">id</option>
<option value="is">is</option>
<option value="it">it</option>
<option value="ja">ja</option>
<option value="ko">ko</option>
<option value="lt">lt</option>
<option value="lv">lv</option>
<option value="nb">nb</option>
<option value="nl">nl</option>
<option value="pl">pl</option>
<option value="pt-br">pt-br</option>
<option value="pt">pt</option>
<option value="ro">ro</option>
<option value="ru">ru</option>
<option value="sk">sk</option>
<option value="sl">sl</option>
<option value="sr-cyrl">sr-cyrl</option>
<option value="sr">sr</option>
<option value="sv">sv</option>
<option value="th">th</option>
<option value="tr">tr</option>
<option value="uk">uk</option>
<option value="vi">vi</option>
<option value="zh-cn">zh-cn</option>
<option value="zh-tw">zh-tw</option>

But also what the localizator plugin pulls in from Java: slightly different formats too (i.e, fr_FR vs fr, fr-FR)

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