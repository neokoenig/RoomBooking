<cfsetting enableCfoutputOnly="true">

<cfscript>
	flashWrapperMeta = {};
	flashWrapperMeta.version = "0.1";
	flashInsert(alert="flash(""alert"")");
	flashInsert(error="flash(""error"")");
	flashInsert(info="flash(""info"")");
	flashInsert(success="flash(""success"")");
	include "stylesheets/bootstrap.min.cfm";
</cfscript>

<style>
	p {
		font-family: "Trebuchet MS",Verdana,Arial,Helvetica,sans-serif;
		font-size: 14px;
	}
</style>

<cfoutput>

<h1>Flash Wrapper v#flashWrapperMeta.version#</h1>
<p>
	This plugin adds new parameters to <a href="http://cfwheels.org/docs/1-1/function/flash">flash()</a> and <a href="http://cfwheels.org/docs/1-1/function/flashmessages">flashMessages()</a> so their output can be wrapped with custom HTML.
</p>

<h2>Usage/Examples</h2>
<p>
	<ul>
		<li>Adds parameters <em>prepend</em> and <em>append</em> to <a href="http://cfwheels.org/docs/1-1/function/flash">flash()</a>. Here we can see <a href="http://cfwheels.org/docs/1-1/function/flash">flash()</a> surrounded by <a href="http://twitter.github.com/bootstrap/">Twitter Bootstrap</a> styled markup.</li>
		<li>If the flash key name is one of <em>error</em>, <em>info</em>, or <em>success</em>, and there is a class of <em>alert</em> existing in the <em>prepend</em> argument string, a <a href="http://twitter.github.com/bootstrap/">Twitter Bootstrap</a> compatible class of either <em>alert-error</em>, <em>alert-info</em>, or <em>alert-success</em> will be added to the element according to the flash key name.</li>
	</ul>
	#flash(key="alert", prepend="<div class=""alert"">", append="</div>")#
	#flash(key="error", prepend="<div class=""alert"">", append="</div>")#
	#flash(key="info", prepend="<div class=""alert"">", append="</div>")#
	#flash(key="success", prepend="<div class=""alert"">", append="</div>")#
</p>
<p>
	<ul>
		<li>Adds parameters <em>prependToValue</em> and <em>appendToValue</em> to <a href="http://cfwheels.org/docs/1-1/function/flashmessages">flashMessages()</a>. Here we can see each message in <a href="http://cfwheels.org/docs/1-1/function/flashmessages">flashMessages()</a> surrounded by <a href="http://twitter.github.com/bootstrap/">Twitter Bootstrap</a> styled markup.</li>
		<li>If a flash key name is one of <em>error</em>, <em>info</em>, or <em>success</em>, and there is a class of <em>alert</em> existing in the <em>prependToValue</em> argument string, a <a href="http://twitter.github.com/bootstrap/">Twitter Bootstrap</a> compatible class of either <em>alert-error</em>, <em>alert-info</em>, or <em>alert-success</em> will be added to the element according to the key name for each value in the flash.</li>
	</ul>
	#flashMessages(prependToValue="<div class=""alert"">", appendToValue="</div>")#
</p>

<h2>Configuration</h2>
<p>
	Function default settings can be set from <tt>/config/settings.cfm</tt> or from any of the environment-specific settings files (e.g., <tt>/config/design/settings.cfm</tt>) using the <a href="http://cfwheels.org/docs/1-1/function/set">set()</a> function. Here we see an example using <a href="http://twitter.github.com/bootstrap/">Twitter Bootstrap</a> styled markup.
</p>
<pre>
&lt;cfscript&gt;
    set(functionName="flash", prepend="&lt;div class='alert'&gt;", append="&lt;/div&gt;");
    set(functionName="flashMessages", prependToValue="&lt;div class='alert'&gt;", appendToValue="&lt;/div&gt;");
&lt;/cfscript&gt;
</pre>

<h2>Uninstallation</h2>
<p>
	To uninstall this plugin, simply delete the <tt>/plugins/FlashWrapper-#flashWrapperMeta.version#.zip</tt> file.
</p>

<h2>Credits</h2>
<p>
	This plugin was created by <a href="https://github.com/gregstallings">Greg Stallings</a>. To submit an issue or fork this plugin, visit the <a href="https://github.com/gregstallings/cfwheels-flash-wrapper">https://github.com/gregstallings/cfwheels-flash-wrapper</a> repository on GitHub.
</p>

</cfoutput>

<cfsetting enableCfoutputOnly="false">