var inst = noone;
with (all) {
    draw_set_alpha(0.4);
    draw_set_color(c_lime);
    draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
    draw_set_alpha(1);
}
draw_set_color(c_white);