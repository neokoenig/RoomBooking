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

    public string function sidebarlink(
        required string controller,
        required string route,
        required string icon,
        required string text,
        numeric key=0
    ){
        if(hasPermission(controller)){
            local.rv="<li class='";
            if(params.controller == controller){
               local.rv&=("active");
            }
            local.rv&="'>";
            if(key){
            local.rv&=linkTo(route=route, key=key, text="<i class='fa #icon#'></i> <span>" & l(text) & "</span></li>");
            } else {
            local.rv&=linkTo(route=route, text="<i class='fa #icon#'></i> <span>" & l(text) & "</span></li>");
            }
            return local.rv;
        } else {
            return "";
        }

    }

    public string function tickorcross(required boolean boolean){
        local.rv="";
        if(structKeyexists(arguments, "boolean") AND isBoolean(arguments.boolean) AND arguments.boolean){
            local.rv="<i class='fa fa-check text-success'></i>";
        } else {
            local.rv="<i class='fa fa-times text-danger'></i>";
        }
        return local.rv;
    }

    public string function h(required string s) {
        return xmlFormat(s);
    }


    public string function LSDateFormatDuration(required date start, required date end){
            local.rv="";
            local.start=LSdateFormat(arguments.start);
            local.startTime=LStimeFormat(arguments.start);
            local.end=LSdateFormat(arguments.end);
            local.endTime=LStimeFormat(arguments.end);

            local.isForever= year(local.end) == 9999 ? true:false;

            if(local.startTime EQ "00:00"){
                local.startTime="";
            }
            if(local.endTime EQ "00:00"){
                local.endTime="";
            }

            local.rv=local.start & ' ' & local.startTime;

            if(local.start != local.end && !local.isForever){
                local.rv= local.start & ' ' & local.startTime & ' - ' & local.end  & ' ' & local.endTime;
            } else {
                if(local.startTime !=  local.endTime){
                    local.rv= local.start & ' ' & local.startTime & ' - '    & local.endTime;
                }
            }
        return local.rv;
    }

    public string function LSdurationString(numeric d) {
        var h=(arguments.d\60);
        var m=numberformat(arguments.d % 60, "0");
        var r="";
        switch(h){
            case 0:
                r=r & "";
            break;
            case 1:
                r=r & h  & " " & l("hour");
            break;
            default:
                r=r & h  & " " & l("hours");
            break;
        }
        if(m != 0){
            r=r & h  & " " & l("mins");
        }
        if(len(r)){
            return "(" & r & ")";
        } else {
            return "";
        }
    }
</cfscript>
