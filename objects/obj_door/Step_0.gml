if (instance_place(x, y, obj_player) != noone) {
    with (obj_game_manager) {
        current_level++;
        if (current_level >= array_length(levels)) {
            room_goto(rm_win);
        } else {
            load_level(current_level);
        }
    }
}