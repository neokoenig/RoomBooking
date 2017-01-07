<cfparam name="allcountries">
<cfoutput>
#box(title=l("Address"))#
	<div class="row">
		<div class="col-md-6">
			#textField(objectname=arguments.objectname, property="address1", label=l("Address 1"), placeholder="34 Fake Street")#
			#textField(objectname=arguments.objectname, property="address2", label=l("Address 2"), placeholder="Oxford")#
			<div class="row">
				<div class="col-md-4">
					#textField(objectname=arguments.objectname, property="state", label=l("State/County"), placeholder="Oxon or Alabama")#
				</div>
				<div class="col-md-4">
					#textField(objectname=arguments.objectname, property="postcode", label=l("Postcode"), placeholder="OX1 1DP or 90210")#
				</div>
				<div class="col-md-4">
					#select(objectname=arguments.objectname, property="country", label=l("Country"), textField="title", valueField="code", options=allcountries, includeBlank="Not Specified")#
				</div>
			</div>

		</div>
	</div>

#boxend()#
</cfoutput>
