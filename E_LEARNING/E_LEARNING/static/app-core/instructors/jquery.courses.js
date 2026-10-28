var collapsedGroupsReport = {};

$(function () {
    var table = $('#table-course').DataTable({
        "language": {
            "url": JSR.datatable_language
        },
        dom: "Bfrtip",
        buttons: [exportButtonDataTable],
        pageLength: 150,
        lengthChange: false,
        searching: true,
        ordering: true,
        columnDefs: [
            { "targets": 7, "type": "date-eu" },
            { orderable: false, targets: 0 },
            { orderable: false, targets: 2 },
            { orderable: false, targets: 5 },
            { orderable: false, targets: 8 },
            { orderable: false, targets: 9 },
            { orderable: false, targets: 10 },
        ], order: [[4, 'asc']],
        rowGroup: {
            startRender: function (rows, group) {

                var collapsed = !!collapsedGroupsReport[group];

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
            dataSrc: 4 // Column index for grouping
        },
        initComplete: function (settings, json) {
            self = this.api();
            initCompleteDataTable(self);
            $('table').on('click', 'tr.dtrg-start th div', function () {
                var name = $(this).data('name');
                if (name) {
                    collapsedGroupsReport[name] = !collapsedGroupsReport[name];
                    self.draw(false);
                }
            });
        }
    });
});

