// Inherit the parent event
event_inherited();

lance_offset = 30;

on_hit = function() {
    if (instance_exists(creator)) {
        creator.state = "idle";
        creator.state_timer = creator.idle_duration;
        creator.atk_obj = noone;
    }
    instance_destroy();
}