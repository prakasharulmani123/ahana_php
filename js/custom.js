$(document).ready(function () {
    $("a[class='custom-close-sidebar']").click(function () {
        setTimeout(function () { // Wait for closing animation to finish.
            $.slidebars.close();
        }, 400);
    })
});

$(document).mouseup(function (e) {
    var container = $("#patientcont-header.search-patientcont-header");
    var input_box = $(".header_search_input");

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
    
    var container_3 = $("#patient-merge1.result-patient-merge1");
    var input_box_3 = $(".patient_merge_input1");

    if (!container_3.is(e.target) && container_3.has(e.target).length === 0 && !input_box_3.is(e.target)) {
        container_3.hide();
    } else {
        container_3.show();
    }
});

$(document).bind('click', function (e) {
    var $clicked = $(e.target);
    if ($clicked.closest('.patient-details-part').find('.trigger-close').length == 0) {
        if($('.patient-details-part .trigger-close').next('.popover').is(':visible'))
            $('.trigger-close').trigger('click');
    }
    if ($clicked.hasClass('alert-read-more')) {
        $('.trigger-close').trigger('click');
    }
});

function chunk(str, n) {
    var ret = [];
    var i;
    var len;

    for (i = 0, len = str.length; i < len; i += n) {
        ret.push(str.substr(i, n))
    }

    return ret
}

