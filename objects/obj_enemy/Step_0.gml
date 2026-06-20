state_timer--;

switch(state) {
    case "idle":
        if (state_timer <= 0) {
            state = "telegraph";
            state_timer = attack_telegraph;
            // Lock it in
            attack_dir = point_direction(x, y, target.x, target.y);
        }
    break;

    case "telegraph":
        // Flash or something, experiment
        image_blend = c_red;
        if (state_timer <= 0) {
            state = "attacking";
            state_timer = 20;
        }
    break;

    case "attacking": 
        image_blend = c_white;
        x += lengthdir_x(attack_spd, attack_dir);
        y += lengthdir_y(attack_spd, attack_dir);
        
        // enemy is hitbox, later imlement obj_enemy_attack for hitbox
        var hit = instance_place(x, y, obj_player);
        if (hit != noone && !hit.invincible) {
            hit.hp--;
            hit.invincible = true;
            hit.inv_timer = 60;
            if (hit.hp <= 0) room_restart();
        }
        
        if (state_timer <= 0) {
            state = "idle";
            state_timer = 90;
        }
        
}