component hint="cfWheels ShortCodes Plugin" output="false" mixin="global"
{
	/**
	 * @hint Constructor.
	 */
	public  function init() {
		this.version = "1.3,1.3.1,1.3.2,1.3.3,1.4.1,1.4.2,1.4.3,1.4.4";
		application.shortcodes={};
		return this;
	}

/********************* public ****************************/

	/**
	 * @hint Register shortcodes
	 */
	public void function addShortcode(required string code, required function callback){
		application.shortcodes[code]=callback;
	}

	/**
	 * @hint Process content with shortcodes
	 */
	public string function processShortcodes(string content){
		var result="";
			// Strip potential problematic HTML entities caused by RTEs
			content=replace(content, "&nbsp;", " ", "all");
			result=$sc_REReplaceCallback(string=content, pattern=$sc_getRegex(), callback=$sc_processTag, scope="all");
		return result;
	}
	/**
	 * @hint Return Shortcodes
	 */
	public any function returnShortcodes(){
		var result="";
		if(structKeyExists(application, "shortcodes")){
				savecontent variable="result" {
					for(code in application.shortcodes){
						writeOutput("[" & code & "]<br />");
						writeDump(application.shortcodes[code]);
					}
				}
				return result;
			} else {
				return "No shortcodes available - application.shortcodes doesn't exist";
			}
	}

/********************* internal ****************************/

	/**
	 * @hint private get regex
	 */
	public string function $sc_getRegex(){
		return '(.?)\[(#structKeyList(application.shortcodes, '|')#)\b(.*?)(?:(\/))?\](?:(.+?)\[\/\2\])?(.?)';
	}
	/**
	 * @hint private process tag
	 */
	public string function $sc_processTag(required array parts){
		 if(parts[2] EQ '[' and parts[7] EQ ']'){
		 	return mid(parts[1], 2, len(parts[1]) - 2);
		 }
		 return parts[2] & $sc_invokeTag(parts[3], $sc_parseAttributes(parts[4]), parts[6]) & parts[7];
	}
	/**
	 * @hint private invoke tag
	 */
	public string function $sc_invokeTag(required string tag, required struct attributes, required string content){
		var o = "";
		if(isCustomFunction(application.shortcodes[tag])){
			o = application.shortcodes[tag];
			return o(attributes, content, tag);
		} else {
			// leave cfcs out
		}
	}
	/**
	 * @hint private parse attr
	 */
	public struct function $sc_parseAttributes(required string text){
		var attrs = {};
		var tokens = [];
		var si = "";
		var qi = "";
		var i = "";
		var t = "";
		try{
			if(trim(text) EQ ""){
				return attrs;
			}
			text = trim(REReplace(text, "[#chr(inputBaseN('00a0', 16))#}#chr(inputBaseN('200b', 16))#]+", " ", "all"));
			while (true) {
				si = find(" ", text);
				qi = REFind("['""]", text);
				if(si EQ 0 AND qi EQ 0){
					if(trim(text) NEQ ""){
						arrayAppend(tokens, trim(text));
					}
					break;
				} else if(si GT 0 AND (qi EQ 0 OR si LT qi)){
					arrayAppend(tokens, trim(mid(text, 1, si)));
					text = trim(removeChars(text, 1, si));
				} else {
					t = trim(mid(text, 1, qi - 1)) & mid(text, qi + 1, find(mid(text, qi, 1), text, qi + 1) - qi - 1);
					arrayAppend(tokens, t);
					text = trim(removeChars(text, 1, len(t) + 2));
				}
			}
			i = 0;
			for(t in tokens){
				if(REFind('^\w+=', t) EQ 1){
					attrs[listFirst(t, "=")] = listRest(t, "=");
				} else {
					i += 1;
					attrs[i] = t;
				}
			}

		} catch(any e){
			// Silently fail: if we throw an error here, it can get to the point where the page is uneditable. Better to output nothing.
			// This assumes all your attr have a default.
			return {};
		}

		return attrs;
	}
	/**
	 * @hint private   regex replace callback
	 */
	public string function $sc_REReplaceCallback(){
		var start = 0;
		var match = "";
		var parts = "";
		var replace = "";
		var i = "";
		var l = "";
		while (true) {
			match = REFind(pattern, string, start, true);
			if (match.pos[1] EQ 0) {
				break;
			}
			parts = [];
			l = arrayLen(match.pos);
			for (i = 1; i LTE l; i++) {
				if (match.pos[i] EQ 0) {
					arrayAppend(parts, "");
				} else {
					arrayAppend(parts, mid(string, match.pos[i], match.len[i]));
				}
			}
			replace = callback(parts);
			start = start + len(replace);
			string = mid(string, 1, match.pos[1] - 1) & replace & removeChars(string, 1, match.pos[1] + match.len[1] - 1);
			if (scope EQ "one") {
				break;
			}
		}
		return string;
	}


}