/// @function		sc_gui_screen_construct()
/// @description	constructor gui screen config in global
function sc_gui_screen_construct()
{
	gml_pragma("global", "sc_gui_screen_construct()");
	var _classid = GUI_CLASS.SCREEN;
	sc_gui_global_set_class_construct(
		_classid, "screen",
		sc_gui_screen_config_construct,
		sc_gui_screen	
	);
}

/// @function		sc_gui_screen_config_construct()
/// @description	constructor gui screen config in global
function sc_gui_screen_config_construct() {
	var _class = {cid : GUI_CLASS.SCREEN, inherit : GUI_CLASS.DEFAULT };
	sc_gui_config_attr_alias_set(_class, "uri", "screen_uri");
	sc_gui_config_attr_value_set(_class, {
		screen_uri: "/parent",
		screen_full : false,
		screen_x: 0,
		screen_y: 0,
		screen_w: 0,
		screen_h: 0,
		w: 16, h : 16,
		func_on_release : sc_gui_screen_on_release,
		func_draw_backward : sc_gui_screen_draw_self,
	});
    
	show_debug_message("[global][sc_gui_screen_config_construct] constructor!");
}

/// @function		sc_gui_screen(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui screen node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
function sc_gui_screen(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_node(__attr, __func_attach, __func_agrs, GUI_CLASS.SCREEN);
}

function sc_gui_screen_on_release()
{
	var _node = sc_gui_node_uri_router(screen_uri);
	if (is_undefined(_node)) {
		exit;
	}
	if (!screen_full) {
		screen_x = _node.relative_pos_x;
		screen_y = _node.relative_pos_y;
		screen_w = _node.spec_width;
		screen_h = _node.spec_height;
		with (_node) {
			sc_gui_layout_relative_screen_lt();
			sc_gui_layout_relative_width();
			sc_gui_layout_relative_height();
		}
	} else {
		var _screen_x = screen_x;
		var _screen_y = screen_y;
		var _screen_w = screen_w;
		var _screen_h = screen_h;
		with (_node) {
			sc_gui_layout_relative_screen_lt(_screen_x, _screen_y);
			// 处理下strech的情况
			sc_gui_node_event_update_size(_screen_w, _screen_h, padding_left, padding_top)
		}
		screen_x = 0;
		screen_y = 0;
	}
	screen_full = !screen_full;

	//sc_gui_node_event_update_by_args({w : display_get_gui_width(), h: display_get_gui_height()}, screen_uri);
}

function sc_gui_screen_draw_self()
{
	var _block_x = block_x;
	var _block_y = block_y;
	var _view_width = view_width;
	var _view_height = view_height;
	sc_gui_node_status_combine();
	var _color = sc_gui_config_attr_theme_get_by_stat(
				self, GUI_THEME_TYPE.BORDER, status_bits);
	if (screen_full) {
		sc_gui_shape_rect_border(
			_block_x + _view_width / 4,
			_block_y + _view_height / 4, 
			_block_x + _view_width * 3 / 4,
			_block_y + _view_height * 3 / 4,
			_color);
	} else {
		sc_gui_shape_rect_border(
			_block_x + _view_width / 2,
			_block_y + _view_height / 4, 
			_block_x + _view_width * 3 / 4,
			_block_y + _view_height / 2,
			_color
		);
		sc_gui_shape_rect_border(_block_x + _view_width / 4,
			_block_y + _view_height / 2, 
			_block_x + _view_width / 2,
			_block_y + _view_height * 3 / 4,
			_color
		);
	}
}
