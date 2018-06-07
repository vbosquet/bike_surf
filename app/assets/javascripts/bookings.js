var ready = function () {

  var displayTotalPrice = function(event) {
    var listingId = $("#listingId").val();
    var button = $(".bookingButton");
    var startDate = $('#startDate').data('date');
    var endDate = $('#endDate').data('date');

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

    event.preventDefault();
  };

  var calculateTotalPrice = function(event) {
    var listingId = $("#listingId").val();
    var startDate = $('#startDate').data('date');
    var endDate = $('#endDate').data('date');

    $.ajax({
      type: "GET",
      url: '/bookings/calculate',
      dataType: 'json',
      data : {start_date: startDate, end_date: endDate, listing_id: listingId},
      success: function(data) {
        $('#totalPrice').val(data);
      },
      error: function(response) {
        console.log(response.status);
      }
    });

    event.preventDefault();
  };

  $('.date').datetimepicker({
    format: 'L',
    locale: 'fr',
    defaultDate: Date.now(),
    icons: {
      next: "fa fa-chevron-circle-right",
      previous: "fa fa-chevron-circle-left"
    }
  });

  $('#endDate, #startDate').on('dp.change', function(event) {
    displayTotalPrice(event);
    calculateTotalPrice(event);
  });
}


$(document).on("turbolinks:load", ready);
