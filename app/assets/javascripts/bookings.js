var ready = function () {

  var displayTotalPrice = function(event) {
    var listingId = $("#listingId").val();
    var button = $(".bookingButton");
    var startDate = $('#startDate').data('date');
    var endDate = $('#endDate').data('date');

    if (startDate != 'undefined' && endDate != 'undefined') {
      $.ajax({
        type: "GET",
        url: '/bookings/resume?listing_id='+listingId+'&start_date='+startDate+'&end_date='+endDate,
        dataType: 'html',
        success: function(xhr, statusText) {
          $('.resume').remove();
          $(button).before(xhr);
        },
        error: function(response) {
          console.log(response.status);
        }
      });
    }

    event.preventDefault();
  };

  var calculateTotalPrice = function(event) {
    var listingId = $("#listingId").val();
    var startDate = $('#startDate').data('date');
    var endDate = $('#endDate').data('date');

    if(startDate != 'undefined' && endDate != 'undefined') {
      $.ajax({
        type: "GET",
        url: '/bookings/calculate',
        dataType: 'json',
        data : {start_date: startDate, end_date: endDate, listing_id: listingId},
        success: function(data) {
          console.log(data);
          // $('#totalPrice').val(data);
        },
        error: function(response) {
          console.log(response.status);
        }
      });
    }

    event.preventDefault();
  };

  var convertDates = function(dates) {
    var converted_dates = [];
    $.each(dates, function(index, value) {
      converted_dates.push(moment(value));
    });
    return converted_dates;
  }

  $('.date').datetimepicker({
    format: 'L',
    locale: 'fr',
    minDate: Date.now(),
    disabledDates: convertDates(gon.disabled_dates),
    icons: {
      next: "fa fa-chevron-circle-right",
      previous: "fa fa-chevron-circle-left"
    }
  });

  $('#startDate').on('dp.change', function(event) {
    $('#endDate').data("DateTimePicker").minDate(event.date);
    // displayTotalPrice(event);
    calculateTotalPrice(event);
  });

  $('#endDate').on('dp.change', function(event) {
    $('#startDate').data("DateTimePicker").maxDate(event.date);
    // displayTotalPrice(event);
    calculateTotalPrice(event);
  });

}

$(document).on("turbolinks:load", ready);
