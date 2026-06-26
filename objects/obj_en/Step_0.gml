if (obj_game_manager.is_paused) exit;

state_timer--;

switch(state) {
    case "idle":        on_idle();          break;
    case "telegraph":   on_telegraph();     break;
    case "attacking":   on_attacking();     break;
    case "returning":   on_returning();     break;
}

// Make sure the enemy body doesn't get stuck inside the player
var _hit = instance_place(x, y, obj_player);
if (_hit != noone and !_hit.is_dodging) {
    var _push_dir = point_direction(_hit.x, _hit.y, x, y);
    var _push_dist = 0;
    while (instance_place(x, y, obj_player) != noone and _push_dist < 32) {
        x += lengthdir_x(1, _push_dir);
        y += lengthdir_y(1, _push_dir);
        _push_dist++;
    }
}