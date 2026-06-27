if (obj_game_manager.is_paused) exit;

state_timer--;

switch(state) {
    case "idle":        on_idle();          break;
    case "telegraph":   on_telegraph();     break;
    case "attacking":   on_attacking();     break;
    case "returning":   on_returning();     break;
}

// Collision
var _hit = instance_place(x, y, obj_player);
if (_hit != noone and !_hit.is_dodging) {
    if (state == "attacking" and atk_obj == noone) {
        var _push_x = lengthdir_x(attack_spd, attack_dir);
        var _push_y = lengthdir_y(attack_spd, attack_dir);
        
        if (!wall_check(_hit.id, _hit.x + _push_x, _hit.y)) _hit.x += _push_x;
        if (!wall_check(_hit.id, _hit.x, _hit.y + _push_y)) _hit.y += _push_y;
    } else {
        // otherwise push the enemy out of the player
        var _push_dir = point_direction(_hit.x, _hit.y, x, y);
        var _push_dist = 0;
        var _max_push = sprite_width + _hit.sprite_width;
        
        while (instance_place(x, y, obj_player) != noone and _push_dist < _max_push) {
            x += lengthdir_x(1, _push_dir);
            y += lengthdir_y(1, _push_dir);
            _push_dist++;
        }
    }
    

}