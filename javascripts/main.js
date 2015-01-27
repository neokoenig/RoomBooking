/* ================= Room Booking System / https://github.com/neokoenig */

$(document).ready(function(){

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
		showToday: true,
		minuteStepping: 5,
		sideBySide: true,
		useSeconds: false,
		useCurrent: true
	});

	$('#event-start').on("dp.change", function(e){
		$('#event-end').data("DateTimePicker").setMinDate(e.date);
	});

	$('#event-end').on("dp.change", function(e){
		$('#event-start').data("DateTimePicker").setMaxDate(e.date);
	});

	$("#event-allDay").on("click", function(e){
		var sd=$('#event-start').data("DateTimePicker").getDate(),
			ed=$('#event-end').data("DateTimePicker").getDate();
		$("#event-start").data("DateTimePicker").setDate(moment(
			{y: sd.year(), M: sd.month(), d: sd.date(), h: 0, m: 0}
		));
		$("#event-end").data("DateTimePicker").setDate(moment(
			{y: ed.year(), M: ed.month(), d: ed.date(), h: 23, m: 59}
		));
	});

	$("#dayview-pick").datetimepicker({
		showToday: true,
		pickTime: false
	});

	$("#dayview-pick").on("dp.change", function(e){
		var date=$(this).data("DateTimePicker").getDate(),
			dest="?y=" + moment(date).format("YYYY") + "&m=" + moment(date).format("MM") + "&d=" + moment(date).format("DD");
			window.location.href = dest;
	});

	// Modal Event Click --------------------------
	$(".booked").on("click", function(e){
		var url=$(this).find(".remote-modal").attr("href");
		e.preventDefault();
		$('#eventmodal').modal({
			remote: url + "?format=json"
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