event_inherited();

strafe_spd = 1.5;

// shield persists
atk_obj = instance_create_layer(x, y, "Attacks", obj_en_defender_atk);
atk_obj.creator = id;
atk_obj.x = x + lengthdir_x(atk_obj.shield_offset, attack_dir);
atk_obj.y = y + lengthdir_y(atk_obj.shield_offset, attack_dir);
atk_obj.image_angle = attack_dir + 90;

on_attacking = function() {
    move_with_collision(attack_spd, attack_dir);
    if (state_timer <= 0) state = "returning";
};

on_returning = function() {
    var dist = point_distance(x, y, start_x, start_y);
    
    if (dist > return_spd) {
        var return_dir = point_direction(x, y, start_x, start_y);
        move_with_collision(return_spd, return_dir);
    } else {
        x = start_x;
        y = start_y;
        state = "idle";
        state_timer = idle_duration;
    }
}