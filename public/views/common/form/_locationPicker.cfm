<cfparam name="locations">

<cfscript>
standalonerooms=arrayFilter(locations, function(n) {
	return n.type == 'room';
});
buildings=arrayFilter(locations, function(n) {
	return n.type == 'building';
});
</cfscript>
<cfoutput>
<div class="locationpicker row">
	<div class="col-md-4">
		<cfif arraylen(standalonerooms)>
		<h5>#l("Select Building")#</h5>
		<div class="locationpicker-building">
        			#buttonTag(type="button",
        				 value="select",
        				 content=l("Any"),
        				 class="btn btn-sm btn-info btn-block")#
        			#buttonTag(type="button",
        				 value="select",
        				 content=l("Standalone Rooms"),
        				 class="btn btn-sm btn-block")#
		</div>
		</cfif>

	</div>
	<div class="col-md-4">
		<h5>#l("Select Room")#</h5>
		<div class="locationpicker-room"></div>
	</div>
	<div class="col-md-4">
		<h5>#l("Search Date Range")#</h5>


              <!-- Date and time range -->
              <div class="form-group">
              <div class="input-group">
                  <div class="input-group-addon">
                    <i class="fa fa-clock-o"></i>
                  </div>
                  <input type="text" class="form-control pull-right" id="daterange">
                </div>
              </div>
              <!-- /.form group -->


		<h5>#l("Details")#</h5>
		<div class="locationpicker-detail"></div>
	</div>
</div>


#buttonTag(type="button",
 value="get",
 content="Test Get",
 class="btn btn-sm btn-block test-get")#

</cfoutput>
<cfsavecontent variable="request.js.locationPicker">
<script>
$(document).ready(function($) {
	var buildings=<cfoutput>#serializeJSON(buildings)#</cfoutput>;
	var standalonerooms=<cfoutput>#serializeJSON(standalonerooms)#</cfoutput>;

//Date range as a button
    $('#daterange').daterangepicker(
        {
		timePicker: true,
		timePickerIncrement: 15,
	    buttonClasses: "btn btn-sm btn-flat",
	    applyClass: "btn-success btn-flat",
	    cancelClass: "btn-default btn-flat",
		locale: {
			format: 'YYYY-MM-DD HH:mm'
		},
          ranges: {
            'Today': [moment().startOf('day'), moment().endOf('day')],
            'Tomorrow': [moment().add(1, 'days').startOf('day'), moment().add(1, 'days').endOf('day')],
            'Next 7 Days': [moment().startOf('day'),moment().add(6, 'days').endOf('day')],
            'Next 30 Days': [moment().startOf('day'), moment().add(29, 'days').endOf('day')],
            'This Month': [moment().startOf('month'), moment().endOf('month')],
            'Next Month': [moment().add(1, 'month').startOf('month'), moment().add(1, 'month').endOf('month')]
          },
          startDate: moment(),
          endDate: moment().add(29, 'days').endOf('day')
        }
        //function (start, end) {
        //  $('#daterange-btn span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
        //}
    );

	createBuildings(buildings);

	function getSelected(){
		var building=$(".locationpicker-building button.btn-info").data();
		var room=$(".locationpicker-room button.btn-info").data();
		var daterange=$("#daterange").val();
		console.log($("#daterange").val());
		 console.group('Selected');
			console.log('building: ', building);
			console.log('room: ', room);
			console.log('daterange: ', daterange);
		 console.groupEnd();
		 updateDetails(building, room, daterange);
	}

	$(".test-get").on("click", function(e){
		getSelected();
	});

	function updateDetails(building, room, daterange){
		var html="";

		if(typeof building.title !== "undefined"){
		 html+= "<h3>" + building.title + "</h3>";
		}
			html+= "<h4>" + room.title + "</h4>"
			+ "<p>" + room.description + "</p>"
			+ "<p>" + daterange +  "</p>";

		$(".locationpicker-detail").html(html);
	}

	function resetDetails(){
		$(".locationpicker-detail").html("Please Select a Room");
	}

	function loadRoomsForBuilding(buildingid){
		$(".locationpicker-room").append(renderBtn({
			"id": 0,
			"description": "Any Available Room",
			"title": "Any",
			"icon": "fa-question-circle"
		}));
		if(typeof buildingid == "undefined"){
			createRoom(standalonerooms);
		} else {
			var bRooms = $.grep(buildings, function(e){ return e.id == buildingid; });
			$.each(bRooms, function(index, val) {
				$.each(val.groupby, function(index, g) {
					if((typeof g === "object") && (g !== null) && index != "0"){
						$(".locationpicker-room").append(renderGroupBtn({
							"title": index
						}));
					}
					 createRoom(g);
				});
			});

		}
	}
	function renderGroupBtn(group){
		var btn= $("<button>")
			.addClass("btn btn-block btn-xs grp")
			.html(group.title);
		return btn;
	}

	function renderBtn(room){
		var btn= $("<button>")
			.addClass('btn btn-xs btn-block')
			.attr({"type":"button", "value": "select"})
			.data({
				"roomid": room.id,
				"description": room.description,
				"title": room.title
			})
			.html("<i class='fa " + room.icon + "''></i> " + room.title);

		return btn;
	}

	function createRoom(rooms){
		$.each(rooms, function(index, val) {
			$(".locationpicker-room").append(renderBtn(val));
		});
		$(".locationpicker-room button").on("click", function(e){
			$(".locationpicker-room button").removeClass("btn-info");
			$(this).addClass('btn-info');
			//$(".locationpicker-detail").html(
			//	"<h4>" + $(this).data("title") + "</h4>"
			//	+ "<p>" + $(this).data("description") + "</p>");
			getSelected();
		});
	}

	function createBuildings(buildings){
		var html="";
		$.each(buildings, function(index, val) {
			var b=$("<button>")
				.addClass('btn btn-sm btn-block')
				.attr({"type":"button", "value": "select"})
				.data({
					"buildingid": val.id,
					"title": val.title
				})
				.html("<i class='fa " + val.icon + "''></i> " + val.title);
				$(".locationpicker-building").append(b);
		});
		$(".locationpicker-building button").on("click", function(e){
			$(".locationpicker-building button").removeClass("btn-info");
			$(this).addClass('btn-info');
			$(".locationpicker-room").html("");
			resetDetails();
			loadRoomsForBuilding($(this).data("buildingid"));
		});
	}
});
</script>
</cfsavecontent>
