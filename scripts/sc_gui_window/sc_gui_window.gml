// HAVE BUG

/// @function		sc_gui_window_construct()
/// @description	constructor gui window config in global
function sc_gui_window_construct()
{
	gml_pragma("global", "sc_gui_window_construct()");
	var _classid = GUI_CLASS.WINDOW;
	sc_gui_global_set_class_construct(
		_classid, "window",
		sc_gui_window_config_construct,
		sc_gui_window
	);
}

/// @function		sc_gui_window_config_construct()
/// @description	constructor gui window config in global
function sc_gui_window_config_construct() {
	var _class = {cid : GUI_CLASS.WINDOW, inherit : GUI_CLASS.DEFAULT};
	sc_gui_config_set_attr_value(_class, {
		flag_hover_hole : true,
		flag_scale : GUI_AXIS_TYPE.BOTH,
		flex_algin : GUI_FLEX_ALIGN.STRETCH,
		flex_justify : GUI_FLEX_JUSTIFY.STRETCH,
	});
	show_debug_message("[global][sc_gui_window_config] constructor!");	
}

/// @function		sc_gui_window(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui window node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
function sc_gui_window(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	var _func = function(_agrs) {
		sc_gui_container({block_direct: GUI_FLEX_DIRECT.RROW, /*flex_algin : GUI_FLEX_ALIGN.STRETCH*/}, function() {
			sc_gui_close({w:24, h: 24, close_uri: "/origin"});
			sc_gui_screen({w:24, h: 24, screen_uri: "/origin"});
			sc_gui_hide({w:24, h: 24, hide_uri: "/origin/childs/idx/1"});
			sc_gui_drag({w:24, h: 24, drag_uri: "/origin", text: {str : "title"}});
		});
		sc_gui_container([{w: 128, h: 128, 
			flag_hover_hole: false, padding:16,
			flag_scroll : GUI_AXIS_TYPE.BOTH},
			_agrs[0]], _agrs[1]);
	}
	
	if (variable_struct_exists(__attr, "fid")) {
		return sc_gui_friend(__attr, _func, [__func_agrs, __func_attach], GUI_CLASS.WINDOW);
	} else {
		return sc_gui_root(__attr, _func, [__func_agrs, __func_attach], GUI_CLASS.WINDOW);
	}
}
