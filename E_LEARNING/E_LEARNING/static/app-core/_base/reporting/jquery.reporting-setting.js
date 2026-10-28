var collapsedGroupsReport = {};
var groupZoneId = "#groupZone";
var enableGroup = true;

var createReportDataTable = function (id, json, columns, groupbyColumn = -1) {
    if ($.fn.DataTable.isDataTable(id)) {
        $(id).DataTable().clear().destroy();
    }

    enableGroup = groupbyColumn > -1;

    $(id).DataTable({
        data: json,
        columns: columns,

        language: {
            url: JSR.datatable_language
        },
        dom: "Bpfrtip",
        buttons: [exportButtonDataTable],
        pageLength: 20,
        lengthChange: false,
        searching: true,
        order: enableGroup && columns[groupbyColumn] ? [[groupbyColumn, 'asc']] : [[1, 'asc']],
        ordering: true,
        rowGroup: {
            startRender: function (rows, group) {
                if (!enableGroup) return;

                var collapsed = !!collapsedGroupsReport[group];

                rows.nodes().each(function (r) {
                    r.style.display = collapsed ? 'none' : '';
                });

                var toggleClass = collapsed ? ' fa-plus-circle text-success ' : ' fa-minus-circle text-info ';

                var safeGroup = typeof group === "string" ? group : String(group || "");
                var text_title = "<div class='d-inline-block'>" + safeGroup.replace("text-clamp", "") + "</div>";


                var title = $('<div/>').append('<div class="text-left text-xs text-dark"><i class="fa' + toggleClass + '  mr-2"></i>'
                    + text_title + ' <span class="text-red">(' + rows.count() + ')</span></div>')
                    .addClass('cursor-pointer')
                    .attr('data-name', group)
                    .toggleClass('collapsed ', collapsed);
                return title;
            },
            enable: enableGroup,
            dataSrc: enableGroup && columns[groupbyColumn] ? columns[groupbyColumn].data : null
        },
        initComplete: function (settings, json) {
            var self = this.api();
            initCompleteDataTable(self);

            // Toggle collapse
            $('table').off('click', 'tr.dtrg-start th div').on('click', 'tr.dtrg-start th div', function () {
                var name = $(this).data('name');
                if (name) {
                    collapsedGroupsReport[name] = !collapsedGroupsReport[name];
                    self.draw(false);
                }
            });

            // Init Drag & Drop for grouping
            initDynamicGrouping(columns, id);
        }
    });
};

// 🧲 Fonction de création des colonnes drag & drop
function initDynamicGrouping(columns, tableId) {
    const $groupZone = $(groupZoneId);
    const $columnsList = $("#columnsList");
    $columnsList.empty();



    // 1. Colonnes du thead comme draggable
    $(`${tableId} thead th`).each(function (i) {
        const $th = $(this);
        if (!$th.hasClass('group-column-header')) {
            $th.addClass('group-column-header')
                .attr('data-index', i)
                .attr('title', `${JSR.drag_here_to_group}`)
                .draggable({
                    cursor: 'grabbing',
                    helper: function () {
                        return $('<div class="group-column-header helper-group-move bg-dark border p-2 rounded shadow-sm">')
                            .text($th.text())
                            .attr('data-index', i); // ✨ important pour drop
                    },
                    appendTo: 'body',
                    revert: 'invalid',
                    cursorAt: { top: 15, left: -5 } // 🔥 positionne le helper proche du curseur
                });
        }
    });

    // 2. Zone de drop
    $groupZone.droppable({
        accept: '.group-column, .group-column-header',
        hoverClass: 'border-success',
        drop: function (event, ui) {
            event.stopPropagation(); // ✅ évite conflits de propagation

            const index = parseInt(ui.helper.attr('data-index'));
            const name = ui.helper.text();

            if (isNaN(index)) {
                console.log("Colonne invalide.");
                return;
            }

            $(this)
                .empty()
                .html(`✅ ${JSR.grouped_by} : <strong>${name}</strong>`);

            const data = $(tableId).DataTable().rows().data().toArray();
            createReportDataTable(tableId, data, columns, index);
        }

    });
}


// Pour déclencher le lien externe
const reporting_course_url = app_settings.reporting_course_view_url;
const reporting_monitoring_url = app_settings.reporting_monitoring_student_view_url;
const reporting_quiz_url = app_settings.reporting_quiz_student_view_url;

var courselinkReport = function (school_subject_id, course_id, student_id) {
    student_id = student_id || 0;
    var url = "{0}/{1}/{2}/{3}".format(reporting_course_url, school_subject_id, course_id, student_id);
    window.open(url, '_blank');
}

var quizlinkReport = function ( quiz_id, student_id) {
    student_id = student_id || 0;
    var url = "{0}/{1}/{2}".format(reporting_quiz_url, quiz_id, student_id);
    window.open(url, '_blank');
}

var monitoringlinkReport = function (student_id) {
    var url = "{0}/{1}".format(reporting_monitoring_url, student_id);
    window.open(url, '_blank');

}
