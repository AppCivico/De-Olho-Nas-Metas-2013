$(document).ready(function () {
    $("#elm_cnh_code").focus(function (e) {
        $(".cnh-hint").fadeIn("slow");
        $(".cnh-arrow").removeClass("hide");
        $(".cnh-arrow").addClass("cnh");
        $(".cnh-arrow").removeClass("validade");
        $(".cnh-arrow2").addClass("hide");
    });
    $("#elm_cnh_validity").focus(function (e) {
        $(".cnh-hint").fadeIn("slow");
        $(".cnh-arrow").removeClass("hide");
        $(".cnh-arrow").removeClass("cnh");
        $(".cnh-arrow").addClass("validade");
        $(".cnh-arrow2").addClass("hide");
    });
    $("#elm_first_driver_license").focus(function (e) {
        $(".cnh-hint").fadeIn("slow");
        $(".cnh-arrow").addClass("hide");
        $(".cnh-arrow2").removeClass("hide");
        $(".cnh-arrow2").addClass("data");
    });
    $("#elm_cnh_code,#elm_cnh_validity,#elm_first_driver_license").blur(function (e) {
        $(".cnh-hint").fadeOut("fast");
    });

});