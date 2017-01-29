<cfoutput>
#box(title=l("Trigger Details"))#
	<div class="row">
		<div class="col-sm-6">
			#textField(objectname="trigger", property="title", label=l("Title") & " *", placeholder="My Trigger", required="true")#
		</div>
	</div>
	<div class="row">
		<div class="col-md-3">
			#select(objectName="trigger", property="triggertype", options="model,controller", label="Type")#
		</div>
		<div class="col-md-3">
			#textField(objectName="trigger", property="triggeron", label="On", placeholder="i.e models.booking")#
		</div>
		<div class="col-md-3">
			#textField(objectName="trigger", property="triggerwhen", label="When", placeholder="i.e AfterCreate or index")#
		</div>
		<div class="col-md-3">
			#textField(objectName="trigger", property="triggercondition", label="Condition", placeholder="???")#
		</div>
	</div>
#boxend()#
</cfoutput>
