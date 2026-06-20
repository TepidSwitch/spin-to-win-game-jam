if (state == "telegraph") {
    draw_set_color(c_red);
}
else {
    draw_set_color(c_orange);
}

draw_rectangle(x-8, y-8, x+8, y+8, false);
draw_set_color(c_white);