var ready = function () {

  var calculateAverage = function(discount, type, basePrice) {
    $.ajax({
      type: "GET",
      url: '/pricings/calculate_average',
      dataType: 'json',
      data : {discount: discount, average_type: type, base_price: basePrice},
      success: function(data) {
        $("#average_" + type).text(data);
        $("#discount_" + type).text(discount);
      },
      error: function(response) {
        console.log(response.status);
      }
    });
  }

  var calculateWeeklyAverage = function(discount, basePrice) {
    var type = "weekly";
    if (!Number.isInteger(parseInt(discount)) || discount === null ||
      discount === 'undefined') {
      discount = 0;
    }
    calculateAverage(discount, type, basePrice);
    event.preventDefault();
  }

  var calculateMonthlyAverage = function(discount, basePrice) {
    var type = "monthly";
    if (!Number.isInteger(parseInt(discount)) || discount === null ||
      discount === 'undefined') {
      discount = 0;
    }
    calculateAverage(discount, type, basePrice);
    event.preventDefault();
  }

  $("#pricing_weekly_discount").on('change paste keyup', function(event) {
    calculateWeeklyAverage($(this).val(), $(this).data('base-price'));
  });

  $("#listing_pricing_attributes_weekly_discount").on('change paste keyup', function(event) {
    calculateWeeklyAverage($(this).val(), $("#listing_pricing_attributes_base_price").val());
  });

  $("#pricing_monthly_discount").on('change paste keyup', function(event) {
    calculateMonthlyAverage($(this).val(), $(this).data('base-price'));
  });

  $("#listing_pricing_attributes_monthly_discount").on('change paste keyup', function(event) {
    calculateMonthlyAverage($(this).val(), $("#listing_pricing_attributes_base_price").val());
  });

  $("#listing_pricing_attributes_base_price").on('change paste keyup', function(event) {
    calculateWeeklyAverage($("#listing_pricing_attributes_weekly_discount").val(), $(this).val());
    calculateMonthlyAverage($("#listing_pricing_attributes_monthly_discount").val(), $(this).val());
  });

}

$(document).on("turbolinks:load", ready);
