/// @function		sc_gui_drag_construct()
/// @description	constructor gui drag config in global
function sc_gui_drag_construct()
{
	gml_pragma("global", "sc_gui_drag_construct()");
	var _classid = GUI_CLASS.DRAG;
	sc_gui_global_set_class_construct(
		_classid, "drag",
		sc_gui_drag_config_construct,
		sc_gui_drag	
	);
}

/// @function		sc_gui_drag_config_construct()
/// @description	constructor gui drag config in global
function sc_gui_drag_config_construct() {
	var _class = {cid : GUI_CLASS.DRAG, inherit : GUI_CLASS.DEFAULT };
	sc_gui_config_attr_alias_set(_class, "uri", "drag_uri");
	sc_gui_config_set_attr_value(_class, {
		h : 32,
		flag_stretch : true,
		drag_uri: "/self",
		drag_hold_x : 0,
		drag_hold_y : 0,
		func_on_press : sc_gui_drag_on_press,
		func_on_hold : sc_gui_drag_on_hold,
		func_on_release : sc_gui_drag_on_release,
	});

	show_debug_message("[global][sc_gui_drag_config_construct] constructor!");
}

/// @function		sc_gui_drag(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui drag node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
function sc_gui_drag(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_node(__attr, __func_attach, __func_agrs, GUI_CLASS.DRAG);
}

function sc_gui_drag_on_press()
{
	if (is_undefined(drag_uri)) {
		exit;
	}
	var _node = sc_gui_node_uri_router(drag_uri);
	if (is_undefined(_node)) {
		exit;
	}
	var _hold = [0, 0];
	with (_node) {
		_hold[@ 0] = hover_x - view_x;
		_hold[@ 1] = hover_y - view_y;
		sc_gui_rotate_to_origin(_hold, rotate);
	}
	drag_hold_x = _hold[0];
	drag_hold_y = _hold[1];
}

function sc_gui_drag_on_hold()
{
	if (is_undefined(drag_uri)) {
		exit;
	}
	var _node = sc_gui_node_uri_router(drag_uri);
	if (is_undefined(_node)) {
		exit;
	}

	var _hold_x = drag_hold_x;
	var _hold_y = drag_hold_y;
	with (_node) {
		sc_gui_move(_hold_x, _hold_y);
	}
}

function sc_gui_drag_on_release()
{
	drag_hold_x = 0;
	drag_hold_y = 0;
}

