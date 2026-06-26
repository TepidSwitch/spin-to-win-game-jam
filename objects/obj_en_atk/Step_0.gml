if (obj_game_manager.is_paused) exit;

if (!instance_exists(creator)) {
    instance_destroy();
    exit;
}

var _hit = instance_place(x, y, obj_player);
if (_hit != noone and !_hit.invincible and is_active) {
    _hit.take_damage(x, y, kb_force);
    on_hit();
}

if (_hit != noone and !_hit.is_dodging and instance_exists(id)) {
    var _push_dir = point_direction(x, y, _hit.x, _hit.y);
    var _push_dist = 0;
    var _max_push = 32;
    while (instance_place(x, y, obj_player) != noone and _push_dist < _max_push) {
        _hit.x += lengthdir_x(1, _push_dir);
        _hit.y += lengthdir_y(1, _push_dir);
        _push_dist++;
    }
}