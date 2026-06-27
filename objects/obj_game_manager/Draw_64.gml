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
draw_text(8, 34, "STAMINA")

// Touch controls overlay — HTML5 only
if (os_browser != browser_not_a_browser and !_mouse_detected) {
    draw_set_font(fnt_default);

    // Joystick outer ring
    // floats to wherever the finger first landed,
    // or sits at a default resting position when idle
    var _jdx = (_touch_joy_dev >= 0) ? _touch_joy_ox : 96;
    var _jdy = (_touch_joy_dev >= 0) ? _touch_joy_oy : 296;
    draw_set_color(c_white);
    draw_set_alpha(0.35);
    draw_circle(_jdx, _jdy, 48, true);

    // Joystick inner dot
    var _idx = _jdx + touch.move_x * 48;
    var _idy = _jdy + touch.move_y * 48;
    draw_set_alpha(0.55);
    draw_circle(_idx, _idy, 20, false);

    // Dodge button
    draw_set_alpha(touch.dodge ? 0.75 : 0.4);
    draw_set_color(touch.dodge ? c_yellow : c_white);
    draw_circle(580, 302, 36, !touch.dodge);
    draw_set_alpha(0.85);
    draw_set_color(touch.dodge ? c_black : c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(580, 302, "DODGE");

    // Pause button
    draw_set_alpha(0.4);
    draw_set_color(c_white);
    draw_rectangle(590, 2, 636, 22, true);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(613, 12, "||");

    // Be kind, rewind
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
