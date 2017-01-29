<cfoutput>
#box(title=l("Action Details"))#
	<div class="row">
		<div class="col-md-6">
			#textField(objectname="theaction", property="title", label=l("Title") & " *", placeholder="My Trigger", required="true")#
		</div>
		<div class="col-md-3">
			#select(objectname="theaction", property="componentcfc", options=getAvailableActions()["actions"], label="CFC")#
		</div>
	</div>
	#textarea(objectname="theaction", property="description", label=l("Description"))#
#boxend()#

#box(title=l("Properties"))#
<div id="actionproperties"
	data-key="#theaction.key()#",
	data-componentcfc="#theaction.componentcfc#",
	data-dataurl="#urlFor(route="adminProperties")#"></div>
#boxEnd()#
</cfoutput>
<cfsavecontent variable="request.js.actionproperties">
<script>
$(document).ready(function() {

	var settings=$("#actionproperties").data();

	getProperties();

	$("#theaction-componentcfc").on("change", function(e){
		settings.componentcfc=$(this).val();
		getProperties();
	});

	function fetchError(string){
    var h="<div class='alert alert-warning alert-dismissible '><button type='button' class='close' data-dismiss='alert' aria-hidden='true'><i class='fa fa-times'></i></button><h4><i class='icon fa fa-exclamation-triangle'></i>Error</h4>Error Fetching " + string + "...</div>";
      $("#actionproperties").html(h);
  }

	function getProperties(){
		console.log("getProperties");
		$.ajax({
        url: settings.dataurl,
        cache: false,
        data: {
        	"key": settings.key,
        	"componentcfc": settings.componentcfc
        },
        success: function(data){
        	$("#actionproperties").html(data);
        },
        error: function(e){
          fetchError("Error Getting Properties");
          console.log(e);
        }
    });
	}
});
</script>
</cfsavecontent>
