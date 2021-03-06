function eventCalendar() {
  var url = $('#calendar').data('url');
  return $('#calendar').fullCalendar({
    defaultView: 'month',
    locale: 'fr',
    buttonText:
    {
      today: "aujourd'hui",
      month: "mois",
      week: "semaine",
      day: "jour",
      list: "liste"
    },
    events : {
      url: url
    }
  });
};

function clearCalendar() {
  $('#calendar').fullCalendar('delete');
  $('#calendar').html('');
};

$(document).on('turbolinks:load', eventCalendar);
$(document).on('turbolinks:before-cache', clearCalendar);
