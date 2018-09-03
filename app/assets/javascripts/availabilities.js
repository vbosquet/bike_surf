var ready = function () {

  $("#availability_advance_notice").on('change', function() {
    var value = $(this).val();
    if (value != "Le jour même") {
      $("#deadlineSection").hide();
    } else {
      $("#deadlineSection").show();
    }
  });
}

$(document).on("turbolinks:load", ready);
