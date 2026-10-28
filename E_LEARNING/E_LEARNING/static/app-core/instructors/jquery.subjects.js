$(function () {
    $("#accordion").accordion({
        heightStyle: "content",
        active: false,
        collapsible: true,
        icons: { "header": "ui-icon-circle-plus", "activeHeader": "ui-icon-circle-minus" }
    });

    setTimeout(function () {
        $('.accordion-expand-all').trigger("click");
    }, 1000);
});

$('.accordion-expand-all').click(function () {

    var acc = $(".accordion-content-active");
    if (acc.length > 0)
        acc.slideDown("slow");
    else
        toastr.warning(JSR.alert_no_level_class_selected)
});
$('.accordion-collapse-all').click(function () {

    $(".accordion-content-active").slideUp("slow");
});