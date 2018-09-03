var ready = function () {

  var calculateAverage = function(discount, type, pricingId) {
    $.ajax({
      type: "GET",
      url: '/pricings/calculate_average',
      dataType: 'json',
      data : {discount: discount, average_type: type, pricing_id: pricingId},
      success: function(data) {
        $("#average_" + type).text(data);
        $("#discount_" + type).text(discount);
      },
      error: function(response) {
        console.log(response.status);
      }
    });
  }

  $("#pricing_weekly_discount").on('change paste keyup', function(event) {
    var discount = $(this).val();
    var pricingId = $(this).data('pricing-id');
    var type = "weekly";
    if (!Number.isInteger(parseInt(discount)) || discount === null ||
      discount === 'undefined') {
      discount = 0;
    }
    calculateAverage(discount, type, pricingId);
    event.preventDefault();
  });

  $("#pricing_monthly_discount").on('change paste keyup', function(event) {
    var discount = $(this).val();
    var pricingId = $(this).data('pricing-id');
    var type = "monthly";
    if (!Number.isInteger(parseInt(discount)) || discount === null ||
      discount === 'undefined') {
      discount = 0;
    }
    calculateAverage(discount, type, pricingId);
    event.preventDefault();
  });

}

$(document).on("turbolinks:load", ready);
