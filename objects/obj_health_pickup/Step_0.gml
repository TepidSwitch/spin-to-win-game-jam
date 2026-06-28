if (instance_exists(obj_player) and point_distance(x, y, obj_player.x, obj_player.y) < 16) {
    var _p = obj_player;
    if (_p.hp < _p.HP_DEFAULT) {
        _p.hp++;
        instance_destroy();
    }
}