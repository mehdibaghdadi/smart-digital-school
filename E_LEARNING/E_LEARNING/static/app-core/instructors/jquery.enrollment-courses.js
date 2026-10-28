$(function () {
    $('#table-course').DataTable({
        "language": {
            "url": JSR.datatable_language
        },
        dom: "Bfrtip",
        buttons: [exportButtonDataTable],
        pageLength: 50,
        lengthChange: false,
        searching: true,
        ordering: true,
        columnDefs: [
            { "targets": 1, "type": "date-eu" },
        ], order: [[1, 'desc']],
        initComplete: function (settings, json) {
            self = this.api();
            initCompleteDataTable(self);

        }
    });
});

