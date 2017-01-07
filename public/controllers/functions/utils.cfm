<cfscript>

	// surround each array element in brackets and return delimited by an operator
	public string function whereify(required array array, string operator="AND") {
		var loc = {};
		loc.array = [];
		for (loc.i=1; loc.i <= ArrayLen(arguments.array); loc.i++) {
		    loc.array[loc.i] = "(#arguments.array[loc.i]#)";
		}
		return ArrayToList(loc.array, " #arguments.operator# ");
	}
</cfscript>
