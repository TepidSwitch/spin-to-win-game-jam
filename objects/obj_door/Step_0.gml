var _player = instance_place(x, y, obj_player);
if (_player != noone) {
    // don't activate on i-frames during knockback, do activate during dodge
    if (_player.invincible and !_player.is_dodging) exit;
        
    with (obj_game_manager) {
        current_level++;
        
        if (current_level >= array_length(levels)) {
            room_goto(rm_win);
        } else {
            load_level(current_level);
        }
    }
}