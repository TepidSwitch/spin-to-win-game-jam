function move_with_collision(_spd, _dir){
    var dx = lengthdir_x(_spd, _dir);
    var dy = lengthdir_y(_spd, _dir);
    if (!wall_check(id, x + dx, y)) x += dx;
    if (!wall_check(id, x, y + dy)) y += dy;
}