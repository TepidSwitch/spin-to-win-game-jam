event_inherited();

on_attacking = function() {
    var dx = lengthdir_x(attack_spd, attack_dir);
    var dy = lengthdir_y(attack_spd, attack_dir);
    if (!wall_check(id, x + dx, y)) x += dx;
    if (!wall_check(id, x, y + dy)) y += dy;
        
    if (atk_obj == noone) {
        atk_obj = instance_create_layer(x, y, "Attacks", obj_en_chaser_atk);
        atk_obj.creator = id;
        atk_obj.x = x + lengthdir_x(atk_obj.lance_offset, attack_dir);
        atk_obj.y = y + lengthdir_y(atk_obj.lance_offset, attack_dir);
        atk_obj.image_angle = attack_dir - 90;
    }
    
    if (state_timer <= 0) {
        if (instance_exists(atk_obj)) {  
            instance_destroy(atk_obj);
            atk_obj = noone;
        }
        state = "idle";
        state_timer = idle_duration;
    }
};

on_returning = function() {
    // Chaser chases, never returns
    x = start_x;
    y = start_y;
    state = "idle";
    state_timer = idle_duration;
};