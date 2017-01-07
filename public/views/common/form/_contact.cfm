<cfoutput>
#box(title=l("Contact"))#
	<div class="row">
		<div class="col-md-4 ">
			#textField(objectname=arguments.objectname, property="email", label=l("Email"), type="email",  placeholder="joe@bloggs.com")#
		</div>
		<div class="col-md-4">
			#textField(objectname=arguments.objectname, property="tel", label=l("Phone"), placeholder="+44 (0) 0000 000000")#
		</div>
	</div>
#boxend()#
</cfoutput>
