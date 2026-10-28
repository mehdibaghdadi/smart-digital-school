/* French initialisation for the jQuery UI date picker plugin. */
/* Written by Keith Wood (kbwood{at}iinet.com.au),
              Stéphane Nahmani (sholby@sholby.net),
              Stéphane Raimbault <stephane.raimbault@gmail.com> */
(function (factory) {
    "use strict";

    if (typeof define === "function" && define.amd) {

        // AMD. Register as an anonymous module.
        define(["../widgets/datepicker"], factory);
    } else {

        // Browser globals
        factory(jQuery.datepicker);
    }
})(function (datepicker) {
    "use strict";

    datepicker.regional.es = {
        closeText: "Cerrar",
        prevText: "Anterior",
        nextText: "Siguiente",
        currentText: "Hoy",
        monthNames: ["enero", "febrero", "marzo", "abril", "mayo", "junio",
            "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"],
        monthNamesShort: ["ene.", "feb.", "mar.", "abr.", "may.", "jun.",
            "jul.", "ago.", "sep.", "oct.", "nov.", "dic."],
        dayNames: ["domingo", "lunes", "martes", "miércoles", "jueves", "viernes", "sábado"],
        dayNamesShort: ["dom.", "lun.", "mar.", "mié.", "jue.", "vie.", "sáb."],
        dayNamesMin: ["D", "L", "M", "M", "J", "V", "S"],
        weekHeader: "Sem.",
        dateFormat: "dd/mm/yy",
        firstDay: 1,
        isRTL: false,
        showMonthAfterYear: false,
        yearSuffix: ""
    };

    datepicker.setDefaults(datepicker.regional.es);

    return datepicker.regional.es;

});
