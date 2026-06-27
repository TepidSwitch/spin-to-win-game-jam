// Inherit the parent event
event_inherited();

strafe_spd = 1.5;
idle_duration = 80;
telegraph_duration = 45;

// Wheel config
outcome_names  = ["clear", "short", "reverse", "wobble"];
outcome_colors = [c_lime, c_yellow, c_red, make_color_rgb(255, 128, 0)];

spin_angle     = 0;    // degrees; pointer fixed at top (270°)
spin_spd_idle  = 1.2;  // degrees per frame during idle
is_spinning    = true; // false during telegraph
locked_segment = 0;    // set when telegraph begins

state_timer = idle_duration; // give player time to read the wheel before first attack

on_idle = function() {
    // Strafing
    if (strafe_spd > 0) {
        var _step = clamp(target.y - y, -strafe_spd, strafe_spd);
        if (!wall_check(id, x, y + _step)) y += _step;
    }

    // Spin the wheel
    spin_angle = (spin_angle + spin_spd_idle) mod 360;

    if (state_timer <= 0) {
        // Lock the segment currently under the pointer (top = 270°)
        var rel = ((270 - spin_angle) mod 360 + 360) mod 360;
        locked_segment = floor(rel / 90) mod 4;

        is_spinning = false;
        state = "telegraph";
        state_timer = telegraph_duration;
        attack_dir = point_direction(x, y, target.x, target.y);
    }
};

on_telegraph = function() {
    if (state_timer <= 0) {
        state = "attacking";
        state_timer = attack_duration;
    }
};

on_attacking = function() {
    if (atk_obj == noone or !instance_exists(atk_obj)) {
        atk_obj = instance_create_layer(x, y, "Attacks", obj_en_gambler_atk);
        atk_obj.creator  = id;
        atk_obj.atk_dir  = attack_dir;
        atk_obj.effect   = outcome_names[locked_segment];
    }
    state = "returning";
};

on_returning = function() {
    atk_obj = noone;
    is_spinning = true;

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