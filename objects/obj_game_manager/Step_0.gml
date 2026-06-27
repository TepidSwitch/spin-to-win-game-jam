if (debug_mode) show_debug_overlay(true);

if (room != rm_menu and input_check_pressed(controls.pause)) {
    if (is_paused) resume_game(); else pause_game();
}