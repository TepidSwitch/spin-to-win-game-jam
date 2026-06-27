function input_check(_binding) {
    for (var i = 0; i < array_length(_binding); i++) {
        if (keyboard_check(_binding[i])) return true;
    }
    if (!instance_exists(obj_game_manager)) return false;
    var _t = obj_game_manager.touch;
    var _c = obj_game_manager.controls;
    if (_binding == _c.move_left  and _t.move_x < -0.3) return true;
    if (_binding == _c.move_right and _t.move_x >  0.3) return true;
    if (_binding == _c.move_up    and _t.move_y < -0.3) return true;
    if (_binding == _c.move_down  and _t.move_y >  0.3) return true;
    if (_binding == _c.dodge      and _t.dodge)          return true;
    return false;
}

function input_check_pressed(_binding) {
    for (var i = 0; i < array_length(_binding); i++) {
        if (keyboard_check_pressed(_binding[i])) return true;
    }
    if (!instance_exists(obj_game_manager)) return false;
    var _t = obj_game_manager.touch;
    var _c = obj_game_manager.controls;
    if (_binding == _c.dodge   and _t.dodge_pressed)   return true;
    if (_binding == _c.confirm and _t.confirm_pressed) return true;
    return false;
}

function input_check_released(_binding) {
    for (var i = 0; i < array_length(_binding); i++) {
        if (keyboard_check_released(_binding[i])) return true;
    }
    if (!instance_exists(obj_game_manager)) return false;
    var _t = obj_game_manager.touch;
    var _c = obj_game_manager.controls;
    if (_binding == _c.dodge and _t.dodge_released) return true;
    return false;
}