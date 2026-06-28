event_inherited();

title = "DUNGEON DODGERS";

diff_items = [
    { label: "Forgiving",   action: function() { obj_game_manager.difficulty = 0; obj_game_manager.start_game(); } },
    { label: "Challenging", action: function() { obj_game_manager.difficulty = 1; obj_game_manager.start_game(); } },
    { label: "Expert",      action: function() { obj_game_manager.difficulty = 2; obj_game_manager.start_game(); } },
    { label: "Back",        action: method(id, function() { items = main_items; title = "DUNGEON DODGERS"; selected = 0; }) },
];

main_items = [
    { label: "New Game", action: method(id, function() { items = diff_items; title = "Select Difficulty"; selected = 0; }) },
    { spacer: true },
];

if (os_browser == browser_not_a_browser) {
    array_push(main_items, { label: "Quit", action: function() { obj_game_manager.quit_game(); } });
}

items    = main_items;
selected = 0;
