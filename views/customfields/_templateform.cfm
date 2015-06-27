<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Template Form --->
<cfoutput>
  <div id="template-editor">
	 #template.template#
  </div>
  #hiddenField(objectname="template", property="template")#
  #hiddenField(objectname="template", property="type")#
</cfoutput>

	<cfsavecontent variable="request.js.gridmanager">
	<!---script src="//cdnjs.cloudflare.com/ajax/libs/ckeditor/4.4.5/ckeditor.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/ckeditor/4.4.5/adapters/jquery.js"></script--->
	<script>
	var gm=$("#template-editor").gridmanager({
		debug: 0,
		colSelectEnabled: false,
		colDesktopClass: "col-lg-",
		colDesktopSelector: "div[class*=col-lg-]",
		colTabletClass: "col-md-",
		colTabletSelector: "div[class*=col-md-]",
		colPhoneClass: "col-sm-",
		colPhoneSelector: "div[class*=col-sm-]",
		customControls: {
             global_col: [{ callback: 'insert_customfield', loc: 'top', iconClass: 'fa fa-flash' }]
        },
		remoteURL: "/"

	}).data('gridmanager');

	$("#templateSubmit").on("click", function(e){
        canvas = gm.$el.find("#" + gm.options.canvasId);
        gm.deinitCanvas();
        $("#template-template").val(canvas.html());
        $(this).submit();
	});

	 function insert_customfield(container, btnElem) {
	 	$.ajax({url: "<cfoutput>#urlFor(controller='customfields', action='fieldpicker', key=params.key)#</cfoutput>",
			success: function(data){
				bootbox.dialog({
				  message: data,
				  title: "Add Field",
				  buttons:{
					  success: {
					      label: "Insert Field",
	      				  className: "btn-success",
						  callback: function(e){
							var selectedField=$("#customfielddata").find(".fielddata-selected");
							var selectedType=selectedField.data("type");
 							var sc="[" + selectedType + " id=" + selectedField.data("id") + "]";
 							gm.addEditableAreaClick(container, btnElem, sc);
						  }
					  }

				  }
				});
			}
		});
	 }
	</script>
	</cfsavecontent>