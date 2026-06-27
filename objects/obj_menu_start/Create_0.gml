event_inherited();

title = "DUNGEON DODGERS";

items = [
    { label: "New Game", action: function() { obj_game_manager.start_game(); } },
    { spacer: true },   // gap for future items. Maybe a settings menu?
];

// Don't show quit on HTML5
if (os_browser == browser_not_a_browser) {
    array_push(items, { label: "Quit", action: function() { obj_game_manager.quit_game(); } });
}
