$(document).on("turbolinks:load", function(){

    $('#login-btn').on('click', function (event) {
        var email = $('#login .email').val();
        var password = $("#login .password").val();

        $.ajax({
            type: "POST",
            url: "/users/sign_in",
            data: { user: {email: email, password: password}},
            success: function (response) {
            },
            error: function () {
                console.log("error");
            }
        });
    });

    $('#signup-btn').on('click', function (event) {
        var email = $('#signup .email').val();
        var password = $("#signup .password").val();
        var firstname = $('#signup .firstname').val();
        var lastname = $('#signup .lastname').val();

        $.ajax({
            type: "POST",
            url: "/users",
            data: { user: {email: email, password: password, firstname: firstname, lastname: lastname}},
            success: function (response) {
            },
            error: function () {
                console.log("error");
            }
        });
    });

    setTimeout(function() {
        $('.alert').fadeOut('fast');
    }, 2000);

    $('.date').datetimepicker({
        format: 'LT',
        locale: 'fr',
        icons: {
          up: "fa fa-chevron-circle-up",
          down: "fa fa-chevron-circle-down",
          next: 'fa fa-chevron-circle-right',
          previous: 'fa fa-chevron-circle-left'
        }
    });
});
