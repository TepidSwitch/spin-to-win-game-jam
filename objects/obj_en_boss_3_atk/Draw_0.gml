var _hw = sprite_width  / 2; // 65
var _hh = sprite_height / 2; // 80
var x1 = x - _hw;
var y1 = y - _hh;
var x2 = x + _hw - 1;
var y2 = y + _hh - 1;

draw_set_alpha(0.35);
draw_set_color(c_red);
draw_rectangle(x1, y1, x2, y2, false); // translucent fill

draw_set_alpha(1);
draw_set_color(c_red);
draw_rectangle(x1, y1, x2, y2, true);  // solid outline

draw_set_color(c_white);
draw_set_alpha(1);