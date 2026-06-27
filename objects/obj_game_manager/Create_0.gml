if (instance_number(obj_game_manager) > 1) {
    instance_destroy();
    exit;
}

window_set_size(1280, 704);
window_set_position(30, 60);
display_set_gui_size(640, 352);

is_paused = false;

current_level = 0;

levels = [
    // 1
    {
        player_x: 96, player_y: 160,
        door_x: 545, door_y: 128,
        enemies: [
            { type: obj_en, x: 480, y: 160 },
        ]
    },
    // 2
    {
        player_x: 96, player_y: 160,
        door_x: 545, door_y: 128,
        enemies: [
            { type: obj_en_chaser, x: 448, y: 138 },
            { type: obj_en_chaser, x: 448, y: 200 },
        ]
    },
    // 3 
    {
        player_x: 96, player_y: 160,
        door_x: 545, door_y: 128,
        enemies: [
            { type: obj_en_chaser, x: 448, y: 96 },
            { type: obj_en_defender, x: 512, y: 160 },
            { type: obj_en_chaser, x: 448, y: 224 },
        ]
    }, 
];

load_level = function(_index) {
    with (obj_en) instance_destroy();
    with (obj_en_atk) instance_destroy();
    with (obj_door) instance_destroy();
        
    var _lvl = levels[_index];
    
    if (instance_exists(obj_player)) {
        obj_player.x = _lvl.player_x;
        obj_player.y = _lvl.player_y;
    } else {
        instance_create_layer(_lvl.player_x, _lvl.player_y, "Player", obj_player);
    }
    
    instance_create_layer(_lvl.door_x, _lvl.door_y, "Enemies", obj_door);
    
    var _enemies = _lvl.enemies;
    for (var i = 0; i < array_length(_enemies); i++) {
        var _e = _enemies[i];
        instance_create_layer(_e.x, _e.y, "Enemies", _e.type);
    }
};

// Helper methods
restart_game = function() {
    instance_activate_object(obj_player);
    obj_player.hp = obj_player.HP_DEFAULT;
    obj_player.is_dead = false;
    current_level = 0;
    room_goto(rm_1);
}

// Keyboard Input Struct
controls = {
    move_left:  [ord("A"), vk_left],
    move_right: [ord("D"), vk_right],
    move_up:    [ord("W"), vk_up],
    move_down:  [ord("S"), vk_down],
    dodge:      [ord("J"), vk_space],
    confirm:    [vk_space, vk_enter],
    pause:      [ord("P"), vk_escape],
    restart:    [ord("R")],
}

// Touch Input Struct
touch = {
    move_x: 0,
    move_y: 0,
    dodge: false,
    dodge_pressed: false,
    dodge_released: false,
    confirm_pressed: false,
    pause_pressed: false,
};

// Internal touch tracking
_touch_joy_dev      = -1;
_touch_joy_ox       = 0;
_touch_joy_oy       = 0;
_touch_dodge_dev    = -1;
_touch_dodge_prev   = false;
_touch_pause_prev   = false;

// Menu Commands
pause_menu = noone;

start_game = function() {
    is_paused = false;
    if (instance_exists(pause_menu)) instance_destroy(pause_menu);
    
    current_level = 0;
    if (instance_exists(obj_player)) {
        obj_player.hp = obj_player.HP_DEFAULT;
        obj_player.is_dead = false;
    }
    
    room_goto(rm_1);
};

goto_menu = function() {
    is_paused = false;
    if (instance_exists(pause_menu)) instance_destroy(pause_menu);
    if (instance_exists(obj_player)) instance_destroy(obj_player);
    
    current_level = 0;
    room_goto(rm_menu);
};

quit_game = function() {
    game_end();
};

pause_game = function() {
    is_paused = true;
    pause_menu = instance_create_depth(0, 0, -1000, obj_menu_pause);
};

resume_game = function() {
    is_paused = false;
    if (instance_exists(pause_menu)) instance_destroy(pause_menu);
    if (instance_exists(obj_player)) obj_player.charge_needs_repress = true;
};
