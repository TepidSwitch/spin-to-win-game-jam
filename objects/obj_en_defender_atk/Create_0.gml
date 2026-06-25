// Inherit the parent event
event_inherited();

on_hit = function() {
    if (instance_exists(creator)) {
        creator.state = "returning";
        creator.state_timer = 0;
        creator.atk_obj = noone;
    }
    instance_destroy();
}