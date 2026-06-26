target = obj_player;
state = "idle";
state_timer = 0;

atk_obj = noone;

// Levers
idle_duration       = 40;
telegraph_duration  = 20;
attack_duration     = 20;
attack_spd          = 6;
return_spd          = 3;

attack_dir  = 0; // Locked in when telegraph starts
start_x     = x;
start_y     = y;

// Helper Methods
on_idle = function() {
    if (state_timer <= 0) {
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
}

on_attacking = function() {
    var dx = lengthdir_x(attack_spd, attack_dir);
    var dy = lengthdir_y(attack_spd, attack_dir);
    if (!wall_check(id, x + dx, y)) x += dx;
    if (!wall_check(id, x, y + dy)) y += dy;
    if (state_timer <= 0) state = "returning";
};

on_returning = function() {
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
};
