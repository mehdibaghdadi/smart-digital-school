// DataTable Export to Excel Button Configuration
var exportButtonDataTable = {
    extend: 'excelHtml5',
    className: 'btn-xs p-1 pl-2 pr-2 border elevation-1 rounded mt-2 ml-1 text-uppercase text-bold text-xs',
    autoFilter: true,
    text: `<small class="text-xs" title="${JSR.download.toUpperCase()} EXCEL"><i class="text-sm fa fa-file-excel text-success mr-2 "></i>Excel</small>`,
    exportOptions: {
        columns: function (idx, data, node) {
            var columnHasHideprint = false;

            $('table thead tr').each(function () {
                var th = $(this).find('th:eq(' + idx + ')');
                if (th.find('.hide-print').length > 0 || th.hasClass('hide-print')) {
                    columnHasHideprint = true;
                    return false;
                }
            });

            if (!columnHasHideprint)
                $('table tbody tr').each(function () {
                    var td = $(this).find('td:eq(' + idx + ')');
                    if (td.find('.hide-print').length > 0 || td.hasClass('hide-print') || td.find('img').length > 0) {
                        columnHasHideprint = true;
                        return false;
                    }
                });

            return !columnHasHideprint;
        }

    }
};

// Initialize DataTable with custom search input and buttons
var initCompleteDataTable = function (self) {
    var $table = $(self.table().node());
    var $filterContainer = $table.closest('.dataTables_wrapper').find('.dataTables_filter');

    $("#id_body").removeClass("d-none");
    $filterContainer.parent().attr("width", "100%");

    var $clearButton = $('<button>')
        .html('<i class="fas fa-1x fa-times-circle m-0 ml-1 mr-1"></i>')
        .attr("type", "button")
        .attr("title", JSR.search_cancel)
        .addClass("btn btn-dark btn-xs border-0")
        .click(function () {
            input.val('');
            self.search(input.val()).draw();
        });

    var $searchButton = $('<button>')
        .html('OK')
        .attr("type", "button")
        .attr("title", JSR.search_start)
        .addClass("btn btn-danger btn-xs p-0 pl-3 pr-3")
        .click(function () {
            self.search(input.val()).draw();
        });

    var $input_group_append_add = $('<div class="input-group-append" />').append($searchButton);
    var $input_group_append_clear = $('<div class="input-group-append" />').append($clearButton);
    var $input_group = $('<div />').addClass('input-group p-0 pb-2 mx-auto').css("max-width", "350px");

    var input = $filterContainer.find('input')
        .attr("autocomplete", "off")
        .attr("type", "text")
        .attr("placeholder", JSR.search + " ...")
        .addClass("bg-light form-control form-control-sm m-0 border border-dark")
        .unbind()
        .on('keypress', function (e) {
            if (e.which == 13) {
                self.search(input.val()).draw();
            }
        });

    input.closest('label').addClass('d-none');

    $filterContainer.empty().append($input_group.append(input, $input_group_append_clear, $input_group_append_add));

    return self;
}
