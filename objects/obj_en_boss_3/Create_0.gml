// Inherit the parent event
event_inherited();

// Sweeping breath
if (instance_exists(atk_obj)) instance_destroy(atk_obj);
atk_obj = instance_create_layer(x - 96, y, "Attacks", obj_en_boss_3_atk);
atk_obj.creator = id;

idle_duration = 75;
spin_spd      = 2.2;
