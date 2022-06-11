/// @function		sc_gui_bezier_construct()
/// @description	constructor gui bezier config in global
function sc_gui_bezier_construct()
{
	gml_pragma("global", "sc_gui_bezier_construct()");
	var _classid = GUI_CLASS.BEZIER;
	sc_gui_global_set_class_construct(
		_classid, "bezier",
		sc_gui_bezier_config_construct,
		sc_gui_bezier
	);
}

/// @function		sc_gui_bezier_config_construct()
/// @description	constructor gui bezier config in global
function sc_gui_bezier_config_construct()
{
	var _class = {cid : GUI_CLASS.BEZIER, inherit : GUI_CLASS.DEFAULT};

	sc_gui_config_attr_alias_set(_class, "indicat", "bezier_indicat");
	sc_gui_config_attr_alias_set(_class, "color", "bezier_color");
	sc_gui_config_attr_alias_set(_class, "width", "bezier_width");
	sc_gui_config_attr_alias_set(_class, ["src", "src_uri"], "bezier_src_uri");
	sc_gui_config_attr_alias_set(_class, ["dst", "dst_uri"], "bezier_dst_uri");
	sc_gui_config_set_attr_value(_class, {
		bezier_indicat : GUI_THEME.INDICAT_COLOR_WARN,
		bezier_color: undefined,
		bezier_width: 2,
		bezier_src_uri : undefined,
		bezier_dst_uri : undefined,
		attr_shape : undefined,
		func_check_hover : function() { return false; },
		func_on_draw : sc_gui_bezier_on_draw,
	});
	
	show_debug_message("[global][sc_gui_bezier_config_construct] constructor!");	
}

/// @function		sc_gui_bezier(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui bezier node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
function sc_gui_bezier(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_root(__attr, __func_attach, __func_agrs, GUI_CLASS.BEZIER);
}

/// @function		sc_gui_bezier_on_draw()
/// @description	Gui draw bezier
function sc_gui_bezier_on_draw()
{
	if (flag_visable == false) {
		exit;
	}
	var _dst = sc_gui_node_uri_router(bezier_dst_uri);
	var _src = sc_gui_node_uri_router(bezier_src_uri);
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
			sc_gui_node_position_rotate(_dx, _dy, _dr,   0, 0.5), // _dcl
			sc_gui_node_position_rotate(_dx, _dy, _dr, 0.5,   1), // _dcb
			sc_gui_node_position_rotate(_dx, _dy, _dr,   1, 0.5), // _dcr
			sc_gui_node_position_rotate(_dx, _dy, _dr, 0.5,   0), // _dct
		];
	}

	// Get a shortest line
	var _dist = infinity;
	var _min = 0;
	for (var i = 0; i < 4; ++i) {
		var _dist0 = abs(point_distance(_sc[i][0], _sc[i][1], _dc[i][0], _dc[i][1]));
			if (_dist > _dist0) {
			_min = i;
			_dist = _dist0;
		}
	}

	var _width = bezier_width;
	var _color = bezier_color;
	if (is_undefined(_color)) {
		_color = sc_gui_config_attr_theme_get(self, bezier_indicat);
	}
	var _diff_x = abs(_sc[_min][0] - _dc[_min][0]) / 2; //64;
	var _diff_y = abs(_sc[_min][1] - _dc[_min][1]) / 2; //64;
	switch (_min) {
	case 0:
		sc_graphs_bezier_draw([
			_sc[_min],
			[_sc[_min][0] + _diff_x, _sc[_min][1]],
			[_dc[_min][0] - _diff_x, _dc[_min][1]],
			_dc[_min]
		], _color, _width);
		break;
	case 1:
		sc_graphs_bezier_draw([
			_sc[_min],
			[_sc[_min][0], _sc[_min][1] - _diff_y],
			[_dc[_min][0], _dc[_min][1] + _diff_y],
			_dc[_min]
		], _color, _width);
		break;
	case 2:
		sc_graphs_bezier_draw([
			_sc[_min],
			[_sc[_min][0] - _diff_x, _sc[_min][1]],
			[_dc[_min][0] + _diff_x, _dc[_min][1]],
			_dc[_min]
		], _color, _width);
		break;
	case 3:
		sc_graphs_bezier_draw([
			_sc[_min],
			[_sc[_min][0], _sc[_min][1] + _diff_y],
			[_dc[_min][0], _dc[_min][1] - _diff_y],
			_dc[_min]
		], _color, _width);
		break;
	}
	

}
