// Body
var x1 = x - sprite_xoffset;
var x2 = x1 + sprite_width;
var y1 = y - sprite_yoffset;
var y2 = y1 + sprite_height;

draw_set_color(c_red);
draw_rectangle(x1, y1, x2, y2, false);

// >:( face
draw_set_color(c_black);

// Angry eyebrows
draw_line_width(x - 20, y - 18, x - 6, y - 12, 3);
draw_line_width(x + 20, y - 18, x + 6, y - 12, 3);

// Eyes
draw_circle(x - 12, y - 4, 4, false);
draw_circle(x + 12, y - 4, 4, false);

// Frowning mouth 
draw_line_width(x - 14, y + 18, x,      y + 10, 3);
draw_line_width(x,      y + 10, x + 14, y + 18, 3);

draw_set_color(c_white);