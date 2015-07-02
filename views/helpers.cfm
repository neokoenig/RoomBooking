<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfscript>
	/**
	*  @hint Shortcut to XMLFormat
	*/
	public string function h(required string s) {
		return xmlFormat(s);
	}

	/**
	*  @hint Turn mins into friendly string
	*/
	public string function _durationString(numeric d) {
		var h=(arguments.d\60);
		var m=numberformat(arguments.d % 60, "0");
		var r="";
		switch(h){
			case 0:
				r=r & "";
			break;

			case 1:
				r=r & "#h# hour";
			break;
			default:
				r=r & "#h# hours";
			break;
		}
		if(m != 0){
			r = r & " #m# mins";
		}
		if(len(r)){
			return "(" & r & ")";
		} else {
			return "";
		}
	}

	/**
	*  @hint General use date Formatter using user preferences
	*/
	public string function _formatDate(required d) {
		if(isDate(arguments.d)){
			return dateFormat(arguments.d, "#application.rbs.setting.defaultDateFormat#");
		} else {
			return "";
		}
	}

	/**
	*  @hint General use time Formatter using user preferences
	*/
	public string function _formatTime(required d) {
		if(isDate(arguments.d)){
			return timeFormat(arguments.d, "#application.rbs.setting.defaultTimeFormat#");
		} else {
			return "";
		}
	}

	 /**
	 *  @hint General use date and Time Formatter using user preferences
	 */
	 public string function _formatDateTime(required d) {
	 	return _formatDate(arguments.d) & ' - ' & _formatTime(arguments.d);
	 }

	 /**
	 *  @hint Format two dates as a single range: e.g, 7th March 2003, 4pm - 9th March 2003, 6pm
	 */
	 public string function _formatDateRange(required d1,required d2, allday=0) {
	 	local.d1=_formatDate(arguments.d1);
		local.t1=_formatTime(arguments.d1);
		local.d2=_formatDate(arguments.d2);
		local.t2=_formatTime(arguments.d2);
		local.dateTime1=local.d1 & ', ' & local.t1;
		local.dateTime2=local.d2 & ', ' & local.t2;
		if(structKeyExists(arguments, "allDay") AND arguments.allDay){
			local.dateTime1=local.d1 & " (All Day)";
			local.dateTime2=local.d2 & " (All Day)";
		}
		// conditional formatting:
		if(local.dateTime1 EQ local.dateTime2){
			return local.dateTime1;
		} else {
			if(local.d1 EQ local.d2){
				return local.dateTime1 & " - " & local.t2;
			}
			else {
				return local.dateTime1 & " - " & local.dateTime2;
			}

		}
	 }

	 /**
	 *  @hint used in dropdowns filters
	 */
	 public array function _monthList() {
	 	var r=[];
	 	var m={};
	 	for (i=1; i <=12; i++) {
	 		m["k"]=i;
	 		m["v"]=monthAsString(i);
	 		arrayAppend(r, m);
	 		m={};
	 	}
	 	return r;
	 }

	 /**
	 *  @hint used in dropdowns filters, defaults to now - 5, and now + 5
	 */
	 public string function _yearList() {
	 	var r="";
	 	for (var i = (year(now()) - 5); i <= (year(now()) + 5); i++) {
	 		r=listAppend(r, i);
	 	}
	 	return r;
	 }


  /**
    *  @hint Alll the countries
    */
    public string function countryList() {
        var list="Afghanistan,Aland Islands,Albania,Algeria,American Samoa,Andorra,Angola,Anguilla,Antigua & Barbuda,Argentina,Armenia,Aruba,Australia,Austria,Azerbaijan,Bahamas,Bahrain,Bangladesh,Barbados,Belarus,Belgium,Belize,Benin,Bermuda,Bhutan,Bolivia,Bosnia,Botswana,Brazil,British Virgin Isles,Brunei,Bulgaria,Burkina Faso,Burundi,Cambodia,Cameroon,Canada,Cape Verde,Cayman Islands,Central African Republic,Chad,Chile,China People's Republic of,Colombia,Congo,Cook Islands,Costa Rica,Croatia,Cyprus,Czech Republic,Denmark,Djibouti,Dominica,Dominican Republic,Ecuador,Egypt,El Salvador,Equatorial Guinea,Eritrea,Estonia,Ethiopia,Faeroe Islands,Fiji,Finland,France,French Guiana,French Polynesia,Gabon,Gambia,Georgia,Germany,Ghana,Gibraltar,Greece,Greenland,Grenada,Guadeloupe,Guam,Guatemala,Guernsey,Guinea,Guinea-Bissau,Guyana,Haiti,Honduras,Hong Kong,Hungary,Iceland,India,Indonesia,Iraq,Ireland Republic of,Israel,Italy,Ivory Coast,Jamaica,Japan,Jersey,Jordan,Kazakhstan,Kenya,Kiribati,Kuwait,Kyrgyzstan,Laos,Latvia,Lebanon,Lesotho,Liberia,Liechtenstein,Lithuania,Luxembourg,Macau,Macedonia (Fyrom),Madagascar,Malawi,Malaysia,Maldives,Mali,Malta,Marshall Islands,Martinique,Mauritania,Mauritius,Mexico,Micronesia,Moldova,Monaco,Mongolia,Montenegro,Montserrat,Morocco,Mozambique,N. Mariana Islands,Namibia,Nepal,Netherlands,Netherlands Antilles,New Caledonia,New Zealand,Nicaragua,Niger,Nigeria,Norfolk Island,Norway,Oman,Pakistan,Palau,Panama,Papua New Guinea,Paraguay,Peru,Philippines,Poland,Portugal,Puerto Rico,Qatar,Reunion,Romania,Russia,Rwanda,Samoa,San Marino,Saudi Arabia,Senegal,Serbia,Seychelles,Sierra Leone,Singapore,Slovakia,Solomon Islands,South Africa,South Korea,Spain,Sri Lanka,St. Kitts & Nevis,St. Lucia,St. Vincent/Grenadines,Suriname,Swaziland,Sweden,Switzerland,Syria,Taiwan,Tajikistan,Tanzania,Thailand,Togo,Trinidad & Tobago,Tunisia,Turkey,Turkmenistan,Turks & Caicos Islands,Tuvalu,Uganda,Ukraine,United Arab Emirates,United Kingdom,United States,Uruguay,US Virgin Islands,Uzbekistan,Vanatu,Venezuela,Vietnam,Wallia & Futuna Islands,Yemen,Zambia,Zimbabwe";
        return list;
    }

        /**
    * @hint Tick or cross
    */
    public string function tickorcross(required boo){
        var result="";
        if(structKeyexists(arguments, "boo") AND isBoolean(arguments.boo) AND arguments.boo){
            result="<span class='glyphicon glyphicon-ok-sign text-success'></span>";
        } else {
            result="<span class='glyphicon glyphicon-remove-sign text-danger'></span>";
        }
        return result;
    }


    /**
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

    /**
    *  @hint Takes a string like Building One and converts to building-one
    */
    public string function toTagSafe(string) {
    	var r =arguments.string;
    		r=replace(r, " ", "-", "all");
    		r=lcase(r);
    		return r;
    }

    /**
    *  @hint  Takes a string like building-one and converts to Building One
    */
    public string function fromTagSafe(string) {
    	var r =arguments.string;
    		r=replace(r, "-", " ", "all");
    		r=titleize(r);
    		return r;
    }
</cfscript>
