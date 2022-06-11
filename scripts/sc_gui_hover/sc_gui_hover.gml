/// @function		sc_gui_node_check()
/// @description	Check hover Gui node.(api)
function sc_gui_node_check()
{
	// Fast to check hover in the window.
	if (!flag_visable || !func[GUI_FUNC_TYPE.CHECK_HOVER]()) {
		if (global.gui.hover_origin_id == sid) {
			sc_gui_node_set_away();
		}
		return false;
	}

	if (!sc_gui_node_check_hover(true)) {
		return false;
	}
	global.gui.hover_origin_id = sid;

	return true;
}

/// @function		sc_gui_node_check_hover(__is_root)
/// @description	Check hover Gui node and node's scale/scroll/childs.(internal use)
function sc_gui_node_check_hover(__is_root = false)
{
	if (!__is_root) {
		if (!flag_visable || !func[GUI_FUNC_TYPE.CHECK_HOVER]()) {
			if (global.gui.hover_node_id == sid) {
				sc_gui_node_set_away();
			}
			return false;
		}
	}
	if (func[GUI_FUNC_TYPE.CHECK_HOVER_SCALE]()) {
		return true;
	}
	if (func[GUI_FUNC_TYPE.CHECK_HOVER_SCROLL]()) {
		return true;
	}
	if (func[GUI_FUNC_TYPE.CHECK_HOVER_CHILDS]()) {
		return true;
	}
	if (flag_hover_hole) {
		return false;
	}
	// Check other hover when hold status.
	if (!flag_hover_lock && status_pressed) {
		return false;
	}
	
	
	var _sid = global.gui.hover_node_id;
	if (!is_undefined(_sid)) {
		if (_sid == sid) {
			return true;
		}
		sc_gui_node_set_away();
	}
	global.gui.hover_node_id = sid;
	status_hover = true;
	origin.status_draw = true;
	func[GUI_FUNC_TYPE.ON_HOVER]();
	return true;
}

/// @function		sc_gui_node_set_away()
/// @description	Set node status from hover to away.(internal use)
function sc_gui_node_set_away()
{
	gml_pragma("forceinline");
	var _node = sc_gui_global_node_find(global.gui.hover_node_id);
	// Maybe can check hold_node_id
	if (!is_undefined(_node) && !_node.status_pressed) {
		with (_node) {
			func[GUI_FUNC_TYPE.ON_AWAY]();
			origin.status_draw = true;
			status_hover = false;
			status_pressed = false;
			status_hold = false;
		}
	}
	global.gui.hover_node_id = undefined;
	global.gui.hover_origin_id = undefined;
}

/// @function		sc_gui_node_check_scrollbar()
/// @description	Check hover Gui scrollbar node .(internal use)
function sc_gui_node_check_scrollbar()
{
	gml_pragma("forceinline");
	if (is_undefined(scrollbar)) {
		return false;
	}
	with (scrollbar) {
		if (sc_gui_node_check_hover()) {
			return true;
		}
	}
	return false;
}
/// @function		sc_gui_node_check_scalebar()
/// @description	Check hover Gui scalebar node .(internal use)
function sc_gui_node_check_scalebar()
{
	gml_pragma("forceinline");
	if (is_undefined(scalebar)) {
		return false;
	}
	with (scalebar) {
		if (sc_gui_node_check_hover()) {
			return true;
		}
	}
	return false;
}

/// @function		sc_gui_node_check_childs()
/// @description	Check hover Gui childs's node.(internal use)
function sc_gui_node_check_childs()
{
	gml_pragma("forceinline");
	var n = ds_list_size(childs);
	if (n == 0) {
		return false;
	}
	
	if (block_direct == GUI_FLEX_DIRECT.GRID) {
		var _list_pos = sc_gui_grid2_mark_find(self);
		if (is_undefined(_list_pos)) {
			return false;
		}
		if (_list_pos >= n) {
			return false;
		}
		with (childs[| _list_pos]) {
			if (sc_gui_node_check_hover()) {
				return true;
			}
		}
		return false;
	}

	// first draw, last check.
	for (var i = n - 1; i >= 0; --i) {
		with (childs[| i]) { 
			if (sc_gui_node_check_hover()) {
				return true;
			}
		}
	}
	return false;
}

