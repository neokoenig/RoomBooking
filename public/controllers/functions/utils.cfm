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

    // Turn a simple query into an array of structures
    public array function queryToArray(required query q){
         if (structKeyExists(server, "railo") or structKeyExists(server, "lucee")) {
                local.Columns = listToArray(arguments.q.getColumnList(false));
            }
            else {
                local.Columns = arguments.q.getMetaData().getColumnLabels();
            }
            local.QueryArray = ArrayNew(1);
            for (local.RowIndex = 1; local.RowIndex <= arguments.q.RecordCount; local.RowIndex++){
                local.Row = {};
                local.numCols = ArrayLen( local.Columns );
                for (local.ColumnIndex = 1; local.ColumnIndex <= local.numCols; local.ColumnIndex++){
                    local.ColumnName = local.Columns[ local.ColumnIndex ];
                    if( local.ColumnName NEQ "" ) {
                        local.Row[ "#local.ColumnName#" ] = arguments.q[ "#local.ColumnName#" ][ local.RowIndex ];
                    }
                }
                ArrayAppend( local.QueryArray, local.Row );
            }
            return( local.QueryArray );
    }
</cfscript>
