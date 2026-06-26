display_set_gui_size(640, 352);

current_level = 0;

levels = [
    // 1
    {
        player_x: 96, player_y: 160,
        door_x: 545, door_y: 128,
        enemies: [
            { type: obj_en_chaser, x: 480, y: 160 },
        ]
    },
    // 2
    {
        player_x: 96, player_y: 160,
        door_x: 545, door_y: 128,
        enemies: [
            { type: obj_en_chaser, x: 448, y: 138 },
            { type: obj_en_chaser, x: 448, y: 224 },
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

load_level(current_level);