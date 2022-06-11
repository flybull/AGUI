/// @function		sc_gui_sprite_construct()
/// @description	constructor gui sprite config in global
function sc_gui_sprite_construct()
{
	gml_pragma("global", "sc_gui_sprite_construct()");
	var _classid = GUI_CLASS.SPRITE;
	sc_gui_global_set_class_construct(
		_classid, "sprite",
		sc_gui_sprite_config_construct,
		sc_gui_sprite
	);
}

/// @function		sc_gui_sprite_config_construct()
/// @description	constructor gui sprite config in global
function sc_gui_sprite_config_construct() {
	var _class = {cid : GUI_CLASS.SPRITE, inherit : GUI_CLASS.DEFAULT};
	sc_gui_config_attr_value_set(_class, {
		// public
		sprite_id : -1,
		sprite_idx : -1,
		// private
		sprite_xscale : 1,
		sprite_yscale : 1,

		func_on_end : sc_gui_sprite_on_end,
		func_on_draw : sc_gui_sprite_on_draw,
	});

	sc_gui_config_attr_alias_set(_class, "spr", "sprite_id");
	sc_gui_config_attr_alias_set(_class, "subimg", "sprite_idx");
	sc_gui_config_attr_alias_set(_class, "xscale", "sprite_xscale");
	sc_gui_config_attr_alias_set(_class, "yscale", "sprite_yscale");
	
	sc_gui_config_set_attr_parse_struct(_class,
		["sprite_id", "sprite_idx", "sprite_xscale", "sprite_yscale"],
	);
		
	show_debug_message("[global][sc_gui_sprite_config_construct] constructor!");
}

/// @function		sc_gui_sprite(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui text node.
/// @param          __attr  {struct} init property
function sc_gui_sprite(__attr = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_node(__attr, , , GUI_CLASS.SPRITE);
}

/// @function		sc_gui_sprite_calc_scale()
/// @description	Update node xscale and yscale.
function sc_gui_sprite_calc_scale()
{
	gml_pragma("forceinline");

	// don't use sprite_width and sprite_height,
	// because sprite_width = image_width * image_xscale.
	var _sw = sprite_get_width(sprite_id);
	var _sh = sprite_get_height(sprite_id);
	var _bw = block_width;
	var _bh = block_height;
	if (_sw != _bw) {
		sprite_xscale = _bw / _sw;
	}
	if (_sh != _bh) {
		sprite_yscale = _bh / _sh;
	}
}

function sc_gui_sprite_on_end()
{
	if (sprite_id == -1) {
		exit;
	}
	content_width = sprite_get_width(sprite_id);
	content_height = sprite_get_height(sprite_id);
	sc_gui_node_update_size();
}

/// @function		sc_gui_sprite_on_draw()
/// @description	Draw Gui node sprite.
function sc_gui_sprite_on_draw()
{
	if (flag_visable == false) {
		exit;
	}
	if (sprite_id == -1) {
		exit;
	}
	sc_gui_sprite_calc_scale();
	sc_gui_node_status_combine();
	var _color = sc_gui_config_attr_theme_get_by_stat(self, GUI_THEME_TYPE.SPRITE, status_bits);
	draw_sprite_ext(sprite_id, sprite_idx, block_x, block_y,
		sprite_xscale, sprite_yscale, 0, _color, 1);
}