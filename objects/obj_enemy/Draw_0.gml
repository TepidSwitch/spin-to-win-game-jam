var x1 = x - sprite_xoffset;
var x2 = x1 + sprite_width;
var y1 = y - sprite_yoffset;
var y2 = y1 + sprite_height;

if (state == "telegraph") {
    draw_set_color(c_red);
}
else {
    draw_set_color(c_yellow);
}

draw_rectangle(x1, y1, x2, y2, false);
draw_set_color(c_white);