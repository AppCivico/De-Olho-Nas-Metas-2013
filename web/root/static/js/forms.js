function re_mask() {
    $('.date').mask('99/99/9999');
    $('.datepicker').mask('99/99/9999');
    $('.phone').mask('(99) 9999-9999');
    $('.postal_code').mask('99999-999');
    $('.postal_code_pre').mask('99999-999');
    $('.cpf').mask('999.999.999-99');
    $('#elm_car_plate').mask('aaa-9999');
    $('.mobile_phone').focusout(function () {
        var phone, element;
        element = $(this);
        element.unmask();
        phone = element.val().replace(/\D/g, '');
        if (phone.length > 10) {
            element.mask("(99) 99999-9999");
        } else {
            element.mask("(99) 9999-9999?9");
        }
    }).trigger('focusout');

    if ($('#elm_cnpj').length) {
        $('#elm_cnpj').mask('99.999.999/9999-99');
    }
}

$(document).ready(function () {
    re_mask();
    if ($("#elm_vehicle_body_style_id").length > 0) {
        var body_style_ui = $("<div class='body-style-select'><ul></ul></div>");
        $("#elm_vehicle_body_style_id option").each(function (index, item) {
            if ($(item).attr("value") != "") {
                var sChecked = ($(item).attr("value") == $("#elm_vehicle_body_style_id").val()) ? "checked='checked'" : "";
                $(body_style_ui).find("ul").append("<li class='item body-style-" + $(item).attr("value") + "'><input type='radio' name='body-style-select' value='" + $(item).attr("value") + "' " + sChecked + "><div class='image'></div><div class='text'>" + $(item).html() + "</div></li>");
            }
        });
        $("#elm_vehicle_body_style_id").after($(body_style_ui));
        $("#elm_vehicle_body_style_id").hide();

        $(".body-style-select ul li input").change(function (e) {
            $("#elm_vehicle_body_style_id").val($(this).val());
        });
    }

    if ($('.datepicker').length) {
        $('.datepicker').datepicker({
            language: 'pt-BR',
            format: 'dd/mm/yyyy'
        });
    }

    var $prereg_form = $('#pre_reg');
    if($prereg_form.length) {
        var $job        = $('input:radio[name="job"]');
        var $college    = $('input:radio[name="college"]');
        var $job_val;
        var $coll_val;

        $job.change(function(){
            $job_val = $(this).val();
        });
        $college.change(function(){
            $coll_val = $(this).val();
        });

        $prereg_form.on('submit', function(e) {
            var $ret        = true;
            var $post_job   = $('#elm_postal_code_job').val();
            var $post_col   = $('#elm_postal_code_college').val();

            if( $job.is(':checked') && $job_val == 'yes' ) {
                if(!$post_job) {
                    $('#error_job').show();

                    $ret = false;
                }
            }

            if( $college.is(':checked') && $coll_val == 'yes') {
                if(!$post_col) {
                    $('#error_college').show();

                    $ret = false;
                }
            }

            if(!$ret) {
                e.preventDefault();
            }
        });
    }


    var $contact_form = $('#contact');
    if($contact_form.length) {
        $($contact_form).submit(function(){
            var valid = true;
            $('.contact_error').hide();

            if(!$('#elm_name').val()) {
                $('#name_err').show();
                valid = false;
            }

            if(!$('#elm_email').val()) {
                $('#email_err').show();
                valid = false;
            }

            if(!$('#elm_telephone_number').val()) {
                $('#tel_err').show();
                valid = false;
            }

            if(!$('#elm_motive').val()) {
                $('#motive_err').show();
                valid = false;
            }

            return valid;
        });
    }

});