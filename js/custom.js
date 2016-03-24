$(document).ready(function () {

});

$(document).mouseup(function (e) {

    var container = $(".search-patientcont-header");
    var input_box = $(".header_search_input");

    if (!container.is(e.target) && container.has(e.target).length === 0 && !input_box.is(e.target)) {
        container.hide();
    } else {
        container.show();
    }
});

