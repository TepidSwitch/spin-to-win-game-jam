// Color matches the effect
var col = c_white;
if (effect == "short")   col = c_yellow;
if (effect == "reverse") col = c_red;
if (effect == "wobble")  col = make_color_rgb(255, 128, 0);

draw_set_color(col);
draw_circle(x, y, 8, false);
draw_set_color(c_white);