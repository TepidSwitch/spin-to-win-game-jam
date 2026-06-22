var x1 = x - sprite_xoffset;
var x2 = x1 + sprite_width;
var y1 = y - sprite_yoffset;
var y2 = y1 + sprite_height;

if (is_dodging) {
    draw_set_color(c_aqua);
} else if (is_charging) {
    draw_set_color(c_orange);
} else {
    draw_set_color(c_white);
}
draw_rectangle(x1, y1, x2, y2, false);

// Facing
draw_set_color(c_black);
draw_circle(x + lengthdir_x(sprite_width * 0.75, dir), y + lengthdir_y(sprite_width * 0.75, dir), 3, false);

draw_set_color(c_white);