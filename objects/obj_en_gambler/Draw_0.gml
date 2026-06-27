var cx = x;
var cy = y;
var r  = 16;

// 4 wheel segments
for (var i = 0; i < 4; i++) {
    var seg_start = spin_angle + i * 90;
    var seg_end   = seg_start + 90;
    draw_set_color(outcome_colors[i]);
    draw_primitive_begin(pr_trianglefan);
    draw_vertex(cx, cy);
    for (var a = seg_start; a <= seg_end; a += 15) {
        draw_vertex(cx + lengthdir_x(r, a), cy + lengthdir_y(r, a));
    }
    draw_vertex(cx + lengthdir_x(r, seg_end), cy + lengthdir_y(r, seg_end));
    draw_primitive_end();
}

// Wheel border
draw_set_color(c_white);
draw_circle(cx, cy, r, true);

// Pointer
draw_triangle(
    cx,     cy - r - 8,
    cx - 5, cy - r + 1,
    cx + 5, cy - r + 1,
    false
);

// label the locked outcome above the pointer
if (state == "telegraph") {
    draw_set_color(outcome_colors[locked_segment]);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(cx, cy - r - 22, string_upper(outcome_names[locked_segment]));
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

draw_set_color(c_white);