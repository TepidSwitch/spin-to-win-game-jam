if (obj_game_manager.is_paused) exit;

if (!instance_exists(creator)) {
    instance_destroy();
    exit;
}

// Move and check walls
var dx = lengthdir_x(lance_spd, lance_dir);
var dy = lengthdir_y(lance_spd, lance_dir);

var hit_x = wall_check(id, x + dx, y);
var hit_y = wall_check(id, x, y + dy);

if (hit_x or hit_y) {
    if (bounces and !has_bounced) {
        // Reflect 
        if (hit_x) dx = -dx;
        if (hit_y) dy = -dy;
        lance_dir   = point_direction(0, 0, dx, dy);
        has_bounced = true;
        // Apply reflected move this frame
        if (!wall_check(id, x + dx, y)) x += dx;
        if (!wall_check(id, x, y + dy)) y += dy;
    } else {
        instance_destroy();
        exit;
    }
} else {
    x += dx;
    y += dy;
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
        _p.take_damage(x, y, kb_force);
    }
    instance_destroy();
}
