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
        x += lengthdir_x(attack_spd, attack_dir);
        y += lengthdir_y(attack_spd, attack_dir);
        
        // enemy is hitbox, later imlement obj_enemy_attack for hitbox
        var hit = instance_place(x, y, obj_player);
        if (hit != noone && !hit.invincible) {
            hit.take_damage();
        }
        
        if (state_timer <= 0) {
            state = "idle";
            state_timer = idle_duration;
        }
        
}