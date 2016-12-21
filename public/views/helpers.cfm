<cfscript>
    /*
    * @hint Render Bootstrap Panels
    */
    public string function panel(required string title, string theclass="panel-primary", boolean ignorebody=false, string morelink=""){
        var result="";
        savecontent variable="result"{
            writeOutput("<div class='panel #arguments.theclass# clearfix'><div class='panel-heading'>");
            if(len(arguments.morelink)){
                writeOutput("<span class='pull-right'>#arguments.morelink#</span>");
            }
            writeOutput("<h3 class='panel-title'>#arguments.title#</h3></div>");
            if(!arguments.ignorebody){
                writeOutput("<div class='panel-body'>");
            }
        }
        return result;
    }

    public string function panelEnd(boolean ignorebody=false){
         if(!arguments.ignorebody){
            return "</div></div>";
         } else {
            return "</div>";
         }
    }

    public string function box(required string title, string theclass="panel-primary", boolean ignorebody=false, string morelink=""){
        var result="";
        savecontent variable="result"{

            writeOutput("<div class='box box-solid #arguments.theclass#'><div class='box-header with-border'>");
            if(len(arguments.morelink)){
                writeOutput("<span class='pull-right'>#arguments.morelink#</span>");
            }
            writeOutput("<h4 class='box-title'>#arguments.title#</h4></div>");
            if(!arguments.ignorebody){
                writeOutput("<div class='box-body'>");
            }
        }
        return result;
    }

    public string function boxEnd(boolean ignorebody=false){
         if(!arguments.ignorebody){
            return "</div></div>";
         } else {
            return "</div>";
         }
    }

    public string function alert(required string title, string content="", string class="danger"){
        var result="";
        savecontent variable="result"{
            echo("<div class='alert alert-#arguments.class# alert-dismissible '>
                <button type='button' class='close' data-dismiss='alert' aria-hidden='true'><i class='fa fa-times'></i></button>");
            echo("<h4><i class='icon fa fa-ban'></i>#arguments.title#</h4></h4>");
            echo(arguments.content);
            echo("</div>");
        }
        return result;
    }
</cfscript>
