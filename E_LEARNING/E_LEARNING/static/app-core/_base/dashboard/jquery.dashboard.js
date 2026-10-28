//Top Badge css
var setNumberBadge = function (timeout) {
    setTimeout(function () {
        document.querySelectorAll('.isNumberBadge').forEach(function (el) {
            var value = parseFloat(el.textContent);
            if (!isNaN(value)) {
                el.classList.add(value > 0 ? 'text-yellow' : 'text-gray');
            }
        });

    }, timeout);
};

// ENROLLMENT CHART (polarArea)
var resizeTimeout;
var createEnrollmentCharts = function (id, courses, enrollment) {
    var chart_id = $(id);
    var data = [courses, enrollment];
    var percent_enr = 0;
    var lab1 = JSR.courses_available.toUpperCase(),
        lab2 = JSR.courses_checked.toUpperCase();
    var title_top = "{0} : {1}".format(JSR.courses_checked, JSR.not_yet);

    if (courses !== 0) {
        percent_enr = Math.round((enrollment / courses) * 100);
        title_top = "{0} : {1} %".format(JSR.courses_checked, percent_enr == 0 ? '0' : percent_enr);
    }
    title_top = title_top.toUpperCase();

    var enrollmentChart = new Chart(chart_id, {
        type: 'polarArea',  // Changement du type de graphique
        data: {
            labels: [lab1, lab2],
            datasets: [{
                data: data,
                backgroundColor: ['#20923a60','#132642d0'],
            }]
        },
        options: {
            maintainAspectRatio: false,
            responsive: true,
            showScale: true,
            legend: {
                display: false,
                position: 'top',
            },
            title: {
                display: true,
                fontColor: "#212529",
                fontSize: 12,
                text: title_top
            },
        }
    });
    $(window).resize(function () {
        clearTimeout(resizeTimeout);
        resizeTimeout = setTimeout(function () {
            enrollmentChart.update(); // Force un rafraîchissement complet
        }, 200); // Attendre un peu pour éviter trop d'appels
    });

    return enrollmentChart;
}



// CHART CONTENTS BAR LINES
var createChartContentInstructor = function (id, keys, values, title_array, text_y, text_x, tooltip_x, tooltip_y, tooltip_x_suffix, tooltip_y_suffix) {

    var title_top = "";// title_array.map(item => item.toUpperCase());
    text_x = text_x.toUpperCase();
    tooltip_x = tooltip_x.toUpperCase();
    text_y = text_y.toUpperCase();
    tooltip_y = tooltip_y.toUpperCase();

    var ticksStyle = {
        fontColor: '#495057',
        fontStyle: 'bold',
        fontSize: 10,
    }
    var graphColors = ["#166b9f51"], graphOutlines = ['#166b9fb0'], i = 0;
    var color_legend_xy = "#0f4668";

    var mode = 'index'
    var intersect = true
    var chart_id = $(id);
    var chart_content = new Chart(chart_id, {
        data: {
            labels: keys,
            datasets: [
                {
                    type: 'line',
                    data: values,
                    backgroundColor: graphColors,
                    borderColor: graphOutlines,
                    borderWidth: 1,
                    borderSkipped: 'bottom',
                    pointBorderColor: '#fff',
                    pointBackgroundColor: '#222',
                    fill: false,
                    pointHoverBackgroundColor: '#fff',
                    pointHoverBorderColor: '#007bff'
                }, {
                    type: 'bar',
                    data: values,
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.5)',
                        'rgba(255, 159, 64, 0.5)',
                        'rgba(255, 205, 86, 0.5)',
                        'rgba(75, 192, 192, 0.5)',
                        'rgba(54, 162, 235, 0.5)',
                        'rgba(153, 102, 255, 0.5)',
                        'rgba(201, 203, 207, 0.5)',//7
                        'rgba(255, 99, 132, 0.5)',
                        'rgba(255, 159, 64, 0.5)',
                        'rgba(255, 205, 86, 0.5)',
                        'rgba(75, 192, 192, 0.5)',
                        'rgba(54, 162, 235, 0.5)',
                    ],
                }
            ]
        },
        options: {
            maintainAspectRatio: false,
            responsive: true,
            showScale: false,
            tooltips: {
                mode: mode,
                intersect: intersect,
                bodyFontSize: 10,
                filter: function (tooltipItem) {
                    return tooltipItem.datasetIndex === 0;
                },
                callbacks: {
                    title: function (tooltipItem, data) {
                        return tooltip_x + tooltipItem[0].xLabel + tooltip_x_suffix;
                    },
                    label: function (tooltipItem, data) {
                        return tooltip_y + tooltipItem.yLabel + tooltip_y_suffix;
                    }
                }
            },
            hover: {
                mode: mode,
                intersect: intersect
            },
            legend: {
                display: false,
                position: 'top',
            },
            title: {
                display: true,
                fontColor: "#7f7f7f",
                fontSize: 9,
                text: title_top
            },
            scales: {
                yAxes: [{
                    scaleLabel: {
                        display: true,
                        labelString: text_y,
                        fontColor: color_legend_xy,
                        fontSize: 9,


                    },
                    ticks: { stepSize: 2 }
                    ,

                }],
                xAxes: [{
                    display: true,
                    scaleLabel: {
                        display: true,
                        labelString: text_x,
                        fontColor: color_legend_xy,
                        fontSize: 9
                    },
                    gridLines: {
                        display: true,
                        lineWidth: '4px',
                        color: 'rgba(0, 0, 0, .8)',
                        zeroLineColor: 'transparent'
                    },
                    ticks: ticksStyle
                }]
            }
        }
    });

    return chart_content;
}


// FULL CALENDAR 
var createFullCalendar = function (id) {

    var calendarEl = document.getElementById(id);
    var Calendar = FullCalendar.Calendar;
    var Draggable = FullCalendar.Draggable;
    var today = new Date();
    var calendar = new Calendar(calendarEl, {
        validRange: {
            start: today,
            end: ''
        },
        initialView: 'listMonth',
        headerToolbar: {
            left: 'prev,next',
            center: 'title',
            right: 'listDay,listMonth,listYear today'
        },

        contentHeight: "auto",
        handleWindowResize: true,
        themeSystem: 'bootstrap',
        locale: JSR.current_language,
        editable: true,
        selectable: true,
        eventLimit: false,
    });
    calendar.render();

    $('.fc-listDay-button').attr("title", JSR.see_schedule + ' : ' + JSR.day);
    $('.fc-listMonth-button').attr("title", JSR.see_schedule + ' : ' + JSR.month);
    $('.fc-listYear-button').attr("title", JSR.see_schedule + ' : ' + JSR.year);
    return calendar;
}
