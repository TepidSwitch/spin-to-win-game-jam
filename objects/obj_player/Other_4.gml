// Persistent, show up in any room that isn't win or lose room
if (room == rm_game_over or room == rm_win) {
    visible = false;
} else {
    visible = true;
    x = 100;
    y = room_height / 2;
}
