// Body
draw_set_color(make_color_rgb(30, 80, 180));
draw_rectangle(
    x - sprite_xoffset,
    y - sprite_yoffset,
    x - sprite_xoffset + sprite_width  - 1,
    y - sprite_yoffset + sprite_height - 1,
    false
);

// show both lance directions
if (state == "telegraph") {
    var _len = 48;

    // Forward line
    draw_set_color(c_orange);
    draw_line_width(
        x, y,
        x + lengthdir_x(_len, attack_dir),
        y + lengthdir_y(_len, attack_dir),
        3
    );

    // Bounce line
    draw_set_color(make_color_rgb(180, 80, 255));
    draw_line_width(
        x, y,
        x + lengthdir_x(_len, (attack_dir + 180) mod 360),
        y + lengthdir_y(_len, (attack_dir + 180) mod 360),
        3
    );
}

draw_set_color(c_white);