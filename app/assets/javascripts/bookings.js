var ready = function () {

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

}

$(document).on("turbolinks:load", ready);
