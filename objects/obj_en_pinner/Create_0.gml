// Inherit the parent event
event_inherited();

strafe_spd         = 2.5;  // aggressive
idle_duration      = 50;
telegraph_duration = 25;

on_attacking = function() {
    if (atk_obj == noone or !instance_exists(atk_obj)) {
        // Forward lance
        var fwd = instance_create_layer(x, y, "Attacks", obj_en_pinner_atk);
        fwd.creator    = id;
        fwd.lance_dir  = attack_dir;
        fwd.bounces    = false;
        fwd.lifetime   = 90;
        atk_obj = fwd;

        // bounce lance
        var bnc = instance_create_layer(x, y, "Attacks", obj_en_pinner_atk);
        bnc.creator    = id;
        bnc.lance_dir  = (attack_dir + 180) mod 360;
        bnc.bounces    = true;
        bnc.lifetime   = 180; 
    }
    state = "returning";
};

on_returning = function() {
    atk_obj = noone; // forward and bounce lance manages itself
    var dist = point_distance(x, y, start_x, start_y);
    if (dist > return_spd) {
        move_with_collision(return_spd, point_direction(x, y, start_x, start_y));
    } else {
        x = start_x;
        y = start_y;
        state = "idle";
        state_timer = idle_duration;
    }
};
