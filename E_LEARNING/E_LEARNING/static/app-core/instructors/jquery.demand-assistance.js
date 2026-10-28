var dataTableAssistance;
var collapsedGroups = {};
var selectedGroups = {};

var collapsedGroupsClick = function (self) {
    $('table').on('click', 'tr.dtrg-start th div div.group-data', function () {
        var name = $(this).data('name');
        if (name) {
            collapsedGroups[name] = !collapsedGroups[name];           
            self.draw(false);
        }
    });
}
var addedGroupSelected = function () {
    $('.i-calendar-week').addClass('fa-bounce');
    setTimeout(function () {
        $('.i-calendar-week').removeClass('fa-bounce');
    }, 1000);
}
$(function () {


    dataTableAssistance = $('#table-course').DataTable({
        "language": {
            "url": JSR.datatable_language
        },
        dom: "ftip",
        stateSave: false,
        pageLength: 150,
        lengthChange: true,
        searching: true,
        ordering: true,
        columnDefs: [
            { "targets": 1, "type": "date-eu" },
            { orderable: false, targets: 0 },
            { orderable: false, targets: 2, type: "date-eu" },
            { orderable: false, targets: 3 },
            { orderable: false, targets: 6 },
            { visible: false, targets: 7 },
            { visible: false, targets: 8 },
            { visible: false, targets: 9 },
            { visible: false, targets: 10, type: "date-eu" },
        ],
        order: [
            [7, 'desc'],
            [1, 'desc'],
            [10, 'desc'],
        ],
        rowGroup: {
            startRender: function (rows, group) {

                group = group == '01-01-7000' ? JSR.without_schedule : group;
                var undefinedGroup = collapsedGroups[group] == undefined;
                if (undefinedGroup)
                    collapsedGroups[group] = false;

                var collapsed = !!collapsedGroups[group];

                rows.nodes().each(function (r) {
                    r.style.display = collapsed ? 'none' : '';
                });

                var toggleClass = collapsed ? ' fa-plus-circle text-success ' : ' fa-minus-circle text-info ';

                var ids = rows.ids().join();
                var count_ids = rows.count();

                var title = $('<div/>').append('<i class="fa' + toggleClass + '  mr-2"></i>'
                    + group + ' <span class="text-red">(' + count_ids + ')</span>').addClass('cursor-pointer')
                    .attr('data-name', group)
                    .addClass(' group-data text-left text-xs')
                    .toggleClass('collapsed ', collapsed);;

                var id_ckbx = "rb" + ids.replaceAll(',', '-');
                var selectedG = !!selectedGroups[id_ckbx];

                var css_selected = 'bg-dark rounded';

                var menuSelectClick = function (event, arg) {
                    var o = $(this);
                    var checked = o.data("checked") == '1';

                    var parent = $(this).parent();

                    var ids = parent.data("ids");

                    var rslt = angular.element(this)
                        .scope()
                        .checkboxGroupClick('{0}'.format(ids), checked, arg);

                    if (rslt)
                        parent.parent().toggleClass(css_selected, checked);
                    else
                        checked = false;

                    selectedGroups[id_ckbx] = checked;


                }
                var menuDDL = $('<div class="dropdown-menu dropdown-menu-right" role="menu" style="" />')
                    .attr('id', id_ckbx)
                    .attr('name', id_ckbx)
                    .attr('data-ids', ids)
                    .append(
                        $('<a class="dropdown-item dropdown-item-select-all cursor-pointer" data-checked="1" role="button" ><i class="fas fa-layer-group mr-2 text-green"></i>'
                            + JSR.all_group + '</a>')
                            .on('click', menuSelectClick)
                    )
                    .append('<div class="dropdown-divider"></div>')
                    .append(
                        $('<a class="dropdown-item dropdown-item-unselect-all cursor-pointer" data-checked="0" role="button" ><i class="fas fa-times-circle mr-2 text-red"></i>'
                            + JSR.uncheck_all + '</a>')
                            .on('click', menuSelectClick)
                    );

                var checkL = $('<div/>')
                    .addClass('float-right btn-group text-sm p-1 text-bold  elevation-1 border rounded-left')
                    .append(
                        $('<small class="" role="button" data-toggle="dropdown" aria-expanded="false">'
                            + '<b>{0}</b> <i class= "mr-1 ml-1 fa fa-ellipsis-v" ></i>'.format(JSR.check)
                            + '</small>'
                        )
                    ).append(menuDDL).addClass(selectedGroups[id_ckbx] ? css_selected : '');

                var title_div = $('<div/>').append(checkL).append(title);


                return title_div;
            },
            enable: true,
            dataSrc: 7
        },
        initComplete: function (settings, json) {
            self = this.api();
            initCompleteDataTable(self);
            collapsedGroupsClick(self);

        }
    });


});

