draw_set_font(fnt_default);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);

var _hint = (os_browser != browser_not_a_browser) ? "Tap to restart" : "Press R to restart";
draw_text(display_get_gui_width() / 2, display_get_gui_height() / 2, "GOTTA DODGE THOSE!\n" + _hint);

draw_set_halign(fa_left);
draw_set_valign(fa_top);