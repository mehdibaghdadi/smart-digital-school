FullCalendar.globalLocales.push(function () {
    'use strict';

    var en = {
        code: 'en',
        week: {
            dow: 1, // Monday is the first day of the week.
            doy: 4, // The week that contains Jan 4th is the first week of the year.
        },
        buttonText: {
            prev: 'Previous',
            next: 'Next',
            today: "Today",
            year: 'Year',
            month: 'Month',
            week: 'Week',
            day: 'Day',
            listDay: 'Pl: Daily',
            listMonth: 'Monthly',
            listYear: 'Annual',
        },
        weekText: 'Week',
        allDayText: 'All day',
        moreLinkText: 'in addition',
        noEventsText: 'No events to display',
    };

    return en;

}());