selected = 0;
items = [];  // menu items
title = "";
draw_overlay = false;  // set true by pause menu to darken the background

// Layout constants
cx      = display_get_gui_width() / 2;
first_y = 170;
btn_w   = 220;
btn_h   = 40;
btn_gap = 14;

item_y = function(_i) {
    return first_y + _i * (btn_h + btn_gap);
};

// Don't select Spacers
is_selectable = function(_i) {
    return !variable_struct_exists(items[_i], "spacer");
};

move_selection = function(_dir) {
    var n = array_length(items);
    if (n == 0) exit;
    var i = selected;
    
    repeat (n) {
        i = (i + _dir + n) mod n;
        if (is_selectable(i)) {
            selected = i;
            return ;
        }
    }
};

confirm = function() {
    if (array_length(items) == 0) exit;
    if (!is_selectable(selected)) exit;
    items[selected].action();
};

// Make sure our first selection is always selectable
// This works as long as the first item is always selectable
if (array_length(items) > 0 and !is_selectable(selected)) move_selection(1);
