var _bob = sin(current_time * 0.005) * 3;
draw_set_color(make_color_rgb(255, 100, 130));
draw_circle(x, y + _bob, 9, false);
draw_set_color(c_white);
draw_line_width(x - 5, y + _bob, x + 5, y + _bob, 2);
draw_line_width(x, y + _bob - 5, x, y + _bob + 5, 2);
draw_set_color(c_white);