var select2_cities = {};
$(document).ready(function () {

    select2_cities = $('#city-selector').select2({
        templateSelection: function (data) {
            var text = data.text ? data.text : "";
            var optgroup = data.element.parentNode.label ? data.element.parentNode.label : "";
            return $("<b>" + text + "</b>" + " - <span class='text-gray'>" + optgroup + " </span>");
        }
    }).on('select2:open', function () {
        $('input.select2-search__field').prop('placeholder', JSR.search + ' ...').addClass("bg-warning");
        setTimeout(function () {
            var groups = $('.select2-container--open .select2-results__group');
            groups.siblings().toggle();
            groups.on('click', function () {
                $(this).siblings().toggle("fast");
            });
        }, 500);
    });

    $('.ddl-selector').each(function () {
        $(this).select2({
            templateSelection: function (data) {
                var text = data.text ? data.text : "";
                return $("<b>" + text + "</b>");
            }

        }).on('select2:open', function () {
            $('input.select2-search__field').prop('placeholder', JSR.search + ' ...').addClass("bg-warning");

        });

    });

});
