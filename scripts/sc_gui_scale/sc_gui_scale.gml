enum GUI_SCALE_DIRECT {
	NONE,
	UP_LEFT,
	UP,
	UP_RIGHT,
	LEFT,
	RIGHT,
	DOWN_LEFT,
	DOWN,
	DOWN_RIGHT,
}

/// @function		sc_gui_scale_construct()
/// @description	constructor gui scale config in global
function sc_gui_scale_construct()
{
	gml_pragma("global", "sc_gui_scale_construct()");
	var _classid = GUI_CLASS.SCALE;
	sc_gui_global_set_class_construct(
		_classid, "scale",
		sc_gui_scale_config_construct,
		sc_gui_scale
	);
}

/// @function		sc_gui_scale_config_construct()
/// @description	constructor gui scale config in global
function sc_gui_scale_config_construct() {
	var _class = {cid : GUI_CLASS.SCALE, inherit : GUI_CLASS.DEFAULT };
	sc_gui_config_attr_value_set(_class, {
		scale_x : 0,
		scale_y : 0,
		scale_px : 4,
		scale_dir : GUI_SCALE_DIRECT.NONE,

		attr_shape : undefined,
		func_check_hover : sc_gui_scale_check_hover,
		func_on_away : sc_gui_scale_on_away,
		func_on_press : sc_gui_scale_on_press,
		func_on_hold : sc_gui_scale_on_hold,
		func_on_release : sc_gui_scale_on_release,
		func_on_draw : sc_base_empty_call,
	});
	
	show_debug_message("[global][sc_gui_scale_config_construct] constructor!");
}

/// @function		sc_gui_scale(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui scale node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
function sc_gui_scale(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_orphan(__attr, __func_attach, __func_agrs, GUI_CLASS.SCALE);
}


/// @function		sc_gui_scale_check_hover()
/// @description	container_check_hover must ture.
function sc_gui_scale_check_hover()
{
	if (is_undefined(parent)) {
		return false;
	}
	var _node = parent;
	var _scale_axis;
	var _view_width, _view_height;
	var _hover_x, _hover_y;
	var _x1, _y1, _x2, _y2;
	var _px = scale_px;
	var _half_px = _px / 2;
	with (_node) {
		_view_width = view_width;
		_view_height = view_height;
		_hover_x = hover_x;
		_hover_y = hover_y;
		_scale_axis = flag_scale;
	}
	if (_scale_axis == GUI_AXIS_TYPE.NONE) {
		exit;
	}
	if (_px < _view_height && (_scale_axis == GUI_AXIS_TYPE.BOTH || 
		_scale_axis == GUI_AXIS_TYPE.HORIZONTAL)) {
		_y1 = _half_px;
		_y2 = _view_height - _half_px - 1;
		
		_x1 = 0;
		_x2 = _half_px;
		if (point_in_rectangle(_hover_x, _hover_y, _x1, _y1, _x2, _y2)) {
			scale_dir = GUI_SCALE_DIRECT.LEFT;
			window_set_cursor(cr_size_we);
			return true;
		}
		
		_x1 = max(0, _view_width - 1 - _half_px);
		_x2 = _view_width - 1;
		if (point_in_rectangle(_hover_x, _hover_y, _x1, _y1, _x2, _y2)) {
			scale_dir = GUI_SCALE_DIRECT.RIGHT;
			window_set_cursor(cr_size_we);
			return true;
		}
	}
	
	if (_px < _view_width && (_scale_axis == GUI_AXIS_TYPE.BOTH ||
		_scale_axis == GUI_AXIS_TYPE.VERTICAL)) {
		_x1 = _half_px;
		_x2 = _view_width - _half_px - 1;
		
		_y1 = 0;
		_y2 = _half_px;
		if (point_in_rectangle(_hover_x, _hover_y, _x1, _y1, _x2, _y2)) {
			scale_dir = GUI_SCALE_DIRECT.UP;
			window_set_cursor(cr_size_ns);
			return true;
		}
		
		_y1 = max(0, _view_height - 1 - _half_px);
		_y2 = _view_height - 1;
		if (point_in_rectangle(_hover_x, _hover_y, _x1, _y1, _x2, _y2)) {
			scale_dir = GUI_SCALE_DIRECT.DOWN;
			window_set_cursor(cr_size_ns);
			return true;
		}		
	}

	if (_scale_axis == GUI_AXIS_TYPE.BOTH) {
		if (point_in_rectangle(_hover_x, _hover_y, 
				0,
				0,
				min(_half_px, _view_width - 1), 
				min(_half_px, _view_height - 1))) {
			scale_dir = GUI_SCALE_DIRECT.UP_LEFT;
			window_set_cursor(cr_size_nwse);
			return true;
		}
		if (point_in_rectangle(_hover_x, _hover_y,
				max(0, _view_width - _half_px - 1), 
				0, 
				max(0, _view_width - 1), 
				min(_half_px, _view_height - 1))) {
			scale_dir = GUI_SCALE_DIRECT.UP_RIGHT;
			window_set_cursor(cr_size_nesw);
			return true;
		}
		if (point_in_rectangle(_hover_x, _hover_y,
				0,
				max(0, _view_height - _half_px - 1),
				min(_half_px, _view_width - 1),
				max(0, _view_height - 1))) {
			scale_dir = GUI_SCALE_DIRECT.DOWN_LEFT;
			window_set_cursor(cr_size_nesw);
			return true;
		}
		if (point_in_rectangle(_hover_x, _hover_y,
				max(0, _view_width - _half_px - 1),
				max(0, _view_height - _half_px - 1),
				max(0, _view_width - 1),
				max(0, _view_height - 1))) {
			scale_dir = GUI_SCALE_DIRECT.DOWN_RIGHT;
			window_set_cursor(cr_size_nwse);
			return true;
		}
	}
	return false;
}

