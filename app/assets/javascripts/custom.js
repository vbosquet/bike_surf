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
        format: 'LT'
    });

    initMap();
    function initMap() {
        var latitude = 0;
        var longitude = 0;
        if(gon.latitude != null) {
            latitude = gon.latitude;
        }

        if(gon.longitude != null) {
            longitude = gon.longitude;
        }
        console.log(latitude);
        console.log(longitude);
        var position = {lat: latitude, lng: longitude};
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 15,
          center: position
      });
        var marker = new google.maps.Marker({
          position: position,
          map: map
      });
    }
});