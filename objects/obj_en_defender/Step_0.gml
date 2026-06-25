event_inherited();

if (state == "attacking") {
    if (atk_obj == noone) {
        atk_obj = instance_create_layer(x, y, "Instances", obj_en_defender_atk);
        atk_obj.creator = id;
    }
} else {
    if (instance_exists(atk_obj)) {
        instance_destroy(atk_obj);
        atk_obj = noone;
    }
}