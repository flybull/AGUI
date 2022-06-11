/// @function		sc_gui_close_construct()
/// @description	constructor gui close config in global
function sc_gui_close_construct()
{
	gml_pragma("global", "sc_gui_close_construct()");
	var _classid = GUI_CLASS.CLOSE;
	sc_gui_global_set_class_construct(
		_classid, "close",
		sc_gui_close_config_construct,
		sc_gui_close	
	);
}

/// @function		sc_gui_close_config_construct()
/// @description	constructor gui close config in global
function sc_gui_close_config_construct() {
	var _class = {cid : GUI_CLASS.CLOSE, inherit : GUI_CLASS.DEFAULT };
	sc_gui_config_attr_alias_set(_class, "uri", "close_uri");
	sc_gui_config_attr_value_set(_class, {
		w: 16,h : 16,
		close_uri: "/parent",
		func_on_release : sc_gui_close_on_release,
		func_draw_backward : sc_gui_close_draw_self,
	});

	show_debug_message("[global][sc_gui_close_config_construct] constructor!");
}

/// @function		sc_gui_close(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui close node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
function sc_gui_close(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_node(__attr, __func_attach, __func_agrs, GUI_CLASS.CLOSE);
}

function sc_gui_close_on_release()
{
	sc_gui_node_event_delete_by_obj(
		sc_gui_node_uri_router(close_uri));
}

function sc_gui_close_draw_self()
{
	var _block_x = block_x;
	var _block_y = block_y;
	var _view_width = view_width;
	var _view_height = view_height;
	sc_gui_node_status_combine();
	var _color = sc_gui_config_attr_theme_get_by_stat(
				self, GUI_THEME_TYPE.BORDER, status_bits);
	draw_line_width_colour(
		_block_x + _view_width / 4, 
		_block_y + _view_height / 4, 
		_block_x + _view_width * 3 / 4,
		_block_y + _view_height * 3 / 4, 
		2, _color, _color);
	draw_line_width_colour(
		_block_x + _view_width  / 4, 
		_block_y + _view_height * 3 / 4, 
		_block_x + _view_width * 3 / 4,
		_block_y + _view_height / 4, 
		2, _color, _color);

}
