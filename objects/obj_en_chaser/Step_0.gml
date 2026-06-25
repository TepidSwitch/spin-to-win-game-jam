state_timer--;

switch(state) {
    case "idle":
        if (state_timer <= 0) {
            state = "telegraph";
            state_timer = telegraph_duration;
            // Lock it in
            attack_dir = point_direction(x, y, target.x, target.y);
        }
    break;

    case "telegraph":
        // Flash or something, experiment
        if (state_timer <= 0) {
            state = "attacking";
            state_timer = attack_duration;
        }
    break;

    case "attacking": 
        var dx = lengthdir_x(attack_spd, attack_dir);
        var dy = lengthdir_y(attack_spd, attack_dir);
        
        if (!wall_check(id, x + dx, y)) x += dx;
        if (!wall_check(id, x, y + dy)) y += dy;
        
        if (atk_obj == noone) {
            atk_obj = instance_create_layer(x, y, "Instances", obj_en_chaser_atk);
            atk_obj.creator = id;
        }
        
        if (state_timer <= 0) {
            if (instance_exists(atk_obj)) {
                instance_destroy(atk_obj);
                atk_obj = noone;
            }
            state = "idle";
            state_timer = idle_duration;
        }
    break;
        
}