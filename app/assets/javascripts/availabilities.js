var displayDeadlineSection = function () {
  var value = $(".advance-notice").val();
  if (value != "Le jour même") {
    $(".deadline").hide();
  } else {
    $(".deadline").show();
  }
}

var ready = function () {

  displayDeadlineSection();

  $(".advance-notice").on('change', function() {
    displayDeadlineSection();
  });
}

$(document).on("turbolinks:load", ready);
