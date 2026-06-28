if (obj_game_manager.is_paused) exit;
if (!obj_game_manager.world_active) exit;

if (!instance_exists(creator)) {
    instance_destroy();
    exit;
}

var _hit = instance_place(x, y, obj_player);
if (_hit != noone and !_hit.invincible and is_active) {
    _hit.take_damage(x, y, kb_force);
    on_hit();
}

if (_hit != noone and is_active and _hit.is_dodging) {
    _hit.nearmiss_armed = true;
}

if (_hit != noone and !_hit.is_dodging and instance_exists(id)) {
    var _push_dir = point_direction(x, y, _hit.x, _hit.y);
    var _push_dist = 0;
    var _max_push = sprite_width + _hit.sprite_width;
    
    while (instance_place(x, y, obj_player) != noone and _push_dist < _max_push) {
        var _nx = _hit.x + lengthdir_x(1, _push_dir);
        var _ny = _hit.y + lengthdir_y(1, _push_dir);
        if (wall_check(_hit, _nx, _ny)) break;
            
        _hit.x = _nx;
        _hit.y = _ny;
        _push_dist++;
    }
}