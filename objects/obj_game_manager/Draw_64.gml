// Collision debug overlay
with (all) {
    draw_set_alpha(0.4);
    draw_set_color(c_lime);
    draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
    draw_set_alpha(1);
}


// HUD
var p = obj_player;

// HP
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(8, 8, "HP: " + string(p.hp));

// Dodge CD
var cd_percent = 1 - (p.dodge_cd_timer / p.dodge_cd);
draw_set_color(c_green);
draw_rectangle(8, 24, 108, 32, false);
draw_set_color(c_aqua);
draw_rectangle(8, 24, 8 + (100 * cd_percent), 32, false);
draw_set_color(c_white);
draw_text(8, 34, "DODGE");

// Charging
if (p.is_charging) {
    var charge_percent = clamp(p.charge_timer / p.charge_time_needed, 0, 1);
    draw_set_color(c_yellow);
    draw_rectangle(8, 48, 8 +(100 * charge_percent), 56, false);
    draw_set_color(c_white);
    draw_text(8, 58, "CHARGE");
}