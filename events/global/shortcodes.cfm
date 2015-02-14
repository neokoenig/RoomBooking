<cfscript>
  /**
  * @hint Render a  field
  **/
    function field_callback(attr) {
        var result="";
        savecontent variable="result" {
           include "/views/shortcodes/field.cfm";
        }
        return result;
    }

  /**
  * @hint Render a  field
  **/
    function output_callback(attr) {
        var result="";
        savecontent variable="result" {
           include "/views/shortcodes/output.cfm";
        }
        return result;
    }

</cfscript>