var ctrl = obj_game_manager.controls;
var n = array_length(items);
if (n == 0) exit;
    
// Keyboard
if (input_check_pressed(ctrl.move_up))      move_selection(-1);
if (input_check_pressed(ctrl.move_down))    move_selection(1);

// Mouse
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

for (var i = 0; i < n; i++) {
    if (!is_selectable(i)) continue;
        
    var btn_y = item_y(i);
    
    if (mx > cx - btn_w / 2 and mx < cx + btn_w / 2
        and my > btn_y - btn_h / 2 and my < btn_y + btn_h / 2) {
        selected = i;
        if (device_mouse_check_button_pressed(0, mb_left)) confirm();
    }
}

if (input_check_pressed(ctrl.confirm)) confirm();
