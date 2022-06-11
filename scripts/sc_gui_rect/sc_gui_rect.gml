
/// @function		sc_gui_rect_construct()
/// @description	constructor gui rect config in global
function sc_gui_rect_construct()
{
	gml_pragma("global", "sc_gui_rect_construct()");
	var _classid = GUI_CLASS.RECT;
	sc_gui_global_set_class_construct(
		_classid, "rect",
		sc_gui_rect_config_construct,
		sc_gui_rect
	);
}

/// @function		sc_gui_rect_config_construct()
/// @description	constructor gui rect config in global
function sc_gui_rect_config_construct()
{
	var _class = {cid : GUI_CLASS.RECT, inherit : GUI_CLASS.DEFAULT};

	sc_gui_config_attr_alias_set(_class, "indicat", "rect_indicat");
	sc_gui_config_attr_alias_set(_class, "color", "rect_color");
	sc_gui_config_set_attr_value(_class, {
		rect_indicat : GUI_THEME.INDICAT_COLOR_WARN,
		rect_color: undefined,
		direct : GUI_FLEX_DIRECT.NONE,
		attr_shape : undefined,
		func_draw_backward : sc_gui_rect_on_draw,
	});
	
	show_debug_message("[global][sc_gui_rect_config_construct] constructor!");	
}

/// @function		sc_gui_rect(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui rect node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
function sc_gui_rect(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_node(__attr, __func_attach, __func_agrs, GUI_CLASS.RECT);
}

/// @function		sc_gui_rect_on_draw()
/// @description	Gui draw rect
function sc_gui_rect_on_draw()
{
	if (flag_visable == false) {
		exit;
	}
	var _width = block_width - 2 * border_px;
	var _height = block_height - 2 * border_px;
	var _x1 = block_x + border_px;
	var _x2 = max(_x1, _x1 + _width - 1);
	var _y1 = block_y + border_px;
	var _y2 = max(_y1, _y1 + _height - 1);
	var _color = rect_color;
	if (is_undefined(_color)) {
		_color = sc_gui_config_attr_theme_get(self, rect_indicat);
	}
	draw_rectangle_color(_x1, _y1, _x2, _y2, 
		_color, _color, _color, _color, false);
}
