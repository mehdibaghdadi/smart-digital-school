

$(document).ready(function () {
  
    var sources = document.getElementsByTagName('source'), i;

    for (i = 0; i < sources.length; i++) {
        (function (i) {
            sources[i].addEventListener('error', function (e) {
                var parent = $(e.target.parentElement.parentElement.parentElement.parentElement);

                var div = $("<small>", {
                    style: "min-width:120px",
                    class: "d-block p-3 bg-gradient-video rounded",
                    role: "button"
                }).html("{0}<br/>{1} {2}".format('<i class="fa fa-2x fa-triangle-exclamation text-red"></i>', JSR.error, JSR.video));
                parent.html(div);
                parent.on('click', function (e) {
                    e.preventDefault();
                    e.stopPropagation();
                    toastr.error(JSR.error_occurred_loading, JSR.video);
                    return false;
                });
                console.log('Error loading: ' + e.target.src);
            });
        }(i));
    }
});



