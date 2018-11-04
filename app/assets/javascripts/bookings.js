var disabledDates = [];

function convertDates() {
  $.each(gon.disabled_dates, function(index, value) {
    disabledDates.push(moment(value));
  });
};

function eventDateTimePicker() {
  return $('.date').datetimepicker({
    format: 'L',
    locale: 'fr',
    minDate: Date.now(),
    disabledDates: disabledDates,
    icons: {
      next: "fa fa-chevron-circle-right",
      previous: "fa fa-chevron-circle-left"
    }
  });
};

function clearDateTimePicker() {
  $('.date').datetimepicker('destroy');
};

$(document).on('turbolinks:load', convertDates);
$(document).on('turbolinks:load', eventDateTimePicker);
$(document).on('turbolinks:before-cache', clearDateTimePicker);
