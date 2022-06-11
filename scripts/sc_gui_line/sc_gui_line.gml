/// @function		sc_gui_line_construct()
/// @description	constructor gui line config in global
function sc_gui_line_construct()
{
	gml_pragma("global", "sc_gui_line_construct()");
	var _classid = GUI_CLASS.LINE;
	sc_gui_global_set_class_construct(
		_classid, "line",
		sc_gui_line_config_construct,
		sc_gui_line
	);
}

/// @function		sc_gui_line_config_construct()
/// @description	constructor gui line config in global
function sc_gui_line_config_construct()
{
	var _class = {cid : GUI_CLASS.LINE, inherit : GUI_CLASS.DEFAULT};

	sc_gui_config_attr_alias_set(_class, "indicat", "line_indicat");
	sc_gui_config_attr_alias_set(_class, "color", "line_color");
	sc_gui_config_attr_alias_set(_class, "width", "line_width");
	sc_gui_config_attr_alias_set(_class, ["src", "src_uri"], "line_src_uri");
	sc_gui_config_attr_alias_set(_class, ["dst", "dst_uri"], "line_dst_uri");
	sc_gui_config_attr_value_set(_class, {
		line_indicat : GUI_THEME.INDICAT_COLOR_WARN,
		line_color: undefined,
		line_width : 2,
		line_src_uri : undefined,
		line_dst_uri : undefined,
		attr_shape : undefined,
		func_check_hover : function() { return false; },
		func_on_draw : sc_gui_line_on_draw,
	});
	
	show_debug_message("[global][sc_gui_line_config_construct] constructor!");	
}

/// @function		sc_gui_line(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui line node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
function sc_gui_line(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_root(__attr, __func_attach, __func_agrs, GUI_CLASS.LINE);
}

/// @function		sc_gui_line_on_draw()
/// @description	Gui draw line
function sc_gui_line_on_draw()
{
	if (flag_visable == false) {
		exit;
	}
	var _dst = sc_gui_node_uri_router(line_dst_uri);
	var _src = sc_gui_node_uri_router(line_src_uri);
	if (is_undefined(_dst) || is_undefined(_src)) {
		exit;
	}
	var _res = sc_gui_measure_relative_layer_xy(_src, _dst, GUI_VISABLE_JUDGE.ENCOMPASSED);
	if (is_undefined(_res)) {
		exit;
	}
	var _sx = _res[0];
	var _sy = _res[1];
	var _sr = _res[2];
	var _dx = _res[3];
	var _dy = _res[4];
	var _dr = _res[5];

	var _sc;
	var _dc;
	with (_src) {
		_sc = [
			sc_gui_node_position_rotate(_sx, _sy, _sr,   1, 0.5), // _scr
			sc_gui_node_position_rotate(_sx, _sy, _sr, 0.5,   0), // _sct
			sc_gui_node_position_rotate(_sx, _sy, _sr,   0, 0.5), // _scl
			sc_gui_node_position_rotate(_sx, _sy, _sr, 0.5,   1), // _scb
		];
	}

	with (_dst) {
		_dc = [
			sc_gui_node_position_rotate(_dx, _dy, _dr,   1, 0.5), // _dcr
			sc_gui_node_position_rotate(_dx, _dy, _dr, 0.5,   0), // _dct
			sc_gui_node_position_rotate(_dx, _dy, _dr,   0, 0.5), // _dcl
			sc_gui_node_position_rotate(_dx, _dy, _dr, 0.5,   1), // _dcb
		];
	}
	
	// Get a shortest line
	var _dist = infinity;
	var _min_s = 0;
	var _min_d = 0;
	for (var s = 0; s < 4; ++s) {
		for (var d = 0; d < 4; ++d) {
			var _dist0 = abs(point_distance(_sc[s][0], _sc[s][1], _dc[d][0], _dc[d][1]));
			if (_dist > _dist0) {
				_min_s = s;
				_min_d = d;
				_dist = _dist0;
			}
		}
	}

	var _width = line_width;
	var _color = line_color;
	if (is_undefined(_color)) {
		_color = sc_gui_config_attr_theme_get(self, line_indicat);
	}
	draw_line_width_color(
		_sc[_min_s][0], _sc[_min_s][1], 
		_dc[_min_d][0], _dc[_min_d][1], 
		_width, _color, _color
	);
}