function sc_gui_scale_on_away()
{
	window_set_cursor(cr_default);
}

function sc_gui_scale_on_press()
{
	scale_x = sc_gui_mouse_x;
	scale_y = sc_gui_mouse_y;
}

function sc_gui_scale_on_hold()
{
	if (is_undefined(parent)) {
		return false;
	}
	var _node = parent;
	var _scale_dir = scale_dir;
	var _diff_x = sc_gui_mouse_x - scale_x;
	var _diff_y = sc_gui_mouse_y - scale_y;
	scale_x = sc_gui_mouse_x;
	scale_y = sc_gui_mouse_y;
	if (_diff_x == 0 && _diff_y == 0) {
		exit;
	}
		
	with (_node) {
		var _width = sc_gui_node_layer_get_content_width(GUI_ENTITY_TYPE.VIEW_NO_PB);
		var _height = sc_gui_node_layer_get_content_height(GUI_ENTITY_TYPE.VIEW_NO_PB);
		var _spec_width = spec_width;
		var _spec_height = spec_height;
		var _padding_left = padding_left;
		var _padding_top = padding_top;
		var _view_width = view_width;
		var _view_height = view_height;
		var _boundary_x;
		var _boundary_y;
		
		switch (_scale_dir) {
		case GUI_SCALE_DIRECT.UP_LEFT:
			_diff_x = sc_gui_node_scale_boundary_left(_diff_x);
			_diff_y = sc_gui_node_scale_boundary_top(_diff_y);
		
			_boundary_x = _view_width + sc_gui_node_to_boundary_left();
			_boundary_y = _view_height + sc_gui_node_to_boundary_top();
		
			_width = max(0, _width - _diff_x);
			_width = min(_width, _boundary_x);
			_height = max(0, _height - _diff_y);
			_height = min(_height, _boundary_y);
			break;
		case GUI_SCALE_DIRECT.UP_RIGHT:
			_diff_x = sc_gui_node_scale_boundary_right(_diff_x);
			_diff_y = sc_gui_node_scale_boundary_top(_diff_y);
			_boundary_x = _view_width + sc_gui_node_to_boundary_right();
			_boundary_y = _view_height + sc_gui_node_to_boundary_top();
				
			_width = max(0, _width + _diff_x);
			_width = min(_width, _boundary_x);
			_height = max(0, _height - _diff_y);
			_height = min(_height, _boundary_y);
			break;
		case GUI_SCALE_DIRECT.DOWN_LEFT:
			_diff_x = sc_gui_node_scale_boundary_left(_diff_x);
			_diff_y = sc_gui_node_scale_boundary_bottom(_diff_y);
			_boundary_x = _view_width + sc_gui_node_to_boundary_left();
			_boundary_y = _view_height + sc_gui_node_to_boundary_bottom();
				
			_width = max(0, _width - _diff_x);
			_width = min(_width, _boundary_x);
			_height = max(0, _height + _diff_y);
			_height = min(_height, _boundary_y);
			break;
		case GUI_SCALE_DIRECT.DOWN_RIGHT:
			_diff_x = sc_gui_node_scale_boundary_right(_diff_x);
			_diff_y = sc_gui_node_scale_boundary_bottom(_diff_y);
			_boundary_x = _view_width + sc_gui_node_to_boundary_right();
			_boundary_y = _view_height + sc_gui_node_to_boundary_bottom();
			
			_width = max(0, _width + _diff_x);
			_width = min(_width, _boundary_x);
			_height = max(0, _height + _diff_y);
			_height = min(_height, _boundary_y);
			break;
		case GUI_SCALE_DIRECT.UP:
			_diff_y = sc_gui_node_scale_boundary_top(_diff_y);
			_boundary_y = _view_height + sc_gui_node_to_boundary_top();
			
			_width = _spec_width;
			_height = max(0, _height - _diff_y);
			_height = min(_height, _boundary_y);
			break;
		case GUI_SCALE_DIRECT.DOWN:
			_diff_y = sc_gui_node_scale_boundary_bottom(_diff_y);
			_boundary_y = _view_height + sc_gui_node_to_boundary_bottom();
			
			_width = _spec_width;
			_height = max(0, _height + _diff_y);
			_height = min(_height, _boundary_y);
			break;
		case GUI_SCALE_DIRECT.LEFT:
			_diff_x = sc_gui_node_scale_boundary_left(_diff_x);
			_boundary_x = _view_width + sc_gui_node_to_boundary_left();

			_width = max(0, _width - _diff_x);
			_width = min(_width, _boundary_x);
			_height = _spec_height;
			break;
		case GUI_SCALE_DIRECT.RIGHT:
			_diff_x = sc_gui_node_scale_boundary_right(_diff_x);
			_boundary_x = _view_width + sc_gui_node_to_boundary_right();

			_width = max(0, _width + _diff_x);
			_width = min(_width, _boundary_x);
			_height = _spec_height;
			break;
		default:
			exit;
		}
		if (_spec_width != _width || _spec_height != _height) {
			sc_gui_node_event_update_size(_width, _height, _padding_left, _padding_top);
		}

		if (!is_undefined(parent) && 
			parent.block_direct != GUI_FLEX_DIRECT.NONE) {
			exit;
		}
		switch (_scale_dir) {
		case GUI_SCALE_DIRECT.DOWN_LEFT:
		case GUI_SCALE_DIRECT.LEFT:
			sc_gui_node_scale_boundary_left_move_x(_diff_x);
			break;
		case GUI_SCALE_DIRECT.UP_RIGHT:
		case GUI_SCALE_DIRECT.UP:
			sc_gui_node_scale_boundary_top_move_y(_diff_y);
			break;
		case GUI_SCALE_DIRECT.UP_LEFT:
			sc_gui_node_scale_boundary_left_move_x(_diff_x);
			sc_gui_node_scale_boundary_top_move_y(_diff_y);
			break;
		default:
			exit;
		}
		sc_ds_list_foreach_before("childs", sc_gui_node_move_xy);
	}
}

