function input_check(_binding){
    for (var i = 0; i < array_length(_binding); i++) {
        if (keyboard_check(_binding[i])) return true;
    }
    return false;
}

function input_check_pressed(_binding) {
    for (var i = 0; i < array_length(_binding); i++) {
        if(keyboard_check_pressed(_binding[i])) return true;
    }
    return false;
}

function input_check_released(_binding) {
    for (var i = 0; i < array_length(_binding); i++) {
        if(keyboard_check_released(_binding[i])) return true;
    }
    return false;
}