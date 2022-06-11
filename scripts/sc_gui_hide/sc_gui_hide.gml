/// @function		sc_gui_hide_construct()
/// @description	constructor gui hide config in global
function sc_gui_hide_construct()
{
	gml_pragma("global", "sc_gui_hide_construct()");
	var _classid = GUI_CLASS.HIDE;
	sc_gui_global_set_class_construct(
		_classid, "hide",
		sc_gui_hide_config_construct,
		sc_gui_hide	
	);
}

/// @function		sc_gui_hide_config_construct()
/// @description	constructor gui hide config in global
function sc_gui_hide_config_construct() {
	var _class = {cid : GUI_CLASS.HIDE, inherit : GUI_CLASS.DEFAULT };
	sc_gui_config_attr_alias_set(_class, "uri", "hide_uri");
	sc_gui_config_attr_value_set(_class, {
		w: 16, h : 16,
		hide_uri: "/parent",
		hide_status : false,
		func_on_release : sc_gui_hide_on_release,
		func_draw_backward : sc_gui_hide_draw_self,
	});
    
	show_debug_message("[global][sc_gui_hide_config_construct] constructor!");
}

/// @function		sc_gui_hide(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui hide node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
function sc_gui_hide(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_node(__attr, __func_attach, __func_agrs, GUI_CLASS.HIDE);
}

function sc_gui_hide_on_release()
{
	sc_gui_node_event_update_by_args({flag_visable : hide_status}, hide_uri);
	hide_status = !hide_status;
}

function sc_gui_hide_draw_self()
{
	var _block_x = block_x;
	var _block_y = block_y;
	var _view_width = view_width;
	var _view_height = view_height;
	sc_gui_node_status_combine();
	var _color = sc_gui_config_attr_theme_get_by_stat(
				self, GUI_THEME_TYPE.BORDER, status_bits);

	sc_gui_shape_rect_backdrop(
		_block_x + _view_width / 4,
		_block_y + _view_height * 7 / 16, 
		_block_x + _view_width * 3 / 4,
		_block_y + _view_height * 9 / 16,
		_color);
}
