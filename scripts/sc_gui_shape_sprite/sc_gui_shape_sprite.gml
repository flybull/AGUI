/// @function		sc_gui_shape_sprite_construct()
/// @description	constructor gui shape sprite config in global
function sc_gui_shape_sprite_construct()
{
	gml_pragma("global", "sc_gui_shape_sprite_construct()");
	var _class = { cid : GUI_CLASS.SHAPE_SPRITE, inherit : GUI_CLASS.SHAPE_SPRITE};
	sc_gui_global_set_class_construct(
		_class.cid, "shape_sprite",
		sc_gui_spriteid_class_construct,
		undefined
	);
	
	sc_gui_global_preload_set_factor(
		global.gui_preload.factor_attr_parse,
		_class,
		function(__class)   { return ds_map_create(); },
		function(__obj)		{ ds_map_destroy(__obj); },
		sc_gui_config_attr_parse_clone,
		sc_gui_config_attr_parse_syn_sprite,
	);
	sc_gui_global_preload_set_factor(
		global.gui_preload.factor_attr_alias,
		_class,
		function(__class)   { return ds_map_create(); },
		function(__obj)		{ ds_map_destroy(__obj); },
		sc_gui_config_attr_alias_clone,
		sc_gui_config_attr_alias_sprite,
	);
	sc_gui_global_preload_set_factor(
		global.gui_preload.factor_attr_value,
		_class,
		function(__class)   { return new sc_gui_sprite_attr_value();},
		function(__obj)		{ delete __obj; },
		function(__class)   {}
	)
}

function sc_gui_spriteid_class_construct() {
	show_debug_message("[global][sc_gui_spriteid_class_construct] constructor!");
}

/// @function		sc_gui_config_attr_parse_syn_sprite()
/// @description	constructor gui shape sprite config in global
function sc_gui_config_attr_parse_syn_sprite()
{
	var _class = {cid : GUI_CLASS.SHAPE_SPRITE, inherit : GUI_CLASS.SHAPE_SPRITE};
	sc_gui_config_set_attr_parse_struct(_class,
		[
			"visual",
			"spriteid", "subimg", "xscale", "yscale",
			"rot", "alpha",
		],
	);
}

/// @function		sc_gui_config_attr_alias_sprite()
/// @description	constructor gui shape sprite config in global
function sc_gui_config_attr_alias_sprite()
{
	var _class = {cid : GUI_CLASS.SHAPE_SPRITE, inherit : GUI_CLASS.SHAPE_SPRITE};
	sc_gui_config_attr_alias_set(_class, ["spr", "sprite"], "spriteid");
	sc_gui_config_attr_alias_set(_class, ["sub"], "subimg");
	sc_gui_config_attr_alias_set(_class, ["border, backdrop"], "visual");
}

function sc_gui_sprite_attr_value() constructor
{
	cid = GUI_CLASS.SHAPE_SPRITE;
	inherit = GUI_CLASS.SHAPE_SPRITE;
	px = 0;
	visual = true;
	
	spriteid = Sprite5;
	subimg = -1;
	xscale = 1;
	yscale = 1;
	rot = 0;
	alpha = 1;
}

function sc_gui_shape_sprite(__attr = undefined) constructor 
{
	cid = GUI_CLASS.SHAPE_SPRITE;
	inherit = GUI_CLASS.SHAPE_SPRITE;
	sc_gui_config_syn_attr_value(self);
	sc_gui_config_syn_add_other_attr_value(self, __attr);

	static update = function(__width, __height) {
		// don't use sprite_width and sprite_height,
		// because sprite_width = image_width * image_xscale.
		var _spriteid = spriteid;
		if (_spriteid != -1) {
			var _sw = sprite_get_width(_spriteid);
			var _sh = sprite_get_height(_spriteid);
			if (_sw != __width) {
				xscale = __width / _sw;
			}
			if (_sh != __height) {
				yscale = __height / _sh;
			}
		}
	}
	static get_borderpx = function(__width, __height) {
		var _spriteid = spriteid;
		if (_spriteid != -1) {
			var _box_nineslice = sprite_get_nineslice(_spriteid);
			if (_box_nineslice.enabled) {
				px = max(
				_box_nineslice[$ "left"],
				_box_nineslice[$ "right"],
				_box_nineslice[$ "top"],
				_box_nineslice[$ "bottom"]);
			}
		}
		return px;
	}
	static draw_border = function(__x1, __y1, __x2, __y2, __stat) {

	}
	static draw_backdrop = function(__x1, __y1, __x2, __y2, __stat) {
		if (!visual) {
			exit;
		}
		var _spriteid = spriteid;
		if (_spriteid == -1) {
			exit;
		}
		var _color = sc_gui_config_attr_theme_get_by_stat(
				self, GUI_THEME_TYPE.SPRITE, __stat);
		draw_sprite_ext(_spriteid, subimg, __x1, __y1,
			xscale, yscale, rot, _color, alpha);
	}
}
