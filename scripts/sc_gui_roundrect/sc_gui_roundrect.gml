/// @function		sc_gui_roundrect_construct()
/// @description	constructor gui round config in global
function sc_gui_roundrect_construct()
{
	gml_pragma("global", "sc_gui_roundrect_construct()");
	var _classid = GUI_CLASS.ROUNDRECT;
	sc_gui_global_set_class_construct(
		_classid, "roundrect",
		sc_gui_roundrect_config_construct,
		sc_gui_roundrect
	);
}

/// @function		sc_gui_roundrect_config_construct()
/// @description	constructor gui round config in global
function sc_gui_roundrect_config_construct()
{
	var _class = {cid : GUI_CLASS.ROUNDRECT, inherit : GUI_CLASS.DEFAULT};

	sc_gui_config_attr_alias_set(_class, "indicat", "roundrect_indicat");
	sc_gui_config_attr_alias_set(_class, "rad", "roundrect_rad");
	sc_gui_config_attr_alias_set(_class, "xrad", "roundrect_xrad");
	sc_gui_config_attr_alias_set(_class, "yrad", "roundrect_yrad");
	sc_gui_config_attr_alias_set(_class, "color", "roundrect_color");
	sc_gui_config_set_attr_value(_class, {
		roundrect_indicat : GUI_THEME.INDICAT_COLOR_WARN,
		roundrect_rad  : 8,
		roundrect_xrad : 0.3,
		roundrect_yrad : 0.3,
		roundrect_color : undefined,
		direct : GUI_FLEX_DIRECT.NONE,
		attr_shape : undefined,
		func_draw_backward : sc_gui_roundrect_on_draw,
	});
	
	show_debug_message("[global][sc_gui_roundrect_config_construct] constructor!");	
}

/// @function		sc_gui_roundrect(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui round node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
function sc_gui_roundrect(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_node(__attr, __func_attach, __func_agrs, GUI_CLASS.ROUNDRECT);
}

/// @function		sc_gui_roundrect_on_draw()
/// @description	Gui draw round
function sc_gui_roundrect_on_draw()
{
	if (flag_visable == false) {
		exit;
	}
	var _width = block_width - 2 * border_px;
	var _height = block_height - 2 * border_px;
	var _rad = roundrect_rad;
	var _x1 = block_x + border_px - 1;
	var _x2 = max(_x1, _x1 + _width);
	var _y1 = block_y + border_px - 1;
	var _y2 = max(_y1, _y1 + _height);
	var _color = roundrect_color;
	if (is_undefined(_color)) {
		_color = sc_gui_config_attr_theme_get(self, roundrect_indicat);
	}
	draw_roundrect_colour_ext(_x1, _y1, _x2, _y2,
		_rad, _rad, _color, _color, false);
}
