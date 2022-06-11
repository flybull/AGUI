/// @function		sc_gui_circle_construct()
/// @description	constructor gui circle config in global
function sc_gui_circle_construct()
{
	gml_pragma("global", "sc_gui_circle_construct()");
	var _classid = GUI_CLASS.CIRCLE;
	sc_gui_global_set_class_construct(
		_classid, "circle",
		sc_gui_circle_config_construct,
		sc_gui_circle
	);
}

/// @function		sc_gui_circle_config_construct()
/// @description	constructor gui circle config in global
function sc_gui_circle_config_construct()
{
	var _class = {cid : GUI_CLASS.CIRCLE, inherit : GUI_CLASS.DEFAULT};
	sc_gui_config_attr_alias_set(_class, "indicat", "circle_indicat");
	sc_gui_config_attr_alias_set(_class, "color", "circle_color");
	sc_gui_config_set_attr_value(_class, {
		circle_indicat : GUI_THEME.INDICAT_COLOR_WARN,
		circle_color : undefined,
		circle_radius : 0,
		direct : GUI_FLEX_DIRECT.NONE,
		attr_shape : undefined,
		func_on_end : sc_gui_circle_init_end,
		func_check_hover : sc_gui_circle_check_hover,
		func_draw_backward : sc_gui_circle_on_draw,
	});
	
	show_debug_message("[global][sc_gui_circle_config_construct] constructor!");	
}

/// @function		sc_gui_circle(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui circle node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
function sc_gui_circle(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_node(__attr, __func_attach, __func_agrs, GUI_CLASS.CIRCLE);
} 

/// @function		sc_gui_circle_init_end()
/// @description	calc circle radius in the end.
function sc_gui_circle_init_end()
{
	sc_gui_node_end();
	circle_radius = floor(max(block_width, block_height) / 2 - border_px);
}

/// @function		sc_gui_circle_check_hover()
/// @description	container_check_hover must ture.
function sc_gui_circle_check_hover()
{
	var _parent = parent;
	var _mouse_x = is_undefined(_parent) ? sc_gui_mouse_x : _parent.hover_x;
	var _mouse_y = is_undefined(_parent) ? sc_gui_mouse_y : _parent.hover_y;
	var _x1 = relative_pos_x;
	var _y1 = relative_pos_y;
	var _radius = circle_radius;
	return point_in_circle(_mouse_x, _mouse_y, 
		_x1 + _radius, _y1 + _radius,
		_radius);
}

/// @function		sc_gui_circle_on_draw()
/// @description	Gui draw circle
function sc_gui_circle_on_draw()
{
	if (flag_visable == false) {
		exit;
	}
	var _x1 = block_x + border_px - 1;
	var _y1 = block_y + border_px - 1;
	var _radius = circle_radius;
	var _color = circle_color;
	if (is_undefined(_color)) {
		_color = sc_gui_config_attr_theme_get(self, circle_indicat);
	}
	
	draw_circle_colour(_x1 + _radius, _y1 + _radius,
		_radius,
		_color, _color, false);
}
