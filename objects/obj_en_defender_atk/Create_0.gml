// Inherit the parent event
event_inherited();

shield_offset = 30;

on_hit = function() {
    if (instance_exists(creator)) {
        creator.state = "returning";
        creator.state_timer = 0;
    }
}