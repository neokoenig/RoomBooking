<cfoutput>
#box(title="Update Value for #setting.name#")#
	<div class="row">
		<div class="col-md-4">
			#setting.description#
		</div>
		<div class="col-md-4">
			<cfswitch expression="#setting.type#">
			<cfcase value="boolean">
				#checkbox(objectname="setting", property="value", label="")#
			</cfcase>
			<!--- Select --->
			<cfcase value="select">

			<cfif setting.options CONTAINS "[[">
				<!--- TODO: there must be a better way than using Evaluate? --->
				#select(objectname="setting", property="value", options=evaluate(replace(replace(setting.options, '[[', '', 'all'), ']]', '', 'all')))#
			<cfelse>
				#select(objectname="setting", property="value", options=setting.options)#
			</cfif>
			</cfcase>
			<!--- String Default --->
			<cfdefaultcase>
				#textField(objectname="setting", property="value")#
			</cfdefaultcase>
			</cfswitch>
		</div>
	</div>

#boxEnd()#
</cfoutput>
