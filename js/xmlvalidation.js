function OThersvisible(current_id, target_id, status) {
    if ($("#" + current_id).is(':checked')) {
        $("#" + target_id).removeClass('hide');
    } else {
        $("#" + target_id).addClass('hide');
    }

    if (status == 'none') {
        $("#" + target_id).addClass('hide');
    }
    if (status == 'block') {
        $("#" + target_id).removeClass('hide');
    }
}

function isNumericKeyStroke(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    
    var returnValue = false;
    // 8 - Backspace, 13 - Carriage Return (Enter)
    if (((charCode >= 48) && (charCode <= 57)) || (charCode == 8) || (charCode == 13) || ((charCode >= 96) && (charCode <= 105)))
        returnValue = true
    
    return returnValue;
}