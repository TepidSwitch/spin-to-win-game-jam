// Inherit the parent event
event_inherited();

// Vertical sweep
y += sweep_spd * sweep_dir;

var _min_y = sprite_height / 2;
var _max_y = room_height - sprite_height / 2;

if (y <= _min_y || y >= _max_y) {
    sweep_dir *= -1;
    y = clamp(y, _min_y, _max_y);
}
