var dataTableAssistance;
var collapsedGroups = {};
$(function () {
    var t = $('#table-course').DataTable({
        "language": {
            "url": JSR.datatable_language
        },
        dom: "ftip",
        stateSave: false,
        pageLength: 150,
        lengthChange: false,
        searching: true,
        ordering: true,
        columnDefs: [
            { "targets": 1, "type": "date-eu" },
            { orderable: false, targets: 0 },
            { orderable: false, targets: 2 },
            { orderable: false, targets: 3 },
            { orderable: false, targets: 6 },
        ],
        order: [[1, 'desc']],
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

            enable: true, dataSrc: 1
        },
        initComplete: function (settings, json) {
            self = this.api();
            initCompleteDataTable(self);

            $('table').on('click', 'tr.dtrg-start th div', function () {
                var name = $(this).data('name');
                if (name) {
                    collapsedGroups[name] = !collapsedGroups[name];
                    self.draw(false);
                }
            });

        }
    });

    dataTableAssistance = t;
});

