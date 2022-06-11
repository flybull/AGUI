/// @function		sc_gui_shape_circle_construct()
/// @description	constructor gui shape circle config in global
function sc_gui_shape_circle_construct()
{
	gml_pragma("global", "sc_gui_shape_circle_construct()");
	var _class = { cid : GUI_CLASS.SHAPE_CIRCLE, inherit : GUI_CLASS.SHAPE_CIRCLE};

	sc_gui_global_set_class_construct(
		_class.cid, "shape_circle",
		sc_gui_shape_circle_class_construct,
		undefined
	);
	
	sc_gui_global_preload_set_factor(
		global.gui_preload.factor_attr_parse,
		_class,
		function(__class)   { return ds_map_create(); },
		function(__obj)		{ ds_map_destroy(__obj); },
		sc_gui_config_attr_parse_clone,
		sc_gui_config_attr_parse_syn_shape_circle,
	);
	sc_gui_global_preload_set_factor(
		global.gui_preload.factor_attr_alias,
		_class,
		function(__class)   { return ds_map_create(); },
		function(__obj)		{ ds_map_destroy(__obj); },
		sc_gui_config_attr_alias_clone,
		sc_gui_config_attr_alias_shape_circle,
	);
	sc_gui_global_preload_set_factor(
		global.gui_preload.factor_attr_value,
		_class,
		function(__class)   { return new sc_gui_shape_circle_attr_value();},
		function(__obj)		{ delete __obj; },
		function(__class)   {}
	);
}

function sc_gui_shape_circle_class_construct() {
	show_debug_message("[global][sc_gui_shape_circle_class_construct] constructor!");
}

/// @function		sc_gui_config_attr_parse_syn_shape_circle()
/// @description	constructor gui shape circle config in global
function sc_gui_config_attr_parse_syn_shape_circle()
{
	var _class = {cid : GUI_CLASS.SHAPE_CIRCLE, inherit : GUI_CLASS.SHAPE_CIRCLE};
	sc_gui_config_set_attr_parse_struct(_class,
		[
			"border_visual", "backdrop_visual",
			"backdrop_col", "border_col",
		],
	);
}

/// @function		sc_gui_config_attr_alias_shape_circle()
/// @description	constructor gui shape circle config in global
function sc_gui_config_attr_alias_shape_circle()
{
	var _class = {cid : GUI_CLASS.SHAPE_CIRCLE, inherit : GUI_CLASS.SHAPE_CIRCLE};
	sc_gui_config_attr_alias_set(_class, "border", "border_visual");
	sc_gui_config_attr_alias_set(_class, "backdrop", "backdrop_visual");
	sc_gui_config_attr_alias_set(_class, "br_col", "border_color");	
	sc_gui_config_attr_alias_set(_class, "bd_col", "backdrop_color");	
}

function sc_gui_shape_circle_attr_value() constructor
{
	cid = GUI_CLASS.SHAPE_CIRCLE;
	inherit = GUI_CLASS.SHAPE_CIRCLE;
	px = 0;
	border_visual = true;
	backdrop_visual = true;
	border_color = undefined;
	backdrop_color = undefined;
	
	radius = 0;
}

function sc_gui_shape_circle(__attr = undefined) constructor 
{
	cid = GUI_CLASS.SHAPE_CIRCLE;
	inherit = GUI_CLASS.SHAPE_CIRCLE;
	sc_gui_config_syn_attr_value(self);
	sc_gui_config_syn_add_other_attr_value(self, __attr);

	static update = function(__width, __height) {
		radius = ceil(max(__width, __height) / 2);
	}
	static get_borderpx = function(__width, __height) {
		var _radius = max(__width, __height) / 2;
		px = ceil(_radius - dsin(45) * _radius) + 1;
		return px;
	}
	static draw_border = function(__x1, __y1, __x2, __y2, __stat) {
		if (border_visual) {
			var _color = is_undefined(border_color) ? sc_gui_config_attr_theme_get_by_stat(
				self, GUI_THEME_TYPE.BORDER, __stat) : border_color;
			var _radius = radius;
			draw_circle_colour(__x1 + _radius - 1, __y1 + _radius - 1,
				_radius,
				_color, _color, true);
		}
	}
	static draw_backdrop = function(__x1, __y1, __x2, __y2, __stat) {
		if (backdrop_visual) {
			var _color = is_undefined(backdrop_color) ? sc_gui_config_attr_theme_get_by_stat(
				self, GUI_THEME_TYPE.BACKDROP, __stat) :backdrop_color;
			var _radius = radius;
			draw_circle_colour(__x1 + _radius - 1, __y1 + _radius - 1,
				_radius,
				_color, _color, false);
		}
	}
}