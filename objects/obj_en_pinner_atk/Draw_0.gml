// orange for forward lance, purple for bounce lance
var col = bounces ? make_color_rgb(180, 80, 255) : c_orange;

draw_set_color(col);
draw_circle(x, y, 6, false);
draw_set_color(c_white);