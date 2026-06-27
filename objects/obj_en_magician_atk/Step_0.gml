if (obj_game_manager.is_paused) exit;

if (!instance_exists(creator)) {
    instance_destroy();
    exit;
}

x += lengthdir_x(spell_spd, spell_dir);
y += lengthdir_y(spell_spd, spell_dir);

if (wall_check(id, x, y)) {
    instance_destroy();
    exit;
}

lifetime--;
if (lifetime <= 0) {
    instance_destroy();
    exit;
}

// Hit detection
var _p = obj_player;
if (instance_exists(_p) and point_distance(x, y, _p.x, _p.y) <= _p.sprite_width * 0.5 + 8) {
    if (!_p.invincible and !_p.is_dodging) {
        _p.dir        = (_p.dir + 180) mod 360;
        _p.invincible = true;
        _p.inv_timer  = 45;

        if (!_p.is_charging) {
            var _ctrl = obj_game_manager.controls;
            var _ix = input_check(_ctrl.move_right) - input_check(_ctrl.move_left);
            var _iy = input_check(_ctrl.move_down)  - input_check(_ctrl.move_up);
            if (_ix != 0 or _iy != 0) {
                _p.move_flip = true;
            } else {
                _p.stun_timer = _p.stun_duration;
            }
        }
        instance_destroy();
    }
}
