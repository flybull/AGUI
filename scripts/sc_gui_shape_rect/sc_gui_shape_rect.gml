/// @function		sc_gui_shape_rect_construct()
/// @description	constructor gui shape rect config in global
function sc_gui_shape_rect_construct()
{
	gml_pragma("global", "sc_gui_shape_rect_construct()");
	var _class = { cid : GUI_CLASS.SHAPE_RECT, inherit : GUI_CLASS.SHAPE_RECT};
	sc_gui_global_set_class_construct(
		_class.cid, "shape_rect",
		sc_gui_shape_rect_class_construct,
		undefined,
	);
	
	sc_gui_global_preload_set_factor(
		global.gui_preload.factor_attr_parse,
		_class,
		function(__class)   { return ds_map_create(); },
		function(__obj)		{ ds_map_destroy(__obj); },
		sc_gui_config_attr_parse_clone,
		sc_gui_config_attr_parse_syn_shape_rect,
	);
	sc_gui_global_preload_set_factor(
		global.gui_preload.factor_attr_alias,
		_class,
		function(__class)   { return ds_map_create(); },
		function(__obj)		{ ds_map_destroy(__obj); },
		sc_gui_config_attr_alias_clone,
		sc_gui_config_attr_alias_shape_rect,
	);
	sc_gui_global_preload_set_factor(
		global.gui_preload.factor_attr_value,
		_class,
		function(__class)   { return new sc_gui_shape_rect_attr_value();},
		function(__obj)		{ delete __obj; },
		function(__class)   {}
	)
}

function sc_gui_shape_rect_class_construct() {
	show_debug_message("[global][sc_gui_shape_rect_class_construct] constructor!");
}

/// @function		sc_gui_config_attr_parse_syn_shape_rect()
/// @description	constructor gui shape rect config in global
function sc_gui_config_attr_parse_syn_shape_rect()
{
	var _class = { cid : GUI_CLASS.SHAPE_RECT, inherit : GUI_CLASS.SHAPE_RECT};
	sc_gui_config_set_attr_parse_struct(_class,
		[
			"border_visual", "backdrop_visual",
		],
	);
}

/// @function		sc_gui_config_attr_alias_shape_rect()
/// @description	constructor gui shape rect config in global
function sc_gui_config_attr_alias_shape_rect()
{
	var _class = { cid : GUI_CLASS.SHAPE_RECT, inherit : GUI_CLASS.SHAPE_RECT};
	
	sc_gui_config_attr_alias_set(_class, "border", "border_visual");
	sc_gui_config_attr_alias_set(_class, "backdrop", "backdrop_visual");
}

function sc_gui_shape_rect_attr_value() constructor
{
	cid = GUI_CLASS.SHAPE_RECT;
	inherit = GUI_CLASS.SHAPE_RECT;
	px = 1;
	border_visual = true;
	backdrop_visual = true;
}

function sc_gui_shape_rect(__attr = undefined) constructor 
{
	cid = GUI_CLASS.SHAPE_RECT;
	inherit = GUI_CLASS.SHAPE_RECT;
	sc_gui_config_syn_attr_value(self);
	sc_gui_config_syn_add_other_attr_value(self, __attr);

	static update = function(__width, __height) {
	}
	static get_borderpx = function(__width, __height) {
		return px;
	}
	static draw_border = function(__x1, __y1, __x2, __y2, __stat) {
		if (border_visual) {
			var _px = px;
			var _color = sc_gui_config_attr_theme_get_by_stat(
				self, GUI_THEME_TYPE.BORDER, __stat);
			sc_gui_shape_rect_border(__x1 + _px, __y1 + _px, __x2 - 2 * _px, __y2 - 2 * _px, _color);
		}
	}
	static draw_backdrop = function(__x1, __y1, __x2, __y2, __stat) {
		if (backdrop_visual) {
			var _px = px;
			var _color = sc_gui_config_attr_theme_get_by_stat(
				self, GUI_THEME_TYPE.BACKDROP, __stat);
			sc_gui_shape_rect_backdrop(__x1 + _px, __y1 + _px, __x2 - 2 * _px, __y2 - 2 * _px, _color)
		}
	}
}

function sc_gui_shape_rect_border(__x1, __y1, __x2, __y2, __color)
{
	gml_pragma("forceinline");
	// 方形边框绘制内侧算起, 比如(0,0),(0,0), 绘制得到(-1,-1), (2, 2) content默认为1。
	// Draw rectangle (0,0) (0,0) => (-1,-1), (2, 2), content equal 1, 
	draw_rectangle_colour(__x1, __y1,
		max(__x1, __x2), max(__y1, __y2),
		__color, __color, __color, __color, true);			
}

function sc_gui_shape_rect_backdrop(__x1, __y1, __x2, __y2, __color)
{
	gml_pragma("forceinline");
	draw_rectangle_colour(__x1, __y1,
		max(__x1, __x2), max(__y1, __y2),
		__color, __color, __color, __color, false);
}
