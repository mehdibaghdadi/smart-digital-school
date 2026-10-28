
/* initialize the calendar
 -----------------------------------------------------------------*/
//Date for the calendar btn events today
var base_goToToday = $.datepicker._gotoToday;
$.datepicker._gotoToday = function (id) {
    base_goToToday.call(this, id);
    this._selectDate(id);
}

//build calendar
var _offset = null, _top = 0;
var datePickerCalendar = function (calendar, sender) {
    _offset = $(sender).offset();
    _top = _offset.top > 280 ? 280 : 0;
    $("#picker").datepicker({
        showButtonPanel: true,
        changeMonth: true,
        changeYear: true,
        autoclose: true,
        dateFormat: "yy-mm-dd",
        beforeShow: function (input, inst) {
            setTimeout(function () {
                //console.log(_top)
                inst.dpDiv.css({ top: (_offset.top - _top) + 'px' });
            }, 1);
        },
        onSelect: function (datestr, inst) {
            var date = $(this).datepicker('getDate');
            calendar.gotoDate(date);
        },
    }).datepicker('show');

}

//Create calendar
var savedCalendarView = localStorage.getItem('fullcalendarDefaultView');

var createFullCalendar = function (id) {

    var calendarEl = document.getElementById(id);
    var Calendar = FullCalendar.Calendar;
    var Draggable = FullCalendar.Draggable;


    var calendar = new Calendar(calendarEl, {
        customButtons: {
            datePickerButton: {
                text: 'Date',
                click: function () {
                    datePickerCalendar(calendar, this)
                }
            },
        },
        bootstrapFontAwesome: {
            datePickerButton: 'fa-calendar-days',
            saveButton: 'fa-floppy-disk pr-1',
            saveButtonIcon: 'fa-floppy-disk',
        },
        initialView: savedCalendarView || 'dayGridMonth',
        viewClassNames: function (viewInfo) {
            console.log('View changed to: ' + viewInfo.view.type);
            localStorage.setItem('fullcalendarDefaultView', viewInfo.view.type);
        },
        headerToolbar: {
            left: 'prev,datePickerButton,timeGridDay,timeGridWeek,dayGridMonth,next',
            center: 'title',
            right: 'listDay,listMonth,listYear'
        },
        footerToolbar: {
            left: 'prev,datePickerButton,next',
            right: 'title',
            //right: 'saveButton'
        },
        contentHeight: "auto",
        handleWindowResize: true,
        themeSystem: 'bootstrap',
        locale: JSR.current_language,
        editable: true,
        selectable: true,
        forceEventDuration: true,
    });

    calendar.render();
    return calendar;
}

var createEventTitle = function (header, body) {
    return `<div class='mb-2 text-warning'>${header}</div> <em>${body}</em>`;
}
var resetCalendarToolTip = function (id) {
    var el = `#${id} [data-toggle="tooltip"]`;
    initToolTip(el);
}

var afterCalendarRender = function () {
    //$('.fc-saveButton-button').removeAttr("type").attr("type", "submit")
    //    .attr("title", "Enregistrer les modifications");

    $('.fc-saveButtonIcon-button').removeAttr("type").attr("type", "submit")
        .attr("data-toggle", "tooltip").attr("title", JSR.save_schedule);

    $('.fc-datePickerButton-button').attr("data-toggle", "tooltip").attr("title", JSR.choose_date);

    $('.fc-timeGridDay-button').attr("title", JSR.editing + ' : ' + JSR.day);
    $('.fc-timeGridWeek-button').attr("title", JSR.editing + ' : ' + JSR.week);
    $('.fc-dayGridMonth-button').attr("title", JSR.editing + ' : ' + JSR.month);

    $('.fc-listDay-button').attr("title", JSR.see_schedule + ' : ' + JSR.day);
    $('.fc-listMonth-button').attr("title", JSR.see_schedule + ' : ' + JSR.month);
    $('.fc-listYear-button').attr("title", JSR.see_schedule + ' : ' + JSR.year);

}

var getRandomColorEvents = function () {
    var letters = '0123456'.split('');
    var color = '#';
    color += letters[Math.round(Math.random() * 5)];
    letters = '0123456789ABCDEF'.split('');
    for (var i = 0; i < 5; i++) {
        color += letters[Math.round(Math.random() * 15)];
    }
    return color;
}


var showEventReadonly = function (event_color, event_title, event_description, dateStr) {

    var dt = (dateStr) ? `<b class='text-xs'>${dateStr}</b>` : "";
    
    var title = "<div><span style='color:{0}' class='fa fa-calendar-days pr-2'></span>{1}</div><div>{2}</div>"
        .format(event_color, JSR.event, dt);
    var ev_title = (event_title) ? `<hr class="mt-0"/><b class="">${event_title}</b>` : "";
    Swal.fire({
        title: title,
        html: `
            <!-- Sélecteur d’événement -->
            ${ev_title}            
            <!-- Zone de texte (optionnelle) -->
            <hr/>
            <textarea id="description_event" rows="10" readonly
                      placeholder="${JSR.description}..."
                      class="d-block form-control">${event_description}</textarea>
                `,
        focusConfirm: false,
    });

}
$(function () {
    if (document.documentElement.scrollTop < 25 && isMobile())
        window.scrollBy({
            top: 25,
            behavior: 'smooth'
        });
})