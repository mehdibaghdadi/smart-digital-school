
// check Package Expiration
var checkPackageExpiration = function () {

    setTimeout(function () {
        var $ifNoPayment = $('.if-no-payment');
        if ($ifNoPayment.length > 0) {
            toastr.warning("{0}.".format(JSR.alert_pack_expired), JSR.limit_reached, { timeOut: 30000 })
        }
    }, 1000);
}

var showPackageAlert = function (title_pack_alert,date_end) {
    toastr.warning("<b>{0}</b><hr/>{1} : {2} <br/>{3} : <b class='text-lg'>{4}</b> {5}."
        .format(title_pack_alert,JSR.date_end, date_end, JSR.remaining, JSR.unused_days, JSR.days),
        JSR.your_subscription, { timeOut: 30000 })

}

//ON READY
$(function () {
    setTimeout(function () {
        checkPackageExpiration();
    }, 2000);
});