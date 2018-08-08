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

  $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
    localStorage.setItem('activeTab', $(e.target).attr('href'));
  });

  var activeTab = localStorage.getItem('activeTab');

  if(activeTab){
    $('.nav-tabs a[href="' + activeTab + '"]').tab('show');
  }
}


$(document).on("turbolinks:load", ready);
