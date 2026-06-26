function wall_check(_inst, _x, _y) {
    var _tm = layer_tilemap_get_id("Collision");
    var _x1 = _x - _inst.sprite_xoffset;
    var _x2 = _x + (_inst.sprite_width - _inst.sprite_xoffset) - 1;
    var _y1 = _y - _inst.sprite_yoffset;
    var _y2 = _y + (_inst.sprite_height - _inst.sprite_yoffset) - 1;
    
    return tilemap_get_at_pixel(_tm, _x1, _y1) != 0
        or tilemap_get_at_pixel(_tm, _x2, _y1) != 0
        or tilemap_get_at_pixel(_tm, _x1, _y2) != 0
        or tilemap_get_at_pixel(_tm, _x2, _y2) != 0;
}