// see [rectangle_in_rectangle] docs
enum GUI_VISABLE_JUDGE {
	NO_COLLISON  = 0,
	ENCOMPASSED  = 1,
	EDGE_OVERLAP = 2,
	BOTH         = 3,
}

function sc_gui_judge_node_visable_in_parent(__node, __judge = GUI_VISABLE_JUDGE.BOTH)
{
	if (!__node.flag_visable) {
		exit;
	}
	var _parent = __node.parent;
	if (is_undefined(_parent)) {
		var _x1 = __node.block_x;
		var _y1 = __node.block_y;
		var _x2 = _x1 + __node.view_width;
		var _y2 = _y1 + __node.view_height;
		// FIX : ROTATE
		return __judge == rectangle_in_rectangle(_x1, _y1, _x2, _y2,
			0, 0, display_get_gui_width(), display_get_gui_height());
	
	}
	var _x1 = __node.relative_pos_x;
	var _y1 = __node.relative_pos_y;
	var _x2 = _x1 + __node.view_width;
	var _y2 = _y1 + __node.view_height;
	// FIX : ROTATE
	return __judge & rectangle_in_rectangle(_x1, _y1, _x2, _y2,
		_parent.view_x, _parent.view_y, 
		_parent.view_x + _parent.view_width,
		_parent.view_y + _parent.view_height) ? true : false;
}

function sc_gui_judge_node_visable_in_screen(__node, __judge = GUI_VISABLE_JUDGE.BOTH)
{
	for (var _node = __node; !is_undefined(_node); _node = _node.parent) {
		if (!sc_gui_judge_node_visable_in_parent(_node, __judge)) {
			return false;
		}
	}
	return true;
}
