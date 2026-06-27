event_inherited();

draw_overlay = true;
title = "PAUSED";

items = [
    { label: "Resume", action: function() { obj_game_manager.resume_game(); } },
    { label: "Main Menu", action: function() { obj_game_manager.goto_menu(); } },
];

// Don't show quit on HTML5
if (os_browser == browser_not_a_browser) {
    array_push(items, { label: "Quit", action: function() { obj_game_manager.quit_game(); } });
}