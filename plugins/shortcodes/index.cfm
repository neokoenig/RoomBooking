<h1>Shortcodes v0.1</h1>
<p>This is a port of Barney's <a href="http://www.barneyb.com/barneyblog/projects/shortcodes/">shortcodes</a> implementation for CFML (itself a port of the wordpress shortcodes concept). He wrote all the tricky stuff, I've just refactored into cfscript, stripped out all the CFC aspects and made into a cfWheels plugin. Note, I haven't bothered with the full cfc implementation with execute, as we're doing this within a cfwheels app.</p>

<p>Please note nested shortcodes aren't currently supported.</p>

<h2>Usage</h2>
<pre>
// Add a shortcode
addShortcode("code", callback);

// Process content with shortcodes in
processShortcodes(content);

// Quick dump to view existing shortcodes
returnShortcodes();
</pre>


<h2>Example, adding a shortcode for [test]</h2>
<p>To add a shortcode, such as [test], first, you should register the code in /events/onapplicationstart.cfm</p>
<pre>
addShortcode("test", test_shortcode_callback);
</pre>
<p>This basically registers [test] as a trigger for test_shortcode_callback(). So next, we need to create that function.</p>
<p>In /events/functions.cfm, add your callback:</p>
<pre>
// Test Shortcode
function test_shortcode_callback(attr) {
    return "foo";
}
</pre>
<p>Lastly, wrap any content which you want to parse for shortcodes to with sc_process()</p>
<pre>
&lt;cfsavecontent variable="mycontent"&gt;
&lt;p&gt;I am [test], fear me.&lt;/p&gt;
&lt;/cfsavecontent&gt;
&lt;cfoutput&gt;
#processShortcodes(mycontent)#
&lt;/cfoutput&gt;
</pre>

<h2>Using passed tag attributes</h2>
<p>You can use any data passed by tag attributes via the "attr" struct.</p>
<pre>
[test foo="bar"]
</pre>
<p>Will allow you to reference #attr.foo# in your shortcode function.</p>


<h2>Wrapping content with tags</h2>
<p>To enable a tag to 'wrap' about content, you need to make sure the callback function has the content argument</p>
<pre>
// Example shortcode to wrap content in a div
function test_shortcode_callback(attr, content) {
    var result="";
    result="&lt;div class='test'&gt;" & content & "&lt;/div&gt;";
    return result;
}

// Usage:
[test]My Stuff[/test]
</pre>

<h2>More advanced example:</h2>
<p>This example renders the markup needed for a bootstrap 3.x panel via including a partial</p>

<pre>
// addShortcode("panel", panel_callback);

/**
 * @hint Renders a bootstrap panel: usage [panel title="My Title"]Content[/panel]
 **/
function panel_callback(attr, content) {
       param name="attr.title" default="";
       var result="";
       savecontent variable="result" {
         includePartial(partial="/common/widgets/panel", title=attr.title, content=content);
       }
       return result;
   }
</pre>

<p>Panel partial: (/common/widgets/_panel.cfm)</p>
<pre>
&lt;cfoutput&gt;
&lt;div class='panel panel-default clearfix'&gt;
  &lt;div class='panel-heading'&gt;
    &lt;h3 class='panel-title'&gt;#arguments.title#&lt;/h3&gt;
  &lt;/div&gt;
  &lt;div class='panel-body'&gt;#arguments.content#&lt;/div&gt;
&lt;/div&gt;
&lt;/cfoutput&gt;
</pre>

<p>The nice part about having this within wheels itself is that you can access any of the wheels functions and helpers, including the params struct (i.e, useful for paging numbers etc), whereas using Barney's cfc in the /miscellaneous/ folder (and then extending controller.cfc) caused various issues.</p>


<h3>View Available Shortcodes</h3>
<p>Check your shortcodes exist and are registered with returnShortcodes()</p>
<cfoutput>
#returnShortcodes()#
</cfoutput>
