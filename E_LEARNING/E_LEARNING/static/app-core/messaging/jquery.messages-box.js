var collapsedGroups = {};
var initTable = false;
var dataTableConfiguration = function () {
    return {
        "language": {
            "url": JSR.datatable_language
        },
        dom: "ipftip",
        //dom: '<if<t>ip>',
        pageLength: 100,
        paging: true,
        pagingType: 'numbers',
        lengthChange: false,
        searching: true,
        ordering: false,
        columnDefs: [
            { visible: false, targets: 7 }
        ],
        rowGroup: {
            startRender: function (rows, group) {
                collapsedGroups[group] = collapsedGroups[group] == undefined ? false : !!collapsedGroups[group];
                var collapsed = collapsedGroups[group];

                rows.nodes().each(function (r) {
                    r.style.display = collapsed ? 'none' : '';
                });

                var toggleClass = collapsed ? ' fa-plus-circle text-success ' : ' fa-minus-circle text-info ';

                var title = $('<div/>').append('<div class="text-left text-xs"><i class="fa' + toggleClass + '  mr-2"></i>'
                    + group + ' <span class="text-gray">(' + rows.count() + ')</span></div>')
                    .addClass('cursor-pointer')
                    .attr('data-name', group)
                    .toggleClass('collapsed ', collapsed);
                return title;
            },
            enable: true,
            dataSrc: 7
        },
        initComplete: function (settings, json) {
            self = this.api();
            initCompleteDataTable(self);

           // $('.dataTables_paginate').addClass(' bg-light p-0 pt-2 pb-2 border-top');

            if (!initTable) {
                $('table').on('click', 'tr.dtrg-start th div', function () {
                    var name = $(this).data('name');
                    if (name) {
                        collapsedGroups[name] = !collapsedGroups[name];
                        self.draw(false);
                    }
                });
                initTable = true;

            }
        }
    };
};


