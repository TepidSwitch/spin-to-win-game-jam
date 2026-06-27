// Inherit the parent event
event_inherited();

strafe_spd      = 2.5;
attack_spd      = 4;
idle_duration   = 30;

// Stay in the player's lane
on_returning = function() {
    var _dist = abs(x - start_x);
    if (_dist > return_spd) {
        var _sx = clamp(start_x - x, -return_spd, return_spd);
        if (!wall_check(id, x + _sx, y)) x += _sx;
    } else {
        x = start_x;
        state = "idle";
        state_timer = idle_duration;
    }
};
