// Body
draw_set_color(make_color_rgb(160, 32, 240));
draw_rectangle(
    x - sprite_xoffset,
    y - sprite_yoffset,
    x - sprite_xoffset + sprite_width  - 1,
    y - sprite_yoffset + sprite_height - 1,
    false
);

// Scepter line during telegraph
if (state == "telegraph") {
    draw_set_color(c_fuchsia);
    var _len = 48;
    draw_line_width(
        x, y,
        x + lengthdir_x(_len, attack_dir),
        y + lengthdir_y(_len, attack_dir),
        3
    );
}

draw_set_color(c_white);