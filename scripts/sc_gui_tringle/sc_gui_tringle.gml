enum GUI_TRIANLE_ORIENT {
	LEFT,
	RIGHT,
	UP,
	UPLEFT,
	UPRIGHT,
	DOWN,
	DOWNLEFT,
	DOWNRIGHT,
}

/// @function		sc_gui_triangle_construct()
/// @description	constructor gui triangle config in global
function sc_gui_triangle_construct()
{
	gml_pragma("global", "sc_gui_triangle_construct()");
	var _classid = GUI_CLASS.TRIANGLE;
	sc_gui_global_set_class_construct(
		_classid, "triangle",
		sc_gui_triangle_config_construct,
		sc_gui_triangle
	);
}

/// @function		sc_gui_triangle_config_construct()
/// @description	constructor gui triangle config in global
function sc_gui_triangle_config_construct()
{
	var _class = {cid : GUI_CLASS.TRIANGLE, inherit : GUI_CLASS.DEFAULT};

	sc_gui_config_attr_alias_set(_class, "indicat", "tri_indicat");
	sc_gui_config_attr_alias_set(_class, "orient", "tri_orient");
	sc_gui_config_attr_alias_set(_class, "color", "tri_color");
	sc_gui_config_set_attr_value(_class, {
		tri_indicat : GUI_THEME.INDICAT_COLOR_WARN,
		tri_orient : GUI_TRIANLE_ORIENT.DOWN,
		tri_color : undefined,
		direct : GUI_FLEX_DIRECT.NONE,
		attr_shape : undefined,
		func_check_hover : sc_gui_triangle_check_hover,
		func_draw_backward : sc_gui_triangle_on_draw,
	});
	
	show_debug_message("[global][sc_gui_triangle_config_construct] constructor!");	
}

/// @function		sc_gui_triangle(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui triangle node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
function sc_gui_triangle(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_node(__attr, __func_attach, __func_agrs, GUI_CLASS.TRIANGLE);
} 

/// @function		sc_gui_triangle_check_hover()
/// @description	container_check_hover must ture.
function sc_gui_triangle_check_hover()
{
	var _parent = parent;
	var _mouse_x = is_undefined(_parent) ? sc_gui_mouse_x : _parent.hover_x;
	var _mouse_y = is_undefined(_parent) ? sc_gui_mouse_y : _parent.hover_y;
	var _orient = tri_orient;
	var _width = block_width - 2 * border_px;
	var _height = block_height - 2 * border_px;
	var _x1 = relative_pos_x;
	var _x2 = max(_x1, _x1 + _width);
	var _x3 = _x1 + floor(_width / 2);
	var _y1 = relative_pos_y;
	var _y2 = max(_y1, _y1 + _height);
	var _y3 = _y1 + floor(_height / 2);
	switch(_orient) {
	case GUI_TRIANLE_ORIENT.LEFT:
		return point_in_triangle(_mouse_x, _mouse_y, 
			_x1, _y3, _x2, _y1, _x2, _y2);
	case GUI_TRIANLE_ORIENT.RIGHT:
		return point_in_triangle(_mouse_x, _mouse_y, 
			_x1, _y1, _x2, _y3, _x1, _y2);
	case GUI_TRIANLE_ORIENT.UP:
		return point_in_triangle(_mouse_x, _mouse_y, 
			_x1, _y2, _x3, _y1, _x2, _y2);
	case GUI_TRIANLE_ORIENT.UPLEFT:
		return point_in_triangle(_mouse_x, _mouse_y, 
			_x1, _y1, _x2, _y1, _x1, _y2);
	case GUI_TRIANLE_ORIENT.UPRIGHT:
		return point_in_triangle(_mouse_x, _mouse_y, 
			_x1, _y1, _x2, _y1, _x2, _y2);
	case GUI_TRIANLE_ORIENT.DOWN:
		return point_in_triangle(_mouse_x, _mouse_y, 
			_x1, _y1, _x2, _y1, _x3, _y2);
	case GUI_TRIANLE_ORIENT.DOWNLEFT:
		return point_in_triangle(_mouse_x, _mouse_y, 
			_x1, _y1, _x2, _y2, _x1, _y2);
	case GUI_TRIANLE_ORIENT.DOWNRIGHT:
		return point_in_triangle(_mouse_x, _mouse_y, 
			_x1, _y2, _x2, _y1, _x2, _y2);
	}
	return false;
}

/// @function		sc_gui_triangle_on_draw()
/// @description	Gui draw triangle
function sc_gui_triangle_on_draw()
{
	if (flag_visable == false) {
		exit;
	}
	var _orient = tri_orient;
	var _width = block_width - 2 * border_px;
	var _height = block_height - 2 * border_px;
	var _x1 = block_x + border_px - 1;
	var _x2 = max(_x1, _x1 + _width);
	var _x3 = _x1 + floor(_width / 2);
	var _y1 = block_y + border_px - 1;
	var _y2 = max(_y1, _y1 + _height);
	var _y3 = _y1 + floor(_height / 2);
	var _color = tri_color;
	if (is_undefined(_color)) {
		_color = sc_gui_config_attr_theme_get(self, tri_indicat);
	}
	var _outline = false;
	switch(_orient) {
	case GUI_TRIANLE_ORIENT.LEFT:
		draw_triangle_color(_x1, _y3, _x2, _y1, _x2, _y2, _color, _color, _color, _outline);
		break;
	case GUI_TRIANLE_ORIENT.RIGHT:
		draw_triangle_color(_x1, _y1, _x2, _y3, _x1, _y2, _color, _color, _color, _outline);
		break;
	case GUI_TRIANLE_ORIENT.UP:
		draw_triangle_color(_x1, _y2, _x3, _y1, _x2, _y2, _color, _color, _color, _outline);
		break;
	case GUI_TRIANLE_ORIENT.UPLEFT:
		draw_triangle_color(_x1, _y1, _x2, _y1, _x1, _y2, _color, _color, _color, _outline);
		break;
	case GUI_TRIANLE_ORIENT.UPRIGHT:
		draw_triangle_color(_x1, _y1, _x2, _y1, _x2, _y2, _color, _color, _color, _outline);
		break;
	case GUI_TRIANLE_ORIENT.DOWN:
		draw_triangle_color(_x1, _y1, _x2, _y1, _x3, _y2, _color, _color, _color, _outline);
		break;
	case GUI_TRIANLE_ORIENT.DOWNLEFT:
		draw_triangle_color(_x1, _y1, _x2, _y2, _x1, _y2, _color, _color, _color, _outline);
		break;
	case GUI_TRIANLE_ORIENT.DOWNRIGHT:
		draw_triangle_color(_x1, _y2, _x2, _y1, _x2, _y2, _color, _color, _color, _outline);
		break;
	}
}
