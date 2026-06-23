// HP
if (hp <= 0 and !is_dead) {
    is_dead = true;
    hp = 3;
    room_goto(rm_game_over);
}

// I Framing
if (inv_timer > 0) {
    inv_timer--;
    invincible = (inv_timer > 0);
}

// Cooldown
if (dodge_cd_timer > 0) dodge_cd_timer--;
    
// Dodge Input
var dodge_key = keyboard_check(vk_space) or keyboard_check(ord("J"));
var dodge_released = keyboard_check_released(vk_space) or keyboard_check_released(ord("J"));

if (!is_dodging and dodge_cd_timer == 0) {
    
    if (dodge_key) {
        is_charging = true;
        charge_timer++;
    }
    
    if (dodge_released and is_charging) {
        is_charging = false;
        is_dodging = true;
        dodge_cd_timer = dodge_cd;
        invincible = true;
        
        dodge_spd = dodge_spd_default;
        dodge_timer = dodge_dur;
        
        if (charge_timer >= charge_time_needed) {
            dodge_spd = charged_dodge_spd;
            dodge_timer = charged_dodge_dur;
        }
        
        inv_timer = dodge_timer;
        charge_timer = 0;
    }
}

// Dodging
if (is_dodging) {
    // Passes through enemies 
    dodge_timer--;
    
    var dx = lengthdir_x(dodge_spd, dir);
    var dy = lengthdir_y(dodge_spd, dir);
    
    if (!wall_check(id, x + dx, y)) x += dx;
    if (!wall_check(id, x, y + dy)) y += dy;
    if (dodge_timer <= 0) is_dodging = false;
        
}

if (!is_dodging) {
    // Does not pass through enemies when moving normally
    var input_x = (keyboard_check(ord("D")) or keyboard_check(vk_right))
                - (keyboard_check(ord("A")) or keyboard_check(vk_left));
    var input_y = (keyboard_check(ord("S")) or keyboard_check(vk_down))
                - (keyboard_check(ord("W")) or keyboard_check(vk_up));
    
    if (input_x != 0 or input_y != 0) {
        dir = point_direction(0, 0, input_x, -input_y) // remember Y is flipped in GML
    } else if (!is_charging) {
        // face away from nearest enemy when standing still
        if (instance_exists(obj_en)) {
            var nearest = instance_nearest(x, y, obj_en);
            dir = point_direction(nearest.x, nearest.y, x, y);
        }
    }
    
    if (input_x != 0 and !wall_check(id, x + input_x * spd, y)
        and !place_meeting(x + input_x * spd, y, obj_en)) x += input_x * spd;
    if (input_y != 0 and !wall_check(id, x, y + input_y * spd)
        and !place_meeting(x, y + input_y * spd, obj_en)) y += input_y * spd;
}
