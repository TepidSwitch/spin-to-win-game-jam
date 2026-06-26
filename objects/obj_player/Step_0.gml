var ctrl = obj_game_manager.controls;

// PAUSE
if (obj_game_manager.is_paused) {
    if (input_check_pressed(ctrl.restart)) obj_game_manager.restart_game();
    exit;
}

// HP
if (hp <= 0 and !is_dead) {
    is_dead = true;
    // hp = 3;
    room_goto(rm_game_over);
}

// I Framing
if (inv_timer > 0) {
    inv_timer--;
    invincible = (inv_timer > 0);
}

// Knockback
if (!wall_check(id, x + kb_x, y)) {
    x += kb_x;
} else {
    kb_x = 0;
}
if (!wall_check(id, x, y + kb_y)) {
    y += kb_y;
} else {
    kb_y = 0;
}

kb_x *= kb_friction;
kb_y *= kb_friction;

// Cooldown
if (dodge_cd_timer > 0) dodge_cd_timer--;
    
// Dodge Input
var dodge_held = input_check(ctrl.dodge);
var dodge_released = input_check_released(ctrl.dodge);

if (!is_dodging and dodge_cd_timer == 0) {
    
    if (dodge_released) charge_needs_repress = false;
    
    if (dodge_held and !charge_needs_repress) {
        is_charging = true;
        charge_timer++;
    }
    
    if (dodge_released and is_charging) {
        is_charging = false;
        is_dodging = true;
        dodge_cd_timer = dodge_cd;
        invincible = true;
        
        dodge_spd = DODGE_SPD_DEFAULT;
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
        
    if (dodge_timer <= 0) { 
        is_dodging = false;
        
        // Don't get caught inside an enemy
        if (place_meeting(x, y, obj_en)) {
            var push_dir = point_direction(x, y, obj_en.x, obj_en.y);
            push_dir = (push_dir + 180) mod 360; // flip it around
            var push_dist = 0;
            
            while (place_meeting(x, y, obj_en) and push_dist < (sprite_width + obj_en.sprite_width)) {
                var nx = x + lengthdir_x(1, push_dir);
                var ny = y + lengthdir_y(1, push_dir);
                
                if (wall_check(id, nx, ny)) break;
                    
                x = nx;
                y = ny;
                push_dist++;
            }
        }
    }
        
}

if (!is_dodging and !is_charging) {
    // Does not pass through enemies when moving normally
    var input_x = input_check(ctrl.move_right) - input_check(ctrl.move_left);
    var input_y = input_check(ctrl.move_down) - input_check(ctrl.move_up);
    
    if (input_x != 0 or input_y != 0) {
        dir = point_direction(0, 0, input_x, input_y)
    } else {
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

if (input_check_pressed(ctrl.restart)) obj_game_manager.restart_game();
