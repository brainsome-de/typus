$(document).ready(function() {

    // $("#quicksearch").searchField();

    // this didn't work as intended. But since I added the .resource class
    // on the body element, it worked in places where it shouldn't. I'm disabling it
    // to return to the earlier behaviour ...
    // $(".resource :input", document.myForm).bind("change", function() {
    //     Typus.setConfirmUnload(true);
    // });

    // This method is used by Typus::Controller::Bulk
    $(".action-toggle").click(function() {
        var status = this.checked;
        $('input.action-select').each(function() { this.checked = status; });
        $('.action-toggle').each(function() { this.checked = status; });
    });

});

var Typus = {};

Typus.setConfirmUnload = function(on) {
    window.onbeforeunload = (on) ? Typus.unloadMessage : null;
}

Typus.reloadParent = function() {
    if (Typus.parent_location_reload) parent.location.reload(true);
}

Typus.unloadMessage = function () {
    return "You have entered new data on this page. If you navigate away from this page without first saving your data, the changes will be lost.";
}
