// Inherit the parent event
event_inherited();

kb_force = 10;

on_hit = function() {
    if (instance_exists(obj_player) and instance_exists(creator)) {
        var _dir = point_direction(creator.x, creator.y, obj_player.x, obj_player.y);
        obj_player.kb_x = lengthdir_x(35, _dir);
        obj_player.kb_y = lengthdir_y(35, _dir);
    }
};