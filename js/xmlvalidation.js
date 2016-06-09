function OThersvisible(current_id, target_id, status) {
    if ($("#" + current_id).is(':checked')) {
        $("#" + target_id).removeClass('hide');
    } else {
        $("#" + target_id).addClass('hide');
    }

    if (status == 'none') {
        $("#" + target_id).addClass('hide');
    }
}