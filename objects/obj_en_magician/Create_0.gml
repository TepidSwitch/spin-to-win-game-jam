// Inherit the parent event
event_inherited();

strafe_spd       = 1.5;
idle_duration    = 50;
telegraph_duration = 30;

on_attacking = function() {
    // Spawn spell once, then go straight to returning
    if (atk_obj == noone or !instance_exists(atk_obj)) {
        atk_obj = instance_create_layer(x, y, "Attacks", obj_en_magician_atk);
        atk_obj.creator  = id;
        atk_obj.spell_dir = attack_dir;
    }
    state = "returning";
};

on_returning = function() {
    // Don't destroy the spell
    atk_obj = noone;

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
};