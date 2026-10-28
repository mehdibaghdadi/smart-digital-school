var accordion_subjects;
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
var createAccordion = function () {
    var accordion= $("#accordion").accordion({
        heightStyle: "content",
        active: false,
        collapsible: true,
        icons: { "header": "ui-icon-circle-plus", "activeHeader": "ui-icon-circle-minus" },
        beforeActivate: function (event, ui) {
            var target = event.originalEvent.target;
            var cancel_ui = ($(target).hasClass("ui-header-button"))
            if (cancel_ui) {
                //do your logic
                return false;
            }
        }
    });
    return accordion;
}

// on ready
$(function () {
    accordion_subjects = createAccordion();

    setTimeout(function () {
        $('.accordion-expand-all').trigger("click");
    }, 1000);
});