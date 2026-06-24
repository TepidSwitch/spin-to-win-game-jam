if (keyboard_check_pressed(ord("R"))) {
    instance_activate_object(obj_player);
        obj_player.hp = obj_player.HP_DEFAULT;
    obj_player.is_dead = false;
    room_goto(rm_1);
}