//function sc_gui_config_default_check_hover_bakcup_logic()
//{
//	var _parent = parent;
//	if (is_undefined(_parent)) {
//		if (point_in_rectangle(
//			sc_gui_mouse_x, sc_gui_mouse_y, 
//			block_x, block_y, 
//			block_x + view_width, 
//			block_y + view_height)) {
//			hover_x = sc_gui_mouse_x - block_x;
//			hover_y = sc_gui_mouse_y - block_y;
//			return true;
//		}
//		return false
//	}
//	var _stack = ds_stack_create();
//	var _mouse_x;
//	var _mouse_y;
//	//ds_stack_push(_stack, self);
//	while (!is_undefined(_parent)) {
//		ds_stack_push(_stack, _parent);
//		_parent = _parent.parent;
//	}
//	_parent = ds_stack_pop(_stack);
//	_mouse_x = sc_gui_mouse_x - _parent.block_x;
//	_mouse_y = sc_gui_mouse_y - _parent.block_y;
//	for (_parent = ds_stack_pop(_stack); !is_undefined(_parent); _parent = ds_stack_pop(_stack)) {
//		_mouse_x = _mouse_x - _parent.relative_pos_x + _parent.view_x;
//		_mouse_y = _mouse_y - _parent.relative_pos_y + _parent.view_y;
//	}
//	ds_stack_clear(_stack);
//	ds_stack_destroy(_stack);
//	if (!point_in_rectangle(_mouse_x, _mouse_y, 
//		parent.padding_left + parent.view_x, 
//		parent.padding_top + parent.view_y,
//		parent.view_width - parent.padding_right - parent.border_px + parent.view_x ,
//		parent.view_height - parent.padding_bottom - parent.border_px + parent.view_y)) {
//		return false;		
//	}
			
//	_mouse_x = _mouse_x - relative_pos_x + view_x;
//	_mouse_y = _mouse_y - relative_pos_y + view_y;
//	return point_in_rectangle(_mouse_x, _mouse_y, view_x, view_y, view_width + view_x, view_height + view_y);
//}

/// @function		sc_gui_config_default_check_hover()
/// @description	Check hover Gui node of rectangle shape.(internal use)
function sc_gui_config_default_check_hover()
{
	var _parent = parent;
	var _mouse = [0, 0];

	// because x,y = (0,0), so block size need sub 1. (x1,y1) => (x2,y2)
	if (is_undefined(_parent)) {
		_mouse[@ 0] = sc_gui_mouse_x - block_x;
		_mouse[@ 1] = sc_gui_mouse_y - block_y;
		sc_gui_rotate_to_transfer(_mouse, rotate);

		if (point_in_rectangle(_mouse[0], _mouse[1], 0, 0, 
			view_width - 1, view_height - 1)) {
			hover_x = _mouse[0] + view_x;
			hover_y = _mouse[1] + view_y;
			return true;
		}
		return false;
	}

	var _mouse_x = _parent.hover_x;
	var _mouse_y = _parent.hover_y;

	// If mouse in border and padding then back to parent.
	if (!point_in_rectangle(_mouse_x - _parent.view_x, _mouse_y - _parent.view_y,
		_parent.padding_left, _parent.padding_top,
		_parent.view_width - _parent.padding_right - _parent.border_px - 1,
		_parent.view_height - _parent.padding_bottom - _parent.border_px - 1)) {
		return false;		
	}

	_mouse[@ 0] = _mouse_x - relative_pos_x + view_x;
	_mouse[@ 1] = _mouse_y - relative_pos_y + view_y;
	sc_gui_rotate_to_transfer(_mouse, rotate);

	if (point_in_rectangle(_mouse[0], _mouse[1], view_x, view_y,
		view_width + view_x - 1, view_height + view_y - 1)) {
		hover_x = _mouse[0];
		hover_y = _mouse[1];
		return true;
	}
	return false;
}

