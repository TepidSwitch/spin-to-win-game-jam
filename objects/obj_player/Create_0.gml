spd = 2.2;
dir = 0; // facing direction (0=right, 90=up, 180=left, 270=down)


// Quick Dodge
DODGE_SPD_DEFAULT = 8;
dodge_spd = DODGE_SPD_DEFAULT;

dodge_dur = 12; // i frames
dodge_cd = 25;

dodge_timer = 0;
dodge_cd_timer = 0;

is_dodging = false;

// Charged Dodge
charge_time_needed = 40; 
charge_timer = 0;

charged_dodge_dur = 22;
charged_dodge_spd = 11;

is_charging = false;

charge_needs_repress = false;

// I Frame Tracking
invincible = false;
inv_timer = 0;
hit_inv_duration = 60;

// Health
HP_DEFAULT = 3;
hp = HP_DEFAULT;
is_dead = false;

// Knockback
kb_x = 0;
kb_y = 0;
kb_friction = 0.75 // tunable

// Stun
stun_timer = 0;
stun_duration = 18;

// Status Effects
move_flip = false;

// Helper Methods
take_damage = function(_attacker_x, _attacker_y, _kb_force = 8) {
    if (invincible) exit;
        
    hp--;
    
    charge_needs_repress = is_charging or input_check(obj_game_manager.controls.dodge);
    is_charging = false;
    charge_timer = 0;
    
    invincible = true;
    inv_timer = hit_inv_duration;
    stun_timer = stun_duration;
    
    var _dx = x - _attacker_x;
    var _dy = y - _attacker_y;
    var _len = point_distance(0, 0, _dx, _dy);
    if (_len > 0) {
        kb_x = (_dx / _len) * _kb_force;
        kb_y = (_dy / _len) * _kb_force;
    }
}