// Inherit the parent event
event_inherited();

strafe_spd    = 0;     // stationary (if >0 then breath track's the player's row

// Persistent breath in front of the boss (player approaches from the left).
atk_obj = instance_create_layer(x, y, "Attacks", obj_en_boss_atk);
atk_obj.creator = id;
atk_obj.x = x - 96;   // tune with spr_en_boss_atk width
atk_obj.y = y;

// Boss is a breathing wall: it never leaves "idle", so it never enters
// "returning" (which would destroy the breath). The breath persists for good.
on_idle = function() {
    if (strafe_spd > 0) {
        var _step = clamp(target.y - y, -strafe_spd, strafe_spd);
        if (!wall_check(id, x, y + _step)) y += _step;
        if (instance_exists(atk_obj)) atk_obj.y = y; // keep breath glued to boss
    }
    // intentionally never transitions to "telegraph"
};