function sc_gui_scale_on_release()
{
	scale_x = 0; 
	scale_y = 0;
}


function sc_gui_node_scale_boundary_left(__diff_x)
{
	gml_pragma("forceinline");
	if (__diff_x >= 0) {
		if (flag_scroll & GUI_AXIS_TYPE.HORIZONTAL) {
			return min(__diff_x, sc_gui_node_layer_get_content_width(GUI_ENTITY_TYPE.VIEW_NO_PB));
		}
		var _diff = sc_gui_node_layer_get_content_width(GUI_ENTITY_TYPE.VIEW_NO_PB) - 
			sc_gui_node_layer_get_content_width(GUI_ENTITY_TYPE.CONTENT_ORG);
		return max(0, min(__diff_x, _diff));
	}
	return max(__diff_x, -sc_gui_node_to_boundary_left());
}

function sc_gui_node_scale_boundary_right(__diff_x)
{
	gml_pragma("forceinline");
	if (__diff_x < 0) {
		return max(__diff_x, -(sc_gui_node_layer_get_content_width(GUI_ENTITY_TYPE.VIEW_NO_PB)));
	}
	return min(__diff_x, sc_gui_node_to_boundary_right());
}

function sc_gui_node_scale_boundary_top(__diff_y)
{
	gml_pragma("forceinline");
	if (__diff_y >= 0) {
		if (flag_scroll & GUI_AXIS_TYPE.VERTICAL) {
			return min(__diff_y, sc_gui_node_layer_get_content_height(GUI_ENTITY_TYPE.VIEW_NO_PB));
		}
		var _diff = sc_gui_node_layer_get_content_height(GUI_ENTITY_TYPE.VIEW_NO_PB) - 
			sc_gui_node_layer_get_content_height(GUI_ENTITY_TYPE.CONTENT_ORG);
		return max(0, min(__diff_y, _diff));
	}
	return max(__diff_y, -sc_gui_node_to_boundary_top());
}

function sc_gui_node_scale_boundary_bottom(__diff_y)
{
	gml_pragma("forceinline");
	if (__diff_y < 0) {
		return max(__diff_y, -(sc_gui_node_layer_get_content_height(GUI_ENTITY_TYPE.VIEW_NO_PB)));
	}
	return min(__diff_y, sc_gui_node_to_boundary_bottom());
}

/// @function		sc_gui_node_scale_boundary_left_move_x(_diff_x)
/// @description	Move node x and y.
function sc_gui_node_scale_boundary_left_move_x(__diff_x)
{
	gml_pragma("forceinline");
	var _pos_x = relative_pos_x;
	
	_pos_x += sc_gui_node_scale_boundary_left(__diff_x);
	_pos_x = max(0, _pos_x);
	_pos_x = max(_pos_x, -sc_gui_node_to_boundary_left());
	relative_pos_x = _pos_x;
}

/// @function		sc_gui_node_scale_boundary_top_move_y(__diff_y)
/// @description	Move node x and y.
function sc_gui_node_scale_boundary_top_move_y(__diff_y)
{
	gml_pragma("forceinline");
	var _pos_y = relative_pos_y;

	_pos_y += sc_gui_node_scale_boundary_top(__diff_y);
	_pos_y = max(0, _pos_y);
	_pos_y = max(_pos_y, -sc_gui_node_to_boundary_top());
	relative_pos_y = _pos_y;
}
