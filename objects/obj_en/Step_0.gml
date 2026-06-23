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
        
        if (!place_meeting(x + dx, y, obj_wall)) x += dx;
        if (!place_meeting(x, y + dy, obj_wall)) y += dy;
        
        // enemy is hitbox, later imlement obj_enemy_attack for hitbox
        var hit = instance_place(x, y, obj_player);
        if (hit != noone) {
            hit.take_damage();
        }
        
        if (state_timer <= 0) {
            state = "returning";
        }
    break;
        
    case "returning":
        var dist = point_distance(x, y, start_x, start_y);
        if (dist > return_spd) {
            var return_dir = point_direction(x, y, start_x, start_y);
            var rx = lengthdir_x(return_spd, return_dir);
            var ry = lengthdir_y(return_spd, return_dir);
            
            if (!place_meeting(x + rx, y, obj_wall)) x += rx;
            if (!place_meeting(x, y + ry, obj_wall)) y += ry;
        } else {
            x = start_x;
            y = start_y;
            state = "idle";
            state_timer = idle_duration;
        }
    break;
}