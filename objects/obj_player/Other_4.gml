// Reset charge state
move_flip = false;
dodge_effect = "none";
is_charging = false;
charge_timer = 0;
var dodge_held = input_check(obj_game_manager.controls.dodge);
charge_needs_repress = dodge_held; // if still holding on room start, ensure player lets go to start the charge againd

// Persistent, show up in any room that isn't win or lose room
if (room == rm_game_over or room == rm_win) {
    visible = false;
} else {
    visible = true;
    x = 100;
    y = room_height / 2;
}
