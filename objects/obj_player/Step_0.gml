// HP
if (hp <= 0 and !is_dead) {
    is_dead = true;
    hp = 3;
    room_goto(rm_1);
}

// I Framing
if (inv_timer > 0) {
    inv_timer--;
    invincible = (inv_timer > 0);
}

// Cooldown
if (dodge_cd_timer > 0) dodge_cd_timer--;
    
// Dodge Input
var dodge_key = keyboard_check(vk_space);
var dodge_released = keyboard_check_released(vk_space);

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

// Dodge Movement
if (is_dodging) {
    dodge_timer--;
    
    x += lengthdir_x(dodge_spd, dir);
    y += lengthdir_y(dodge_spd, dir);
    
    if (dodge_timer <= 0) {
        is_dodging = false;
    }
}

// "Traditional" Movement
if  (!is_dodging) {
    var input_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
    var input_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));
    
    if (input_x != 0 or input_y != 0) {
        dir = point_direction(0, 0, input_x, -input_y) // remember Y is flipped in GML
        x += input_x * spd;
        y += input_y * spd;
    }
}