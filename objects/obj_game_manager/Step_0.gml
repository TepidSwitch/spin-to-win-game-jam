if (os_browser != browser_not_a_browser and !_mouse_detected) {
    var _mx = device_mouse_x(0);
    if (_mx != _prev_mouse_x and !device_mouse_check_button(0, mb_left)) {
        _mouse_detected = true;
    }
    _prev_mouse_x = _mx;
}

// Touch Input
var _MAX_DEV    = 7;
var _JOY_ZONE_X = 280;   
var _JOY_ZONE_Y = 210;   
var _JOY_RADIUS = 56;    
var _DBX = 580; var _DBY = 302; var _DBR = 36;           // dodge button center + radius
var _PBX1 = 590; var _PBY1 = 2; var _PBX2 = 636; var _PBY2 = 22;  // pause button rect

var _dodge_held = false;
var _pause_held = false;
var _joy_active = false;

// Re-check the device we already assigned to the joystick
if (_touch_joy_dev >= 0) {
    if (device_mouse_check_button(_touch_joy_dev, mb_left)) {
        _joy_active = true;
        var _jx = device_mouse_x_to_gui(_touch_joy_dev) - _touch_joy_ox;
        var _jy = device_mouse_y_to_gui(_touch_joy_dev) - _touch_joy_oy;
        var _jlen = point_distance(0, 0, _jx, _jy);
        if (_jlen > _JOY_RADIUS) { _jx *= _JOY_RADIUS / _jlen; _jy *= _JOY_RADIUS / _jlen; }
        touch.move_x = _jx / _JOY_RADIUS;
        touch.move_y = _jy / _JOY_RADIUS;
    } else {
        _touch_joy_dev = -1;
    }
}

// Re-check the device we already assigned to dodge
if (_touch_dodge_dev >= 0) {
    if (device_mouse_check_button(_touch_dodge_dev, mb_left)) {
        _dodge_held = true;
    } else {
        _touch_dodge_dev = -1;
    }
}

// Scan all devices for new touches
for (var _d = 0; _d <= _MAX_DEV; _d++) {
    if (!device_mouse_check_button(_d, mb_left)) continue;
    var _tx = device_mouse_x_to_gui(_d);
    var _ty = device_mouse_y_to_gui(_d);

    // Pause button (top-right corner)
    if (_tx >= _PBX1 and _tx <= _PBX2 and _ty >= _PBY1 and _ty <= _PBY2) {
        _pause_held = true;
        continue;
    }

    // Dodge button (bottom-right circle)
    if (_touch_dodge_dev < 0 and point_distance(_tx, _ty, _DBX, _DBY) <= _DBR) {
        _touch_dodge_dev = _d;
        _dodge_held = true;
        continue;
    }

    // Joystick zone (left side, lower half of screen)
    if (_touch_joy_dev < 0 and !_joy_active and _tx < _JOY_ZONE_X and _ty > _JOY_ZONE_Y) {
        _touch_joy_dev = _d;
        _touch_joy_ox  = _tx;
        _touch_joy_oy  = _ty;
        _joy_active    = true;
        touch.move_x   = 0;
        touch.move_y   = 0;
    }
}

if (!_joy_active) {
    touch.move_x = 0;
    touch.move_y = 0;
}

// Synthesize single-frame press / release events
touch.dodge_pressed   = (_dodge_held and !_touch_dodge_prev);
touch.dodge_released  = (!_dodge_held and _touch_dodge_prev);
touch.dodge           = _dodge_held;
touch.confirm_pressed = touch.dodge_pressed;   // dodge btn = confirm on menus
touch.pause_pressed   = (_pause_held and !_touch_pause_prev);
_touch_dodge_prev = _dodge_held;
_touch_pause_prev = _pause_held;

// The Rest
if (debug_mode) {
    //show_debug_overlay(true);
    if (room == rm_1) {
        for (var _i = 0; _i < min(9, array_length(levels)); _i++) {
            if (keyboard_check_pressed(ord(string(_i + 1)))) {
                if (instance_exists(obj_player)) {
                    obj_player.hp              = obj_player.HP_DEFAULT;
                    obj_player.is_dead         = false;
                    obj_player.is_dodging      = false;
                    obj_player.is_charging     = false;
                    obj_player.charge_timer    = 0;
                    obj_player.invincible      = false;
                    obj_player.stun_timer      = 0;
                }
                current_level = _i;
                load_level(current_level);
            }
        }
    }
}

if (room != rm_menu and (input_check_pressed(controls.pause) or touch.pause_pressed)) {
    if (is_paused) resume_game(); else pause_game();
}