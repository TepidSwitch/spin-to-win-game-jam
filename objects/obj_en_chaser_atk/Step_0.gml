// Inherit the parent event
event_inherited();

if (instance_exists(creator)) {
    x = creator.x + lengthdir_x(lance_offset, creator.attack_dir);
    y = creator.y + lengthdir_y(lance_offset, creator.attack_dir);
    image_angle = creator.attack_dir - 90;
}