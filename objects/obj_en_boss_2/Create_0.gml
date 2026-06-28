// Inherit the parent event
event_inherited();

// Breath
if (instance_exists(atk_obj)) instance_destroy(atk_obj);
atk_obj = instance_create_layer(x - 96, y, "Attacks", obj_en_boss_2_atk);
atk_obj.creator = id;

// Wheel vars
outcome_names  = ["clear",  "short",   "reverse", "wobble"];
outcome_colors = [c_lime,   c_yellow,  c_red,     make_color_rgb(255, 128, 0)];
spin_angle     = 0;
spin_spd       = 1.8;
locked_segment = 0;
is_spinning    = true;

// Shot mode randomization
shot_mode = (irandom(1) == 0) ? "gambler" : "magician";
shot_obj  = noone;

// Timing
idle_duration      = 90;  // frames between shots
telegraph_duration = 30;

// State overrides
on_idle = function() {
    // Spin wheel only in gambler mode
    if (shot_mode == "gambler") {
        spin_angle = (spin_angle + spin_spd) mod 360;
    }

    if (state_timer <= 0) {
        if (shot_mode == "gambler") {
            var rel = ((270 - spin_angle) mod 360 + 360) mod 360;
            locked_segment = floor(rel / 90) mod 4;
            is_spinning = false;
        }
        state       = "telegraph";
        state_timer = telegraph_duration;
        attack_dir  = point_direction(x, y, target.x, target.y);
    }
};

on_attacking = function() {
    if (shot_obj == noone or !instance_exists(shot_obj)) {
        if (shot_mode == "gambler") {
            shot_obj            = instance_create_layer(x, y, "Attacks", obj_en_gambler_atk);
            shot_obj.creator    = id;
            shot_obj.atk_dir    = attack_dir;
            shot_obj.effect     = outcome_names[locked_segment];
        } else {
            shot_obj            = instance_create_layer(x, y, "Attacks", obj_en_magician_atk);
            shot_obj.creator    = id;
            shot_obj.spell_dir  = attack_dir;
        }
    }
    state = "returning";
};

on_returning = function() {
    shot_obj    = noone;
    is_spinning = true;
    // persist breath
    // Switch mode and reset
    shot_mode   = (shot_mode == "gambler") ? "magician" : "gambler";
    state       = "idle";
    state_timer = idle_duration;
};
