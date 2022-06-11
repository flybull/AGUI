function sc_gui_node_position(__pos_x = 0, __pos_y = 0)
{
	// (pos_x,pox_y) => (pos_x + view_width, pos_y + view_height)
	var _point = sc_gui_node_position_shift(__pos_x, __pos_y);
	return [block_x + _point[0], block_y + _point[1]];
}

function sc_gui_node_position_rotate(
	__block_x, __block_y, __rotate, 
	__pos_x = 0, __pos_y = 0)
{
	var _point = sc_gui_node_position_shift_rotate(__rotate, __pos_x, __pos_y);
	return [__block_x + _point[0], __block_y + _point[1]];
}

function sc_gui_node_position_shift(__pos_x = 0, __pos_y = 0)
{
	var _point = [
		view_width * __pos_x, 
		view_height * __pos_y
	];
	if (__pos_x == 0 && __pos_y == 0) {
		return _point;
	}
	var _rotate = rotate;
	if (_rotate == 0) {
		return _point;
	}
	sc_gui_rotate_to_origin(_point, _rotate, 0, 0);

	return _point;
}

function sc_gui_node_position_shift_rotate(__rotate, __pos_x = 0, __pos_y = 0)
{
	var _point = [
		view_width * __pos_x, 
		view_height * __pos_y
	];
	if (__pos_x == 0 && __pos_y == 0) {
		return _point;
	}
	if (__rotate == 0) {
		return _point;
	}
	sc_gui_rotate_to_origin(_point, __rotate, 0, 0);

	return _point;
}


