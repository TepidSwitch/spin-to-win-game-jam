if (is_paused) exit;

world_active = true;

if (freeze_timer > 0) {
    freeze_timer--;
    world_active = false;
} else if (slow_timer > 0) {
    slow_timer--;
    slow_phase++;
    if (slow_phase >= slow_every) {
        slow_phase = 0;
    } else {
        world_active = false;
    }
}