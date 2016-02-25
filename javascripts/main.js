/* ================= Room Booking System / https://github.com/neokoenig */

$(document).ready(function(){


//=====================================================================
//= 	Localisation
//=		NB, language for calendars + datepickers is actually set by the 
//=		<html> lang attribute, which is dynamically set depending on session.
//=====================================================================
	// 
	var currentLanguage=$("html").attr("lang");


//=====================================================================
//= 	Main Calendar
//=====================================================================
	if($('#calendar').length >0 ){
		loadCalendar();
	}

	function loadCalendar(){
		var eventsURL     =$("#calendar").data("eventsurl"),
			eventURL      =$("#calendar").data("eventurl"),
			addURL        =$("#calendar").data("addurl"),
			urlrewriting  =$("#calendar").data("urlrewriting"),
			settings      =$("#settings").data();

        if(typeof settings !== "undefined"){

        // Main Calendar
		$('#calendar').fullCalendar({
	//----------------Language------------
		lang: currentLanguage,
    //----------------Config--------------
        header: {
            left:   settings.headerleft,
            center: settings.headercenter,
            right:  settings.headerright
        },
        weekends:           settings.weekends,
        firstDay:           settings.firstday,
        //slotDuration:       settings.slotminutes,
        minTime:            settings.mintime,
        maxTime:            settings.maxtime,
        timeFormat:         settings.timeformat,
        hiddenDays:         settings.hiddendays,
        weekNumbers:        settings.weeknumbers,
        allDaySlot:         settings.alldayslot,
        allDayText:         settings.alldaytext,
        defaultView:        settings.defaultview,
        axisFormat:         settings.axisformat,
        slotEventOverlap:   settings.sloteventoverlap,
        height:             'auto',
        columnFormat: {
            month:  settings.columnformatmonth,
            week:   settings.columnformatweek,
            day:    settings.columnformatday
        },

    //----------------Event Sources----------
        eventSources: [
         {
                url: eventsURL,
                type: 'POST',
                cache: false,
                error: function() {
                    alert('there was an error while fetching events!');
                }
          }
        ],
    //----------------Day Click--------------
        dayClick: function(date, allDay, jsEvent, view) {
            var thepast=moment().subtract("days", 1);
            if(moment(date).isAfter(thepast)){
            // Deal with url rewriting differing paths
               if(urlrewriting === "off"){
                window.location.href = addURL + "&key=" + settings.key + "&d=" + moment(date).format("YYYY-MM-DD");
               } else {
                window.location.href = addURL + settings.key + "?d=" + moment(date).format("YYYY-MM-DD");
               }
             }
        },
    //----------------Event Click --------------
        eventClick: function(calEvent, jsEvent, view) {
            var specificEvent="";
            console.log(calEvent, jsEvent, view);
            // Deal with url rewriting differing paths
            if(urlrewriting === "off"){
                specificEvent="&key=" + calEvent.id + "&format=json"+ "&instanceDate=" + moment(calEvent.start).format("YYYY-MM-DD");
            } else {
                specificEvent="/" + calEvent.id + "?format=json"+ "&instanceDate=" + moment(calEvent.start).format("YYYY-MM-DD");
            }
            $('#eventmodal').modal({
               remote: eventURL + specificEvent
             });
        },
        editable: false
		});
		}
	}
	// Location picker rollovers
	$(".building-row a").on("mouseenter", function(e){
		var id=$(this).data("id");
		$(".location-row").find("a").addClass("hidden").end()
			.find("a" +"." + id).removeClass("hidden");
		}).on("mouseleave", function(e){
	});

//=====================================================================
//=		Repeat Rule Logic
//=====================================================================

	// Try and show/hide the relevant form fields
	if($('#repeatrules').length >0 ){
		disableAllSubFields();
		loadEventRuleForm(); 
	}

	// Disable everythign by default
	function disableAllSubFields(){
		$("#repeatrule-fields :input").attr({"disabled": true});
	}

	$("#event-type").on("change", function(e){
		loadEventRuleForm();
	}); 

	function enableCommonFields(){
		$("#event-repeatstarts, #event-isnever, #event-repeatendsafter, #event-repeatendson").attr({"disabled": false});
	}

	$("#event-isnever").on("click", function(e){
		var isnever = $("#event-isnever:checked").length;
		if(isnever){
			$("#event-repeatendsafter, #event-repeatendson").attr({disabled:true});
		} else {
			$("#event-repeatendsafter, #event-repeatendson").attr({disabled:false});
		}
	});

	$("#event-repeatendsafter").on("change", function(e){
		if($(this).val().length){
			$("#event-isnever, #event-repeatendson").attr({disabled:true});
		} else {
			$("#event-isnever, #event-repeatendson").attr({disabled:false});
		}
	});

	$("#event-repeatendson").on("click", function(e){
		if($(this).val().length){
			$("#event-isnever, #event-repeatendsafter").attr({disabled:true});
		} else {
			$("#event-isnever, #event-repeatendsafter").attr({disabled:false});
		}
	});

	function loadEventRuleForm(){
		var type=$("#event-type").val();
		// Hide all fields by default
		console.log("Loading Rule Form");
		if(typeof type !== "undefined" && type.length){
			disableAllSubFields();
			enableCommonFields();
			console.log(type);
			switch(type) {
			case "daily":
				$(".unitoftime").html("Days");
				$("#event-repeatevery").attr({"disabled": false});
				$("#event-repeaton > option").attr("selected",false);
			break;

			case "weekday":
				$("#event-repeaton > option").attr("selected",false);
			break;

			case "mwf":
				$("#event-repeaton > option").attr("selected",false);
			break;

			case "tt":
				$("#event-repeaton > option").attr("selected",false);
			break;

			case "weekly":
				$(".unitoftime").html("Weeks");
				$("#event-repeatevery, #event-repeaton").attr({"disabled": false});
			break;

			case "monthly":
				$(".unitoftime").html("Months");
				$("#event-repeatevery, #event-repeatby").attr({"disabled": false});
				$("#event-repeaton > option").attr("selected",false);
			break;

			case "yearly":
				$(".unitoftime").html("Years");
				$("#event-repeatevery").attr({"disabled": false});
				$("#event-repeaton > option").attr("selected",false);
			break;

			default:
				console.log("Default");
			}
		}
	}

	

//=====================================================================
//=		Resource Restrictions 	
//=====================================================================
	function restrictResources(uncheck){
		var selectedLocation=getSelectedLocation(),
		rows=$("#resourceTable").find("td[data-restrict]");
		rows.find("input").attr({"disabled": true});
		if(uncheck){
			rows.find("input").attr({"checked": false});
		}
		$.each(rows, function(i, val){
			var restrict=$(val).data("restrict");
			if(restrict.length > 1){
				if ($.inArray(selectedLocation, restrict.replace(/,\s+/g, ',').split(',')) >= 0) {
					$(val).find("input").attr({"disabled": false});
				}
			}
		});
	}

	// Remote resource availability check
	$("#resourceTable td[data-unique] input").on("click", function(e){
		var 
		settings= $("#bookingFormSettings"),
		id=$(this).closest("td").data("unique"), 
		eventid=settings.data("eventid"),
		start=$("#event-startsat").val(),
		end=$("#event-endsat").val();
		if(start.length === 0 || end.length === 0){
			alert("You must enter a start and end date/time before attempting to book this resource");
			return false;
		}
		$.ajax({
			url: settings.data("resourcecheckurl"),
			data: {
				id: id,
				eventid: eventid,
				start: start,
				end: end
			},
			success: function(data){
				console.log(data);
				var resource=$("#resourceTable td[data-unique=" + id  +"] input");
				resource.parent().find(".rCheck").remove();
				if(data.length === 0){
					resource.attr({"checked": true}).parent().append("<p class='rCheck text-success'><i class='glyphicon glyphicon-ok'></i></p>");
				} else {
					resource.attr({"checked": false}).parent().append("<p class='rCheck text-danger'><i class='glyphicon glyphicon-warning-sign'></i></p>");
				}
			}
		});
	});
//=====================================================================
//=		Concurrency Checks 	
//=====================================================================
	if($('#concurrencyCheckResult').length >0){
		// Concurrency Check
		concurrencyCheck();
		// Deselect resources if restricted
		restrictResources(false);
		// Override default Layouts if appropriate
		checkLayouts();
	}
 
	// When the datepicker changes, rerun concurrency checks
	$("#event-startsat, #event-endsat").on("dp.hide", function(e){
		concurrencyCheck();
	});

	// If all day gets ticked/unticked, check
	$("#event-allday").on("change", function(e){
		concurrencyCheck();
	});

	// When the event location changes, rerun checks
	$("#event-locationid").on("change", function(e){
		checkLayouts();
		concurrencyCheck();
		restrictResources(true);
	});

	function concurrencyCheck(){
		var start=$("#event-startsat").val(),
			end=$("#event-endsat").val(),
			location=$("#event-locationid").val(),
			id=$("#tempkey").val(),
			referrer=$("#referrer").val();
			display=$("#concurrencyCheckResult");
		var settings=$("#bookingFormSettings");
		var checkurl=settings.data("checkurl");
		if(start.length && end.length){
			if(settings.data("doconcurrencycheck")){
				console.log("Concurrency Check",  start, end);
				$.ajax({
					url: checkurl,
					data: {
						start: start,
						end: end,
						location: location,
						id: id,
						referrer: referrer
					},
					success: function(r){
						if(r.length > 0 && settings.data("allowoverlappingbookings")){
							$(".submitEvent").addClass("disabled");
						} else {
							$(".submitEvent").removeClass("disabled");
						}
						$(display).html(r);
					}
				});
			} else {
				console.log("CC Skipped");
			}

		}
	} 

	function getSelectedLocation(){
		return $("#event-locationid").val();
	}

	 function checkLayouts(){
		var settings=$("#bookingFormSettings"); 
		var layouts=settings.data("locationlayouts"); 
		var location=getSelectedLocation(),
			layout=layouts[location],
			$el = $("#event-layoutstyle"),
			oldValue=$el.val(); 
			if(layout.length === 0){
				layout=settings.data("defaultlayouts");
			} 
			layoutArr=layout.split(',');
			$el.empty(); // remove old options
			$.each(layoutArr, function(value,key) {
				$el.append($("<option></option>").attr("value", key).text(key));
			});
			//Try and match previously selected value to new list
			$el.val(oldValue);
	} 

//=====================================================================
//=		Template Editor	
//=====================================================================
	if($('#template-editor').length >0 ){
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
			e.preventDefault();
	        canvas = gm.$el.find("#" + gm.options.canvasId);
	        gm.deinitCanvas();
	        $("#template-template").val(canvas.html());
	        $(this).submit();
		}); 
	}

	function insert_customfield(container, btnElem) {
	 	console.log("ic called");
	 	var pickerURL = $('#template-editor').data("picker");
	 	$.ajax({url: pickerURL,
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

//=====================================================================
//= 	Custom Fields
//=====================================================================
	$("#customfieldSubmit").on("click", function(e){
		e.preventDefault();
		var code = editor.getSession().getValue();
		$("#customfield-options").val(code);
		$(this).parent().submit();
	});
//=====================================================================
//= 	Dropdown Login
//=====================================================================
	$('#dropdown-signin').find('form').click(function(e){
		e.stopPropagation();
	});

//=====================================================================
//= 	Tabs
//=====================================================================
	$('#myTab a:first').tab('show');

//=====================================================================
//= 	Popovers
//=====================================================================
	$('.pop').popover({placement: "top"});

//=====================================================================
//= 	Colour Pickers
//=====================================================================
	$('.bscp').minicolors({
		theme: 'bootstrap'
	});

//=====================================================================
//= 	Form Validation
//=====================================================================
	$('#bookingform, #signinForm, #pwresetForm, #locationForm, #resourceForm, #userForm').bootstrapValidator({
		feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        }
    });

//=====================================================================
//= 	Date Pickers
//=====================================================================
	// NB, irrespective of locale, it's easier to keep dates in YYYY-MM-DD HH:mm!
	$('#event-startsat, #event-endsat').datetimepicker({
			locale: currentLanguage,
			format: "YYYY-MM-DD HH:mm",
			showTodayButton: true,
			stepping: 5
	});

	$("#event-repeatstarts, #event-repeatendson").datetimepicker({
		locale: currentLanguage,
		showTodayButton: true,
		format: 'YYYY-MM-DD'
	});

	// Link pickers: NB, using dp.hide not dp.change otherwise you can't select a start date without setting end date first
	$('#event-startsat').on("dp.hide", function(e){
		$('#event-endsat').data("DateTimePicker").minDate(e.date);
	});

	$('#event-endsat').on("dp.hide", function(e){
		$('#event-startsat').data("DateTimePicker").maxDate(e.date);
	});

	// All day switches to maximum range
	$("#event-allday").on("click", function(e){
		var sd=$('#event-startsat').data("DateTimePicker").date(),
			ed=$('#event-endsat').data("DateTimePicker").date();
		$("#event-startsat").data("DateTimePicker").date(moment(
			{y: sd.year(), M: sd.month(), d: sd.date(), h: 0, m: 0}
		));
		$("#event-endsat").data("DateTimePicker").date(moment(
			{y: ed.year(), M: ed.month(), d: ed.date(), h: 23, m: 59}
		));
	});

	// Generic datepicker (list view)
	$("#start, #end").datetimepicker({
		locale: currentLanguage,
		showTodayButton: true,
		format: 'YYYY-MM-DD'
	});
 
//=====================================================================
//= 	Modal Events
//=====================================================================
	$(".booked").on("click", function(e){
		var url=$(this).find(".remote-modal").attr("href");
		e.preventDefault();
		$('#eventmodal').modal({
			remote: url
		});
	});

	// Modal ical cut and paste
	$(".ical").on("click", function(e){
		var icallink=$(this).attr("href");
		e.preventDefault();
		$("#icaldata").val(icallink);
		$('#icalmodal').modal();
	});

	// Remove old modal data
    $('body').on('hidden.bs.modal', '.modal', function () {
        $(this).removeData('bs.modal');
    });

/* End */
});