event_inherited();

on_attacking = function() {
    var dx = lengthdir_x(attack_spd, attack_dir);
    var dy = lengthdir_y(attack_spd, attack_dir);
    if (!wall_check(id, x + dx, y)) x += dx;
    if (!wall_check(id, x, y + dy)) y += dy;
        
    if (atk_obj == noone) {
        atk_obj = instance_create_layer(x, y, "Attacks", obj_en_defender_atk);
        atk_obj.creator = id;
    }
    
    if (state_timer <= 0) state = "returning";
};