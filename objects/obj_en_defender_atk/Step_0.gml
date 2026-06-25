event_inherited();

if (instance_exists(creator)) {
    if (creator.state == "attacking" || creator.state == "returning") {
        x = creator.x + lengthdir_x(shield_offset, creator.attack_dir);
        y = creator.y + lengthdir_y(shield_offset, creator.attack_dir);
    }
    image_angle = creator.attack_dir + 90;
}