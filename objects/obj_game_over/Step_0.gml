var _tap = false;
for (var _d = 0; _d <= 7; _d++) {
    if (device_mouse_check_button_pressed(_d, mb_left)) {
        _tap = true;
        break;
    }
}
if (keyboard_check_pressed(ord("R")) or _tap) {
    obj_game_manager.restart_game();
}