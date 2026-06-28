// Screen shake
if (!view_enabled) exit;

var _cam = view_camera[0];

if (shake_timer > 0 and !is_paused) {
    shake_timer--;
    var _falloff = shake_timer / shake_dur;
    var _amt = shake_mag * _falloff * fx.screenshake;
    camera_set_view_pos(_cam, random_range(-_amt, _amt), random_range(-_amt, _amt));
} else {
    camera_set_view_pos(_cam, 0, 0);
}