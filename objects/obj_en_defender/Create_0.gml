event_inherited();

// shield persists
atk_obj = instance_create_layer(x, y, "Attacks", obj_en_defender_atk);
atk_obj.creator = id;
atk_obj.x = x + lengthdir_x(atk_obj.shield_offset, attack_dir);
atk_obj.y = y + lengthdir_y(atk_obj.shield_offset, attack_dir);
atk_obj.image_angle = attack_dir + 90;

on_attacking = function() {
    var dx = lengthdir_x(attack_spd, attack_dir);
    var dy = lengthdir_y(attack_spd, attack_dir);
    if (!wall_check(id, x + dx, y)) x += dx;
    if (!wall_check(id, x, y + dy)) y += dy;
    
    if (state_timer <= 0) state = "returning";
};

on_returning = function() {
    var dist = point_distance(x, y, start_x, start_y);
    
    if (dist > return_spd) {
        var return_dir = point_direction(x, y, start_x, start_y);
        
        var rx = lengthdir_x(return_spd, return_dir);
        var ry = lengthdir_y(return_spd, return_dir);
        
        if (!wall_check(id, x + rx, y)) x += rx;
        if (!wall_check(id, x, y + ry)) y += ry;
    } else {
        x = start_x;
        y = start_y;
        state = "idle";
        state_timer = idle_duration;
    }
}