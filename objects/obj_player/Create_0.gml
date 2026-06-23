// Movement
spd = 3;
dir = 0; // facing direction (0=right, 90=up, 180=left, 270=down)


// Quick Dodge
dodge_spd = 8;
dodge_spd_default = 8;
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

// I Frame Tracking
invincible = false;
inv_timer = 0;
hit_inv_duration = 60;

// Health
hp = 3;
is_dead = false;

// Helper Methods
take_damage = function() {
    if (invincible) exit;
        
    hp--;
    invincible = true;
    inv_timer = hit_inv_duration;
}