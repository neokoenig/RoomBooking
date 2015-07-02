/* ================= Room Booking System / https://github.com/neokoenig */

$(document).ready(function(){

	tryForCalendar();

	function tryForCalendar(){
		var eventsURL     =$("#calendar").data("eventsurl"),
			eventURL      =$("#calendar").data("eventurl"),
			addURL        =$("#calendar").data("addurl"),
			urlrewriting  =$("#calendar").data("urlrewriting"),
			settings      =$("#settings").data();

        if(typeof settings !== "undefined"){

        // Main Calendar
		$('#calendar').fullCalendar({

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
            // Deal with url rewriting differing paths
            if(urlrewriting === "off"){
                specificEvent="&key=" + calEvent.id + "&format=json";
            } else {
                specificEvent="/" + calEvent.id + "?format=json";
            }
            $('#eventmodal').modal({
               remote: eventURL + specificEvent
             });
        },
        editable: false
		});
		}
	}

	// Building Rollover------------------
	$(".building-row a").on("mouseenter", function(e){
		var id=$(this).data("id");
		$(".location-row").find("a").addClass("hidden").end()
			.find("a" +"." + id).removeClass("hidden");
		}).on("mouseleave", function(e){
	});


	// Handles menu drop down-------------
	$('#dropdown-signin').find('form').click(function(e){
		e.stopPropagation();
	});

	// Tabs-------------------------------
	$('#myTab a:first').tab('show');

	// Popovers---------------------------
	$('.pop').popover({placement: "top"});

	// Colour Pickers---------------------
	$('.bscp').minicolors({
		theme: 'bootstrap'
	});

	// Form validation--------------------
	$('#bookingform, #signinForm, #pwresetForm, #locationForm, #resourceForm, #userForm').bootstrapValidator({
		feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        }
    });

	// Date Pickers-----------------------
	$('#event-start, #event-end').datetimepicker({
			showTodayButton: true,
			stepping: 5
	});

	// Link pickers: NB, using dp.hide not dp.change otherwise you can't select a start date without setting end date first
	$('#event-start').on("dp.hide", function(e){
		$('#event-end').data("DateTimePicker").minDate(e.date);
	});

	$('#event-end').on("dp.hide", function(e){
		$('#event-start').data("DateTimePicker").maxDate(e.date);
	});

	// All day switches to maximum range
	$("#event-allday").on("click", function(e){
		var sd=$('#event-start').data("DateTimePicker").date(),
			ed=$('#event-end').data("DateTimePicker").date();
		$("#event-start").data("DateTimePicker").date(moment(
			{y: sd.year(), M: sd.month(), d: sd.date(), h: 0, m: 0}
		));
		$("#event-end").data("DateTimePicker").date(moment(
			{y: ed.year(), M: ed.month(), d: ed.date(), h: 23, m: 59}
		));
	});

	$("#dayview-pick").datetimepicker({
		showTodayButton: true
	});

	// Generic datepicker
	$("#datefrom, #dateto").datetimepicker({
		showTodayButton: true,
		format: 'DD MMM YYYY'
	});

	$("#dayview-pick").on("dp.change", function(e){
		var date=$(this).data("DateTimePicker").date(),
			dest="&y=" + moment(date).format("YYYY") + "&m=" + moment(date).format("MM") + "&d=" + moment(date).format("DD");
			window.location.href = dest;
	});

	// Modal Event Click --------------------------
	$(".booked").on("click", function(e){
		var url=$(this).find(".remote-modal").attr("href");
		e.preventDefault();
		$('#eventmodal').modal({
			remote: url
		});
	});

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