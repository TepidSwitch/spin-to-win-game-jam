is_active = instance_exists(creator) && creator.state == "attacking";
event_inherited();

if (instance_exists(creator)) {
    var _dir;
    
    if (creator.state == "idle" || creator.state == "telegraph") {
        // point at the player until the attack is locked in
        if (instance_exists(obj_player)) {
            _dir = point_direction(creator.x, creator.y, obj_player.x, obj_player.y);
        } else {
            _dir = creator.attack_dir;
        }
    } else {
        _dir = creator.attack_dir;
    }
    
    x = creator.x + lengthdir_x(shield_offset, _dir);
    y = creator.y + lengthdir_y(shield_offset, _dir);
    image_angle = _dir + 90;
}