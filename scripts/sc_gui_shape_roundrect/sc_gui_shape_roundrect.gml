/// @function		sc_gui_shape_roundrect_construct()
/// @description	constructor gui shape roundrect config in global
function sc_gui_shape_roundrect_construct()
{
	gml_pragma("global", "sc_gui_shape_roundrect_construct()");
	var _class = { cid : GUI_CLASS.SHAPE_ROUNDRECT, inherit : GUI_CLASS.SHAPE_ROUNDRECT};
	sc_gui_global_set_class_construct(
		_class.cid, "shape_roundrect",
		sc_gui_shape_roundrect_class_construct,
		undefined
	);
	
	sc_gui_global_preload_set_factor(
		global.gui_preload.factor_attr_parse,
		_class,
		function(__class)   { return ds_map_create(); },
		function(__obj)		{ ds_map_destroy(__obj); },
		sc_gui_config_attr_parse_clone,
		sc_gui_config_attr_parse_syn_shape_roundrect,
	);
	sc_gui_global_preload_set_factor(
		global.gui_preload.factor_attr_alias,
		_class,
		function(__class)   { return ds_map_create(); },
		function(__obj)		{ ds_map_destroy(__obj); },
		sc_gui_config_attr_alias_clone,
		sc_gui_config_attr_alias_shape_roundrect,
	);
	sc_gui_global_preload_set_factor(
		global.gui_preload.factor_attr_value,
		_class,
		function(__class)   { return new sc_gui_shape_roundrect_attr_value();},
		function(__obj)		{ delete __obj; },
		function(__class)   {}
	)
}

function sc_gui_shape_roundrect_class_construct() {
	show_debug_message("[global][sc_gui_shape_roundrect_class_construct] constructor!");
}

/// @function		sc_gui_config_attr_parse_syn_shape_roundrect()
/// @description	constructor gui shape round config in global
function sc_gui_config_attr_parse_syn_shape_roundrect()
{
	var _class = { cid : GUI_CLASS.SHAPE_ROUNDRECT, inherit : GUI_CLASS.SHAPE_ROUNDRECT};
	sc_gui_config_set_attr_parse_struct(_class,
		[
			"border_visual", "backdrop_visual",
			"backdrop_col", "border_col",
			 "roundrect_xrad", "roundrect_yrad", "roundrect_rad",	
		],
	);
}

/// @function		sc_gui_config_attr_alias_shape_roundrect()
/// @description	constructor gui shape round config in global
function sc_gui_config_attr_alias_shape_roundrect()
{
	var _class = { cid : GUI_CLASS.SHAPE_ROUNDRECT, inherit : GUI_CLASS.SHAPE_ROUNDRECT};
	
	sc_gui_config_attr_alias_set(_class, "border", "border_visual");
	sc_gui_config_attr_alias_set(_class, "backdrop", "backdrop_visual");
	sc_gui_config_attr_alias_set(_class, "xrad", "roundrect_xrad");
	sc_gui_config_attr_alias_set(_class, "yrad", "roundrect_yrad");
	sc_gui_config_attr_alias_set(_class, "rad", "roundrect_rad");	
}

function sc_gui_shape_roundrect_attr_value() constructor
{
	cid = GUI_CLASS.SHAPE_ROUNDRECT;
	inherit = GUI_CLASS.SHAPE_ROUNDRECT;
	px = 1;
	border_visual = true;
	backdrop_visual = true;
	
	roundrect_xrad = 0.3;
	roundrect_yrad = 0.3;
	roundrect_rad  = 8;
}

function sc_gui_shape_roundrect(__attr = undefined) constructor 
{
	cid = GUI_CLASS.SHAPE_ROUNDRECT;
	inherit = GUI_CLASS.SHAPE_ROUNDRECT;
	sc_gui_config_syn_attr_value(self);
	sc_gui_config_syn_add_other_attr_value(self, __attr);

	static update = function(__width, __height) {
	}
	static get_borderpx = function(__width, __height) {
		roundrect_rad = min (roundrect_rad, __width * roundrect_xrad, __height * roundrect_yrad);
		return ceil(roundrect_rad / 2);
	}
	static draw_border = function(__x1, __y1, __x2, __y2, __stat) {
		if (border_visual) {
			var _color = sc_gui_config_attr_theme_get_by_stat(
				self, GUI_THEME_TYPE.BORDER, __stat);
			var _rad = roundrect_rad;
			draw_roundrect_colour_ext(__x1, __y1,
				max(__x1, __x2 - 2 * px),
				max(__y1, __y2 - 2 * px),
				_rad, _rad, 
				_color, _color, true);
		}
	}
	static draw_backdrop = function(__x1, __y1, __x2, __y2, __stat) {
		if (backdrop_visual) {
			var _color = sc_gui_config_attr_theme_get_by_stat(
				self, GUI_THEME_TYPE.BACKDROP, __stat);
			var _rad = roundrect_rad;
			draw_roundrect_colour_ext(__x1, __y1,
				max(__x1, __x2 - 2 * px),
				max(__y1, __y2 - 2 * px),
				_rad, _rad, 
				_color, _color, false);
		}
	}
}