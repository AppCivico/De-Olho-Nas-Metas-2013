var tracker_manager = function () {


};

function reset_button() {
    setTimeout(function () {
        $("#check_token").button('reset');
    });
}

$(document).ready(function () {
    $(".errors").hide();

    $('#check_token').click(function () {
        var car_plate = $("#elm_car_plate").val();
        //         var token       = $("#elm_token").val();
        var invalid = false;

        $(".errors").hide();

        if (car_plate == '') {
            invalid = true;
            $("#car_plate_error").show();
            reset_button();
        }
        //         if(token == '') {
        //             invalid = true;
        //             $("#token_error").show();
        //             reset_button();
        //         }

        if (invalid == false) {
            $.ajax({
                url: "/tracker-manager/form/check_token",
                data: {
                    car_plate: car_plate
                },
                dataType: 'html',
                success: function (result) {
                    $("#car_info").html(result);
                    reset_button();
                },
                complete: function() {
                    $('#vinculate').show();
                }

            });
        }
    });

});