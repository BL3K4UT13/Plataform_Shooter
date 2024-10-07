if not instance_exists(global.target_) exit;
x = lerp(x, global.target_.x, 0.1);
y = lerp(y, global.target_.y-height_/8,0.1)
camera_set_view_pos(view_camera[0], x-width_/2, y-height_/2);
