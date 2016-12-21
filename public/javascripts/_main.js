/* ================= Room Booking System / https://github.com/neokoenig */
!function(e){function t(e){return"undefined"==typeof e?!1:!0}function n(e){return!t(e)||"object"==typeof e}function i(n,i){if(t(i.customValues))for(key in i.customValues)if(n==i.customValues[key])return key;var s=/^0\s(0\/1|\d{1,2})\s(0\/1|\d{1,2}|\*)\s(\d{1,2}|\*|\?)\s(\d{1,2}|\*)\s(\d{1,2}|\?)(\s\*)?$/;if("string"!=typeof n||!s.test(n))return void e.error("cron: invalid initial value");var r=n.split(" ");r=r.splice(1,r.length-1);for(var a=[0,0,1,1,1],l=[59,23,31,12,7],c=0;c<r.length;c++)if("*"!=r[c]&&!/^0\/1$/.test(r[c])&&"?"!=r[c]){var d=parseInt(r[c]);if(!(t(d)&&d<=l[c]&&d>=a[c]))return void e.error("cron: invalid value found (col "+(c+1)+") in "+o.initial)}for(var u in k)if(k[u].test(n))return u;e.error("cron: valid but unsupported cron format. sorry.")}function s(o,s){if(!t(i(s.initial,s)))return!0;if(!n(s.customValues))return!0;if(t(s.customValues))for(key in s.customValues)if(k.hasOwnProperty(key))return e.error("cron: reserved keyword '"+key+"' should not be used as customValues key."),!0;return!1}function r(e){var t=e.data("block"),o=hour=day=month=dow="*",n=t.period.find("select").val();switch(n){case"minute":return["0","0/1","*","*","*","?"].join(" ");case"hour":return o=t.mins.find("select").val(),["0",o,"0/1","*","*","?"].join(" ");case"day":return o=t.time.find("select.cron-time-min").val(),hour=t.time.find("select.cron-time-hour").val(),["0",o,hour,"*","*","?"].join(" ");case"week":return o=t.time.find("select.cron-time-min").val(),hour=t.time.find("select.cron-time-hour").val(),dow=t.dow.find("select").val(),["0",o,hour,"?","*",dow].join(" ");case"month":return o=t.time.find("select.cron-time-min").val(),hour=t.time.find("select.cron-time-hour").val(),day=t.dom.find("select").val(),["0",o,hour,day,"*","?"].join(" ");case"year":return o=t.time.find("select.cron-time-min").val(),hour=t.time.find("select.cron-time-hour").val(),day=t.dom.find("select").val(),month=t.month.find("select").val(),["0",o,hour,day,month,"?","*"].join(" ");default:return n}}for(var a={initial:"0 0/1 * * * ?",minuteOpts:{minWidth:100,itemWidth:30,columns:4,rows:void 0,title:"Minutes Past the Hour"},timeHourOpts:{minWidth:100,itemWidth:20,columns:2,rows:void 0,title:"Time: Hour"},domOpts:{minWidth:100,itemWidth:30,columns:void 0,rows:10,title:"Day of Month"},monthOpts:{minWidth:100,itemWidth:100,columns:2,rows:void 0,title:void 0},dowOpts:{minWidth:100,itemWidth:void 0,columns:void 0,rows:void 0,title:void 0},timeMinuteOpts:{minWidth:100,itemWidth:20,columns:4,rows:void 0,title:"Time: Minute"},effectOpts:{openSpeed:400,closeSpeed:400,openEffect:"slide",closeEffect:"slide",hideOnMouseOut:!0},url_set:void 0,customValues:void 0,onChange:void 0,useGentleSelect:!1},l="",c=0;60>c;c++){var d=10>c?"0":"";l+="<option value='"+c+"'>"+d+c+"</option>\n"}for(var u="",c=0;24>c;c++){var d=10>c?"0":"";u+="<option value='"+c+"'>"+d+c+"</option>\n"}for(var m="",c=1;32>c;c++){if(1==c||21==c||31==c)var h="st";else if(2==c||22==c)var h="nd";else if(3==c||23==c)var h="rd";else var h="th";m+="<option value='"+c+"'>"+c+h+"</option>\n"}for(var p="",v=["January","February","March","April","May","June","July","August","September","October","November","December"],c=0;c<v.length;c++)p+="<option value='"+(c+1)+"'>"+v[c]+"</option>\n";for(var f="",y=["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"],c=0;c<y.length;c++)f+="<option value='"+(c+1)+"'>"+y[c]+"</option>\n";for(var g="",O=["minute","hour","day","week","month","year"],c=0;c<O.length;c++)g+="<option value='"+O[c]+"'>"+O[c]+"</option>\n";var b={minute:[],hour:["mins"],day:["time"],week:["dow","time"],month:["dom","time"],year:["dom","month","time"]},k={minute:/^0\s(0\/1)\s(\*\s){3}\?$/,hour:/^0\s\d{1,2}\s(0\/1)\s(\*\s){2}\?$/,day:/^0\s(\d{1,2}\s){2}(\*\s){2}\?$/,week:/^0\s(\d{1,2}\s){2}\?\s(\*\s)\d{1,2}$/,month:/^0\s(\d{1,2}\s){3}\*\s\?$/,year:/^0\s(\d{1,2}\s){4}\?\s\*$/},w={init:function(o){var n=o?o:{},i=e.extend([],a,n),r=e.extend({},a.effectOpts,n.effectOpts);if(e.extend(i,{minuteOpts:e.extend({},a.minuteOpts,r,n.minuteOpts),domOpts:e.extend({},a.domOpts,r,n.domOpts),monthOpts:e.extend({},a.monthOpts,r,n.monthOpts),dowOpts:e.extend({},a.dowOpts,r,n.dowOpts),timeHourOpts:e.extend({},a.timeHourOpts,r,n.timeHourOpts),timeMinuteOpts:e.extend({},a.timeMinuteOpts,r,n.timeMinuteOpts)}),s(this,i))return this;var c=[],d="",h=i.customValues;if(t(h))for(var v in h)d+="<option value='"+h[v]+"'>"+v+"</option>\n";c.period=e("<span class='cron-period'>Every <select name='cron-period'>"+d+g+"</select> </span>").appendTo(this).data("root",this);var y=c.period.find("select");return y.bind("change.cron",S.periodChanged).data("root",this),i.useGentleSelect&&y.gentleSelect(r),c.dom=e("<span class='cron-block cron-block-dom'> on the <select name='cron-dom'>"+m+"</select> </span>").appendTo(this).data("root",this),y=c.dom.find("select").data("root",this),i.useGentleSelect&&y.gentleSelect(i.domOpts),c.month=e("<span class='cron-block cron-block-month'> of <select name='cron-month'>"+p+"</select> </span>").appendTo(this).data("root",this),y=c.month.find("select").data("root",this),i.useGentleSelect&&y.gentleSelect(i.monthOpts),c.mins=e("<span class='cron-block cron-block-mins'> at <select name='cron-mins'>"+l+"</select> minutes past the hour </span>").appendTo(this).data("root",this),y=c.mins.find("select").data("root",this),i.useGentleSelect&&y.gentleSelect(i.minuteOpts),c.dow=e("<span class='cron-block cron-block-dow'> on <select name='cron-dow'>"+f+"</select> </span>").appendTo(this).data("root",this),y=c.dow.find("select").data("root",this),i.useGentleSelect&&y.gentleSelect(i.dowOpts),c.time=e("<span class='cron-block cron-block-time'> at <select name='cron-time-hour' class='cron-time-hour'>"+u+"</select>:<select name='cron-time-min' class='cron-time-min'>"+l+" </span>").appendTo(this).data("root",this),y=c.time.find("select.cron-time-hour").data("root",this),i.useGentleSelect&&y.gentleSelect(i.timeHourOpts),y=c.time.find("select.cron-time-min").data("root",this),i.useGentleSelect&&y.gentleSelect(i.timeMinuteOpts),c.controls=e("<span class='cron-controls'>&laquo; save <span class='cron-button cron-button-save'></span> </span>").appendTo(this).data("root",this).find("span.cron-button-save").bind("click.cron",S.saveClicked).data("root",this).end(),this.find("select").bind("change.cron-callback",S.somethingChanged),this.data("options",i).data("block",c),this.data("current_value",i.initial),w.value.call(this,i.initial)},value:function(e){if(!e)return r(this);var o=this.data("options"),n=this.data("block"),s=o.useGentleSelect,a=i(e,o);if(!t(a))return!1;if(t(o.customValues)&&o.customValues.hasOwnProperty(a))a=o.customValues[a];else{var l=e.split(" ");l=l.splice(1,l.length-1);for(var c=0;c<l.length;c++)/^0\/1$/.test(l[c])&&(l[c]=void 0),"?"===l[c]&&(l[c]=void 0);for(var d={mins:l[0],hour:l[1],dom:l[2],month:l[3],dow:l[4]},u=b[a],c=0;c<u.length;c++){var m=u[c];if("time"==m){var h=n[m].find("select.cron-time-hour").val(d.hour);s&&h.gentleSelect("update"),h=n[m].find("select.cron-time-min").val(d.mins),s&&h.gentleSelect("update")}else{var h=n[m].find("select").val(d[m]);s&&h.gentleSelect("update")}}}var p=n.period.find("select").val(a);return s&&p.gentleSelect("update"),p.trigger("change"),this}},S={periodChanged:function(){var t=e(this).data("root"),o=t.data("block"),n=(t.data("options"),e(this).val());if(t.find("span.cron-block").hide(),b.hasOwnProperty(n))for(var i=b[e(this).val()],s=0;s<i.length;s++)o[i[s]].show()},somethingChanged:function(){root=e(this).data("root"),t(root.data("options").url_set)?w.value.call(root)!=root.data("current_value")?(root.addClass("cron-changed"),root.data("block").controls.fadeIn()):(root.removeClass("cron-changed"),root.data("block").controls.fadeOut()):root.data("block").controls.hide();var o=root.data("options").onChange;t(o)&&e.isFunction(o)&&o.call(root)},saveClicked:function(){var t=e(this),o=t.data("root"),n=w.value.call(o);t.hasClass("cron-loading")||(t.addClass("cron-loading"),e.ajax({type:"POST",url:o.data("options").url_set,data:{cron:n},success:function(){o.data("current_value",n),t.removeClass("cron-loading"),n==w.value.call(o)&&(o.removeClass("cron-changed"),o.data("block").controls.fadeOut())},error:function(){alert("An error occured when submitting your request. Try again?"),t.removeClass("cron-loading")}}))}};e.fn.cron=function(t){return w[t]?w[t].apply(this,Array.prototype.slice.call(arguments,1)):"object"!=typeof t&&t?void e.error("Method "+t+" does not exist on jQuery.cron"):w.init.apply(this,arguments)}}(jQuery);
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
