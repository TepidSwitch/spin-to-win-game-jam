// Fiery breath band
draw_set_alpha(0.45);
draw_set_color(c_red);
draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);

// brighter outline so the danger zone reads clearly
draw_set_alpha(0.85);
draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);

draw_set_alpha(1);
draw_set_color(c_white);