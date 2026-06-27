var x1 = x - sprite_xoffset;
var x2 = x1 + sprite_width;
var y1 = y - sprite_yoffset;
var y2 = y1 + sprite_height;

if (invincible and current_time mod 8 < 4) exit;

if (is_dodging) {
    draw_set_color(c_aqua);
} else if (is_charging) {
    draw_set_color(c_red);
} else {
    draw_set_color(c_white);
}

// Body
var cx = (x1 + x2) / 2;
var cy = (y1 + y2) / 2;
var radius = sprite_width / 2;
draw_circle(cx, cy, radius, false);

// Facing dot
var charge_percent = clamp(charge_timer / charge_time_needed, 0, 1);
var marker_dir = dir;
if (is_charging) {
    
    marker_dir = (current_time * (0.4 + charge_percent * 1.2)) mod 360;
}
draw_set_color(c_black);
draw_circle(
    cx + lengthdir_x(sprite_width * 0.75, marker_dir),
    cy + lengthdir_y(sprite_width * 0.75, marker_dir),
    3,
    false);

// Charge bar
if (is_charging) {
    var bar_w = 32;
    var bar_h = 4;
    var bx = x - bar_w / 2;
    var by = y2 + 4;

    draw_set_color(c_dkgray);
    draw_rectangle(bx, by, bx + bar_w, by + bar_h, false);
    draw_set_color(c_yellow);
    draw_rectangle(bx, by, bx + floor(bar_w * charge_percent), by + bar_h, false);
}

draw_set_color(c_white);