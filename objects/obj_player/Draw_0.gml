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

draw_rectangle(x1, y1, x2, y2, false);

// Facing
draw_set_color(c_black);
draw_circle(
    x + lengthdir_x(sprite_width * 0.75, dir),
    y + lengthdir_y(sprite_width * 0.75, dir),
    3,
    false);

// Charge bar - below the player
if (is_charging) { 
    var charge_percent = clamp(charge_timer / charge_time_needed, 0, 1);
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