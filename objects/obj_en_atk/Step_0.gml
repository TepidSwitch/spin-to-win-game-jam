if (!instance_exists(creator)) {
    instance_destroy();
    exit;
}

var _hit = instance_place(x, y, obj_player);
if (_hit != noone && !_hit.invincible) {
    _hit.take_damage(x, y);
    on_hit();
}