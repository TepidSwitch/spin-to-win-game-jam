if (obj_game_manager.is_paused) exit;

if (!instance_exists(creator)) {
    instance_destroy();
    exit;
}

x += lengthdir_x(atk_spd, atk_dir);
y += lengthdir_y(atk_spd, atk_dir);

if (wall_check(id, x, y)) {
    instance_destroy();
    exit;
}

lifetime--;
if (lifetime <= 0) {
    instance_destroy();
    exit;
}

// passes through dodging/invincible players
var _p = obj_player;
if (instance_exists(_p) and point_distance(x, y, _p.x, _p.y) <= _p.sprite_width * 0.5 + 8) {
    if (!_p.invincible and !_p.is_dodging) {
        _p.dodge_effect = effect;
        _p.invincible   = true;
        _p.inv_timer    = 45;
    }
    instance_destroy();
}