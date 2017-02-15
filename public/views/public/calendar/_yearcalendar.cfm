<cfoutput>
<cfset settings=application.rbs.settings>
    <!--- This is just a way of getting settings from the DB into Javascript a bit more easily --->
      <div id="settings"
        data-dataurl="#urlFor(route="calendarYearcalendardata", key=params.key)#"
      ></div>
      <div id="notices"></div>

#includePartial("filters")#
#includePartial("calendar")#
</cfoutput>
<cfsavecontent variable="request.js.yearcalendar">
<cfoutput>
<cfif request.lang.currentCode NEQ "en">
    #javascriptIncludeTag("locales/yearcalendar/bootstrap-year-calendar.#request.lang.currentCode#")#
</cfif>
</cfoutput>
<script>
$(function() {
    var currentYear = new Date().getFullYear();
    var settings=$("#settings").data();
     var filters={}

     $("#filters .locationfilter").on("click", function(e){
        var data=$(this).data();
        console.log(data);
        $("#notices").html("");
        setFilterData(data.filtertype, data.id);
        calendar.getDataSource();
        e.preventDefault();
      });

    function getEvents(){
        $.ajax({
        url: settings.dataurl,
        data: getFilterData,
        cache: false,
        success: function(data){
            var r=[];
            // Parse ISO date as passed by cf
            for(var d in data){
                var a = data[d].startDate.split('-').map(Number);
                var b = data[d].endDate.split('-').map(Number);
                r.push({
                    startDate:new Date(a[0], a[1]-1, a[2]),
                    endDate: new Date(b[0], b[1]-1, b[2])
                });
            }
            console.log(r);
            return r;
        },
        error: fetchError
        });
    }

    function setFilterData(filtertype,id){
         filters= {
          filtertype: filtertype,
          id: id
         }
      }

      function getFilterData(){
         return filters;
      }

      function fetchError(){
        var h="<div class='alert alert-warning alert-dismissible '><button type='button' class='close' data-dismiss='alert' aria-hidden='true'><i class='fa fa-times'></i></button><h4><i class='icon fa fa-exclamation-triangle'></i>Error</h4>Error Fetching Bookings...</div>";
          $("#notices").html(h);
      }
      var eventData=getEvents();
      /*function eventData(){
        var data=[
            {
                endDate: new Date(2017,01,12),
                startDate: new Date(2017,01,15)
            },
            {
                endDate: new Date(2017,01,16),
                startDate: new Date(2017,01,15)
            },
            {
                endDate: new Date(2017,01,17),
                startDate: new Date(2017,01,16)
            },
            {
                endDate: new Date(2017,01,20),
                startDate: new Date(2017,01,18)
            },
            {
                endDate: new Date(2017,01,25),
                startDate: new Date(2017,01,22)
            }
        ];
        return data
      }*/
    $('#calendar').calendar({
        language: $('html').attr('lang'),
        style:'background',
        alwaysHalfDay: true,
        dataSource: eventData,
        customDayRenderer: function(element, date) {
            // if(date.getTime() == date.now()) {
            //    $(element).css('border', '2px solid blue');
            //}
        }
    });

    /*

    $('#update-current-year').click(function() {
        $('#calendar').data('calendar').setYear($('#current-year').val());
    });

    $('#get-current-year').click(function() {
        alert($('#calendar').data('calendar').getYear());
    });

    $('#update-min-date').click(function() {
        $('#calendar').data('calendar').setMinDate($('#min-date')[0].valueAsDate);
    });

    $('#get-min-date').click(function() {
        alert($('#calendar').data('calendar').getMinDate());
    });

    $('#update-max-date').click(function() {
        $('#calendar').data('calendar').setMaxDate($('#max-date')[0].valueAsDate);
    });

    $('#get-max-date').click(function() {
        alert($('#calendar').data('calendar').getMaxDate());
    });

    $('#update-language').click(function() {
        $('#calendar').data('calendar').setLanguage($('#language').val());
    });

    $('#get-language').click(function() {
        alert($('#calendar').data('calendar').getLanguage());
    });

    $('#update-style').click(function() {
        if($('#style-border').prop('checked')) {
            $('#calendar').data('calendar').setStyle('border');
            $('#round-range-limit').prop('disabled', true);
            $('#always-half-day').prop('disabled', true);
        }
        else {
            $('#calendar').data('calendar').setStyle('background');
            $('#round-range-limit').prop('disabled', false);
            $('#always-half-day').prop('disabled', false);
        }
    });

    $('#get-style').click(function() {
        alert($('#calendar').data('calendar').getStyle());
    });

    $('#update-overlap').click(function() {
        $('#calendar').data('calendar').setAllowOverlap($('#allow-overlap').prop('checked'));
    });

    $('#get-overlap').click(function() {
        alert($('#calendar').data('calendar').getAllowOverlap());
    });

    $('#update-range-selection').click(function() {
        $('#calendar').data('calendar').setEnableRangeSelection($('#enable-range-selection').prop('checked'));
    });

    $('#get-range-selection').click(function() {
        alert($('#calendar').data('calendar').getEnableRangeSelection());
    });

    $('#update-week-number').click(function() {
        $('#calendar').data('calendar').setDisplayWeekNumber($('#display-week-number').prop('checked'));
    });

    $('#get-week-number').click(function() {
        alert($('#calendar').data('calendar').getDisplayWeekNumber());
    });

    $('#update-round-limit').click(function() {
        $('#calendar').data('calendar').setRoundRangeLimits($('#round-range-limit').prop('checked'));
    });

    $('#get-round-limit').click(function() {
        alert($('#calendar').data('calendar').getRoundRangeLimits());
    });

    $('#update-half-day').click(function() {
        $('#calendar').data('calendar').setAlwaysHalfDay($('#always-half-day').prop('checked'));
    });

    $('#get-half-day').click(function() {
        alert($('#calendar').data('calendar').getAlwaysHalfDay());
    });
    */
});
</script>
</cfsavecontent>
