if (debug_mode) show_debug_overlay(true);

if (keyboard_check_pressed(vk_escape) or keyboard_check_pressed(ord("P"))) {
    is_paused = !is_paused;
}