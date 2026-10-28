FullCalendar.globalLocales.push(function () {
    'use strict';

    var es = {
        code: 'es',
        week: {
            dow: 1, // Lunes es el primer día de la semana.
            doy: 4, // La semana que contiene el 4 de enero es la primera semana del año.
        },
        buttonText: {
            prev: 'Anterior',
            next: 'Siguiente',
            today: 'Hoy',
            year: 'Año',
            month: 'Mes',
            week: 'Semana',
            day: 'Día',
            listDay: 'Lista: Diario',
            listMonth: 'Mensual',
            listYear: 'Anual',
        },
        weekText: 'Sem.',
        allDayText: 'Todo el día',
        moreLinkText: 'más',
        noEventsText: 'No hay eventos para mostrar',
    };

    return es;

}());
