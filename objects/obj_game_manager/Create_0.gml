if (instance_number(obj_game_manager) > 1) {
    instance_destroy();
    exit;
}

if (os_browser == browser_not_a_browser) {
    window_set_size(1280, 704);
    window_set_position(30, 60);
}
display_set_gui_size(640, 352);

// Re-fit the HTML5 canvas/backbuffer to the browser, preserving aspect.
html5_fit = function() {
    if (os_browser == browser_not_a_browser) exit;
    var _bw = max(1, browser_width);
    var _bh = max(1, browser_height);
    var _aspect = 640 / 352;
    var _w, _h;
    if (_bw / _bh > _aspect) { _h = _bh; _w = floor(_h * _aspect); } // pillarbox
    else                     { _w = _bw; _h = floor(_w / _aspect); } // letterbox
    if (window_get_width() != _w || window_get_height() != _h) {
        window_set_size(_w, _h);
        surface_resize(application_surface, _w, _h);
    }
    display_set_gui_size(640, 352); // keep HUD/menus in fixed 640×352 coords
};
html5_fit();

is_paused = false;

// Let's get juicy
freeze_timer = 0;
slow_timer   = 0;
slow_every   = 3;
slow_phase   = 0;
world_active = true;

HITSTOP_HIT     = 8;
SLOWMO_NEARMISS = 9;

fx = {
    hitstop:     true,
    slowmo:      true,
    screenshake: 1.0, // 0 = off, 1 = full
};

add_freeze = function(_f) {
    if (!fx.hitstop) return;
    freeze_timer = max(freeze_timer, _f);
};

start_slowmo = function(_f) {
    if (!fx.slowmo) return;
    slow_timer = max(slow_timer, _f);
    slow_phase = 0;
};

on_near_miss = function() {
    start_slowmo(SLOWMO_NEARMISS);
};

shake_timer = 0;
shake_dur   = 1;
shake_mag   = 0;

add_shake = function(_mag, _dur) {
    if (fx.screenshake <= 0 or _dur <= 0) return;
    if (_dur > shake_timer) { shake_timer = _dur; shake_dur = _dur; }
    shake_mag = max(shake_mag, _mag);
};

current_level = 0;

difficulty = 0; // 0 = Forgiving, 1 = Challenging, 2 = Expert

levels = [
    // 1
    {
        player_x: 96, player_y: 160,
        door_x: 545, door_y: 128,
        enemies: [
            { type: obj_en_blocker, x: 500, y: 176 },
        ]
    },
    // 2
    {
        player_x: 96, player_y: 160,
        door_x: 545, door_y: 128,
        enemies: [
            { type: obj_en_chaser, x: 430, y: 110 },
            { type: obj_en_chaser, x: 430, y: 210 },
        ]
    },
    // 3 
    {
        player_x: 96, player_y: 160,
        door_x: 545, door_y: 128,
        enemies: [
            { type: obj_en_chaser,    x: 400, y: 100 },
            { type: obj_en_chaser,    x: 400, y: 220 },
            { type: obj_en_defender,  x: 490, y: 160 },
        ]
    },
    // 4
    {
        player_x: 96, player_y: 176,
        door_x: 545, door_y: 144,
        enemies: [
            { type: obj_en_boss, x: 500, y: 176 },
        ]
    },
    // 5
    {
        player_x: 100, player_y: 176,
        door_x:   570, door_y:   176,
        pickup: { x: 240, y: 176 },
        enemies: [
            { type: obj_en_magician, x: 350, y: 176 }
        ]
    },
    // 6
    {
        player_x: 100, player_y: 176,
        door_x:   570, door_y:   176,
        enemies: [
            { type: obj_en_gambler, x: 350, y: 176 }
        ]
    },
    // 7
    {
        player_x: 100, player_y: 176,
        door_x:   570, door_y:   176,
        enemies: [
            { type: obj_en_pinner, x: 350, y: 176 }
        ]
    },
    // 8
    {
        player_x: 100, player_y: 176,
        door_x:   570, door_y:   176,
        enemies: [
            { type: obj_en_pinner, x: 380, y: 176 },
            { type: obj_en_chaser, x: 280, y: 110 },
        ]
    },
    // 9
    {
        player_x: 100, player_y: 176,
        door_x:   570, door_y:   176,
        enemies: [
            { type: obj_en_gambler, x: 280, y: 176 },
            { type: obj_en_pinner,  x: 420, y: 176 },
        ]
    },
    // 10
    {
        player_x: 100, player_y: 176,
        door_x:   570, door_y:   176,
        enemies: [
            { type: obj_en_gambler,  x: 300, y: 176 },
            { type: obj_en_magician, x: 440, y: 176 },
        ]
    },
    // 11
    {
        player_x: 100, player_y: 176,
        door_x:   570, door_y:   176,
        enemies: [
            { type: obj_en_boss_2, x: 480, y: 176 },
        ]
    },
    // 12
    {
        player_x: 96, player_y: 176,
        door_x: 545, door_y: 176,
        pickup: { x: 240, y: 176 },
        enemies: [
            { type: obj_en_boss_3,   x: 500, y: 176 },
            { type: obj_en_magician, x: 280, y: 80  },
            { type: obj_en_chaser,   x: 280, y: 270 },
        ]
    },
];

load_level = function(_index) {
    with (obj_en) instance_destroy();
    with (obj_en_atk) instance_destroy();
    with (obj_door) instance_destroy();
    with (obj_health_pickup) instance_destroy();
        
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
    
    if (variable_struct_exists(_lvl, "pickup")) {
        var _spawn = false;
        if (difficulty == 0) _spawn = true;
        if (difficulty == 1 && _index == array_length(levels) - 1) _spawn = true;
        if (_spawn) {
            instance_create_layer(_lvl.pickup.x, _lvl.pickup.y, "Enemies", obj_health_pickup);
        }
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
_mouse_detected     = false;
_prev_mouse_x       = device_mouse_x(0);

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
