function sc_gui_node_on_layer_x(__hold_x)
{
	gml_pragma("forceinline");
	return (is_undefined(parent) ? sc_gui_mouse_x : parent.hover_x) - __hold_x; // hover_x - view_x;
}

function sc_gui_node_on_layer_y(__hold_y)
{
	gml_pragma("forceinline");
	return (is_undefined(parent) ? sc_gui_mouse_y : parent.hover_y) - __hold_y; // hover_x - view_x;
}

function sc_gui_node_relative_screen()
{
	gml_pragma("forceinline");
	var _parent = parent;
	var _begin_x = is_undefined(_parent) ? 0 : _parent.view_x;
	var _nbegin_x = relative_pos_x;
	var _pos_x = _nbegin_x - _begin_x;
	var _begin_y = is_undefined(_parent) ? 0 : _parent.view_y;
	var _nbegin_y = relative_pos_y;
	var _pos_y = _nbegin_y - _begin_y;
	var _rotate = 0;
	var _point = [_pos_x, _pos_y, 0];
	if (!is_undefined(_parent) && _parent.rotate != 0) {
		// Don't care self rotate, because rotate point is (0, 0) 
		sc_gui_rotate_to_origin(_point, _parent.rotate);
		_rotate += _parent.rotate;
	}
	for (var _node = _parent; !is_undefined(_node); _node = _node.parent) {
		with (_node) {
			_parent = parent;
			_begin_x = is_undefined(_parent) ? 0 : _parent.view_x;
			_nbegin_x = relative_pos_x;
			_point[@ 0] += _nbegin_x - _begin_x;
			_begin_y = is_undefined(_parent) ? 0 : _parent.view_y;
			_nbegin_y = relative_pos_y;
			_point[@ 1] += _nbegin_y - _begin_y;

			if (!is_undefined(_parent) && _parent.rotate != 0) {
				sc_gui_rotate_to_origin(_point, _parent.rotate);
				_rotate += _parent.rotate;
			}
		}
	}
	_point[@ 2] = _rotate;
	return _point;
}

/// @function		sc_gui_measure_limit_x(__left, __right, __x)
/// @description	limit x in the origin bide
/// @left           left boundary expand
/// @right          right boundary expand
/// @x              point x in the screen.
 function sc_gui_measure_limit_x(__left, __right, __x)
{
	gml_pragma("forceinline");
	// why don't use parent to calc the postion
	// because parent maybe invisible.
	with (origin) {
		return min(relative_pos_x + view_width - padding_right - border_px + __right,
			max(relative_pos_x + padding_left + border_px - __left, __x));
	}
}

/// @function		sc_gui_measure_limit_y(__top, __bottom, __y)
/// @description	limit y in the origin bide
/// @top            top boundary expand
/// @bottom         bottom boundary expand
/// @x              point y in the screen.
function sc_gui_measure_limit_y(__top, __bottom, __y)
{
	gml_pragma("forceinline");
	// why don't use parent to calc the postion
	// because parent maybe invisible.
	with (origin) {
		return min(relative_pos_y + view_height - padding_bottom - border_px + __bottom,
			max(relative_pos_y + padding_top + border_px - __top, __y));
	}
}


function sc_gui_measure_relative_left_inside(__dst_node, __screen, __shift, __offset = 0)
{
	var _view_width = view_width;
	gml_pragma("forceinline");
	with (__dst_node) {
		var _res = __screen[2] != 0 ? __shift[0] /*fix calc*/ : - sc_gui_measure_nl2pl_view_width();
		return sc_gui_measure_limit_x(0, -_view_width, __screen[0] + _res + __offset);
	}
}

function sc_gui_measure_relative_left_outside(__dst_node, __screen, __shift, __offset = 0)
{
	gml_pragma("forceinline");
	var _view_width = view_width;
	with (__dst_node) {
		var _res = __screen[2] != 0 ? __shift[0] /*fix calc*/ : - sc_gui_measure_nl2pl_view_width() - _view_width;
		return sc_gui_measure_limit_x(_view_width, -_view_width, __screen[0] + _res + __offset);	
	}
}

function sc_gui_measure_relative_right_inside(__dst_node, __screen, __shift, __offset = 0)
{
	gml_pragma("forceinline");
	var _view_width = view_width;
	with (__dst_node) {
		var _res = __screen[2] != 0 ? __shift[0] /*fix calc*/ : sc_gui_measure_nr2pr_view_width() - _view_width;
		return sc_gui_measure_limit_x(_view_width, -_view_width, __screen[0] + _res + __offset);
	}
}

function sc_gui_measure_relative_right_outside(__dst_node, __screen, __shift, __offset = 0)
{
	gml_pragma("forceinline");
	with (__dst_node) {
		var _res = __screen[2] != 0 ? __shift[0] /*fix calc*/ : sc_gui_measure_nr2pr_view_width();
		return sc_gui_measure_limit_x(0, 0, __screen[0] + _res + __offset);
	}
}

function sc_gui_measure_relative_top_inside(__dst_node, __screen, __shift, __offset = 0)
{
	gml_pragma("forceinline");
	with (__dst_node) {
		var _res = __screen[2] != 0 ? __shift[1] /*fix calc*/ : -sc_gui_measure_nt2pt_view_height();
		return sc_gui_measure_limit_y(0, 0, __screen[1] + _res + __offset);
	}
}

function sc_gui_measure_relative_top_outside(__dst_node, __screen, __shift, __offset = 0)
{
	gml_pragma("forceinline");
	var _view_height = view_height;
	with (__dst_node) {
		var _res = __screen[2] != 0 ? __shift[1] /*fix calc*/ : - sc_gui_measure_nt2pt_view_height() - _view_height;
		return sc_gui_measure_limit_y(_view_height, -_view_height, __screen[1] + _res + __offset);
	}
}

function sc_gui_measure_relative_bottom_inside(__dst_node, __screen, __shift, __offset = 0)
{
	gml_pragma("forceinline");
	var _view_height = view_height;
	with (__dst_node) {
		var _res = __screen[2] != 0 ? __shift[1] /*fix calc*/ : sc_gui_measure_nb2pb_view_height() - _view_height;
		return sc_gui_measure_limit_y(_view_height, 0, __screen[1] + _res + __offset);
	}
}

function sc_gui_measure_relative_bottom_outside(__dst_node, __screen, __shift, __offset = 0)
{
	gml_pragma("forceinline");
	with (__dst_node) {
		var _res = __screen[2] != 0 ? __shift[1] /*fix calc*/ : sc_gui_measure_nb2pb_view_height();
		return sc_gui_measure_limit_y(0, 0, __screen[1] + _res + __offset);
	}
}

function sc_gui_measure_relative_layer_xy(__src, __dst, __judge)
{
	gml_pragma("forceinline");
	if (__src.parent != __dst.parent) {
		var _src_point;
		var _dst_point;
		// In the same surface layer
		if (!sc_gui_judge_node_visable_in_screen(__src, __judge) ||
			!sc_gui_judge_node_visable_in_screen(__dst, __judge)) {
			return undefined;
		}
		with (__src) {
			_src_point = sc_gui_node_relative_screen();
		}
		with (__dst) {
			_dst_point = sc_gui_node_relative_screen();
		}
		return [_src_point[0], _src_point[1], _src_point[2], _dst_point[0], _dst_point[1], _dst_point[2]];
	}
	return [__src.block_x, __src.block_y, __src.rotate, __dst.block_x, __dst.block_y, __dst.rotate];
}
