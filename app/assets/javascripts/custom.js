var ready = function () {

  /*setTimeout(function() {
      $('.alert').fadeOut('fast');
  }, 2000);*/

  $('.time').datetimepicker({
      format: 'LT',
      locale: 'fr',
      icons: {
        up: "fa fa-chevron-circle-up",
        down: "fa fa-chevron-circle-down",
        next: 'fa fa-chevron-circle-right',
        previous: 'fa fa-chevron-circle-left'
      }
  });
}


$(document).on("turbolinks:load", ready);
