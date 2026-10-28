var collapsedGroups = {};

$(function () {
    $('#table-instructor').DataTable({
        "language": {
            "url": JSR.datatable_language
        },
        dom: "Bfrtip",
        buttons: [exportButtonDataTable],
        pageLength: 150,
        lengthChange: false,
        searching: true,
        ordering: false,
        order: [[5, 'desc'], [1, 'asc']],
        rowGroup: {
            startRender: function (rows, group) {

                var collapsed = !!collapsedGroups[group];

                rows.nodes().each(function (r) {
                    r.style.display = collapsed ? 'none' : '';
                });

                var toggleClass = collapsed ? ' fa-plus-circle text-success ' : ' fa-minus-circle text-info ';

                var title = $('<div/>').append('<div class="text-left text-xs"><i class="fa' + toggleClass + '  mr-2"></i>'
                    + group + ' <span class="text-red">(' + rows.count() + ')</span></div>')
                    .addClass('cursor-pointer')
                    .attr('data-name', group)
                    .toggleClass('collapsed ', collapsed);
                return title;

            },
            enable: true,
            dataSrc: 5
        },

        initComplete: function (settings, json) {

            self = this.api();
            initCompleteDataTable(self);
            self.columns(".filterhead")
                .every(function (i) {
                    var column = this;
                    var th = $("tr.filter-tr > th").eq(i);
                    var selectHtml = '<select class="bg-light form-control form-control-sm p-0 d-block border text-uppercase"><option class="text-center" value="">- {0} -</option></select>'.format(JSR.filter1);
                    var select = $(selectHtml)
                        .appendTo(th)
                        .on('change', function (e) {
                            e.stopPropagation();

                            var val = $.fn.dataTable.util.escapeRegex($(this).val());
                            column.search(val ? '^' + val + '$' : '', true, false).draw();
                        });

                    column
                        .data()
                        .unique()
                        .sort()
                        .each(function (d, j) {

                            select.append('<option value="' + d + '">' + d + '</option>');
                        });
                });
            $('table').on('click', 'tr.dtrg-start th div', function () {
                var name = $(this).data('name');
                if (name) {
                    collapsedGroups[name] = !collapsedGroups[name];
                    self.draw(false);
                }
            });

        }
    });
});

