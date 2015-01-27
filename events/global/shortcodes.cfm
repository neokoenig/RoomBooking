<cfscript>
  /**
  * @hint Render a system field
  **/
    function systemfield_callback(attr) {
        param name="attr.name" default="";
        var result="";
        savecontent variable="result" {
           include "/views/shortcodes/system.cfm";
        }
        return result;
    }

    /**
  * @hint Render a custom field
  **/
    function customfield_callback(attr) {
        param name="attr.id" default="";
        var result="";
        savecontent variable="result" {
           include "/views/shortcodes/custom.cfm";
        }
        return result;
    }


  /**
  * @hint Output a fields value
  **/
    function systemoutput_callback(attr) {
        param name="attr.id" default="";
        var result="";
        savecontent variable="result" {
           include "/views/shortcodes/systemoutput.cfm";
        }
        return result;
    }

  /**
  * @hint Output a fields value
  **/
    function customoutput_callback(attr) {
        param name="attr.id" default="";
        var result="";
        savecontent variable="result" {
           include "/views/shortcodes/customoutput.cfm";
        }
        return result;
    }
</cfscript>