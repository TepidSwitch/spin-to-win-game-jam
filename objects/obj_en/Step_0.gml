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
        
        
        if (state_timer <= 0) state = "returning";
    break;
        
    case "returning":
        if (instance_exists(atk_obj)) {
            instance_destroy(atk_obj);
            atk_obj = noone;
        }
        
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
    break;
}