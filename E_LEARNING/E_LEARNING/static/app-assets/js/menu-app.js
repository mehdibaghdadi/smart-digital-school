
const href_menu_app = window.location.href;
const url_menu_app = window.location;

$('ul.nav-sidebar a').filter(function () {
    return this.href == url_menu_app;
}).addClass('active').addClass('main-sidebar-active');

$('ul.nav-treeview a').filter(function () {
    var rgx = new RegExp($(this).attr("href"), "gi");
    return href_menu_app.match(rgx);
}).parentsUntil(".nav-sidebar > .nav-treeview").addClass('menu-open').prev('a').addClass('active');

