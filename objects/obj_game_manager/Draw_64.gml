// Collision debug overlay
if (debug_mode) {
    with (all) {
        draw_set_alpha(0.4);
        draw_set_color(c_lime);
        draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
        draw_set_alpha(1);
    }
}



// HUD
if (!instance_exists(obj_player)) exit;
var p = obj_player;
draw_set_font(fnt_default);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// HUD Background
draw_set_color(c_black);
draw_set_alpha(0.65);
draw_rectangle(0, 0, 120, 50, false);
draw_set_alpha(1);

// HP - filled and empty circles
var circle_r = 6;
var circle_gap = 16;
for (var i = 0; i < p.HP_DEFAULT; i++) {
    if (i < p.hp) {
        draw_set_color(c_red);
        draw_circle(10 + i * circle_gap, 10, circle_r, false);
    } else {
        draw_set_color(c_dkgray);
        draw_circle(10 + i * circle_gap, 10, circle_r, true);
    }
}

// Stamina (dodge CD) bar
var cd_percent = 1 - (p.dodge_cd_timer / p.dodge_cd);
draw_set_color(c_dkgray);
draw_rectangle(8, 24, 108, 32, false);
draw_set_color(c_aqua);
draw_rectangle(8, 24, 8 + floor(100 * cd_percent), 32, false);
draw_set_color(c_white);
draw_text(8, 34, "STAMINA");

// Pause
if (is_paused) {
    draw_set_alpha(0.5);
    draw_set_color(c_black);
    draw_rectangle(0, 0, 640, 352, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(320, 160, "PAUSED");
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}