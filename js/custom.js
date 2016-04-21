$(document).ready(function () {

});

$(document).mouseup(function (e) {

    var container = $("#patientcont-header.search-patientcont-header");
    var input_box = $("header_search_input");

    if (!container.is(e.target) && container.has(e.target).length === 0 && !input_box.is(e.target)) {
        container.hide();
    } else {
        container.show();
    }

    var container_2 = $("#prescriptioncont-header.search-patientcont-header");
    var input_box_2 = $(".prescription_search_input");

    if (!container_2.is(e.target) && container_2.has(e.target).length === 0 && !input_box_2.is(e.target)) {
        container_2.hide();
    } else {
        container_2.show();
    }
});

