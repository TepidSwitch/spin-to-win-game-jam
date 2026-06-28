// Body
var _body_col;
if (state == "telegraph") {
    _body_col = c_red;
} else if (shot_mode == "gambler") {
    _body_col = c_orange;
} else {
    _body_col = make_color_rgb(160, 32, 240); // purple = magician
}

draw_set_color(_body_col);
draw_rectangle(
    x - sprite_xoffset,
    y - sprite_yoffset,
    x - sprite_xoffset + sprite_width  - 1,
    y - sprite_yoffset + sprite_height - 1,
    false
);

// Angry face
var cx = x;
var cy = y;
draw_set_color(c_black);
draw_line_width(cx - 20, cy - 18, cx - 6,  cy - 12, 3); // left brow
draw_line_width(cx + 20, cy - 18, cx + 6,  cy - 12, 3); // right brow
draw_circle(cx - 12, cy - 4, 4, false);                  // left eye
draw_circle(cx + 12, cy - 4, 4, false);                  // right eye
draw_line_width(cx - 14, cy + 18, cx,      cy + 10, 3);  // frown left
draw_line_width(cx,      cy + 10, cx + 14, cy + 18, 3);  // frown right

if (shot_mode == "gambler") {
    var wr = 10;
    var wy = y - sprite_yoffset - wr - 6; 

    for (var i = 0; i < 4; i++) {
        var seg_start = spin_angle + i * 90;
        var seg_end   = seg_start + 90;
        draw_set_color(outcome_colors[i]);
        draw_primitive_begin(pr_trianglefan);
        draw_vertex(cx, wy);
        for (var a = seg_start; a <= seg_end; a += 15) {
            draw_vertex(cx + lengthdir_x(wr, a), wy + lengthdir_y(wr, a));
        }
        draw_vertex(cx + lengthdir_x(wr, seg_end), wy + lengthdir_y(wr, seg_end));
        draw_primitive_end();
    }

    draw_set_color(c_white);
    draw_circle(cx, wy, wr, true);
    draw_triangle(cx, wy - wr - 6, cx - 4, wy - wr + 1, cx + 4, wy - wr + 1, false);

    // Locked outcome label during telegraph
    if (state == "telegraph") {
        draw_set_color(outcome_colors[locked_segment]);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(cx, wy - wr - 22, string_upper(outcome_names[locked_segment]));
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }
}

if (shot_mode == "magician" and state == "telegraph") {
    draw_set_color(c_fuchsia);
    draw_line_width(x, y, x + lengthdir_x(48, attack_dir), y + lengthdir_y(48, attack_dir), 3);
}

draw_set_color(c_white);