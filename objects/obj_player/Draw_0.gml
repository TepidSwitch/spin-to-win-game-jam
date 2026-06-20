if (is_dodging) {
    draw_set_color(c_aqua);
} else if (is_charging) {
    draw_set_color(c_yellow);
} else {
    draw_set_color(c_white);
}

draw_rectangle(x-8, y-8, x+8, y+8, false);

// Facing indicator
draw_set_color(c_black);
draw_circle(x + lengthdir_x(10, dir), y + lengthdir_y(10, dir), 3, false);

draw_set_colour(c_white);