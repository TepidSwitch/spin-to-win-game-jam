// Darken during pause
if (draw_overlay) {
    draw_set_alpha(0.6);
    draw_set_color(c_black);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);
}

draw_set_font(fnt_default);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Title
if (title != "") {
    draw_set_color(c_white);
    draw_text(cx, 110, title);
}

// Buttons (spacers are gaps)
for (var i = 0; i < array_length(items); i++) {
    if (!is_selectable(i)) continue;
        
    var btn_y = item_y(i);
    var sel = (i == selected);
    
    // Box filled when selected, otherwise lined
    draw_set_color(sel ? c_white : c_dkgray);
    draw_rectangle(cx - btn_w / 2, btn_y - btn_h / 2,
                   cx + btn_w / 2, btn_y + btn_h / 2, !sel );
    
    // Label dark on selected, otherwise white
    draw_set_color(sel ? c_black : c_white);
    draw_text(cx, btn_y, items[i].label); 
}

// Be kind: rewind
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);
