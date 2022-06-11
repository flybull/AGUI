/// @function		sc_gui_selector_construct()
/// @description	constructor gui selector config in global
function sc_gui_selector_construct()
{
	gml_pragma("global", "sc_gui_selector_construct()");
	var _classid = GUI_CLASS.SELECTOR;
	sc_gui_global_set_class_construct(
		_classid, "selector",
		sc_gui_selector_config_construct,
		sc_gui_selector
	);
	_classid = GUI_CLASS.SELECTOR_LIST;
	sc_gui_global_set_class_construct(
		_classid, "selector_list",
		sc_gui_selector_list_config_construct,
		sc_gui_selector_list
	);
	_classid = GUI_CLASS.SELECTOR_ELEM;
	sc_gui_global_set_class_construct(
		_classid, "selector_elem",
		sc_gui_selector_elem_config_construct,
		sc_gui_selector_elem
	);
}

/// @function		sc_gui_selector_config_construct()
/// @description	constructor gui selector config in global
function sc_gui_selector_config_construct() {
	var _class = {cid : GUI_CLASS.SELECTOR, inherit : GUI_CLASS.DEFAULT };
	sc_gui_config_set_attr_value(_class, {
		fid: "0",
		flag_stretch : true,
		func_on_ready : sc_gui_selector_on_ready,
		func_on_press : sc_gui_selector_on_press,
		func_on_blur : sc_gui_selector_on_blur,
	});

	show_debug_message("[global][sc_gui_selector_config] constructor!");	
}
/// @function		sc_gui_selector_list_config_construct()
/// @description	constructor gui selector_list config in global
function sc_gui_selector_list_config_construct() {
	var _class0 = {cid : GUI_CLASS.SELECTOR_LIST, inherit : GUI_CLASS.DEFAULT };
	sc_gui_config_set_attr_value(_class0, {
		fid: "1",
		max_height : 64,
		flag_visable: false,
		func_on_focus : sc_gui_selector_list_on_focus,
		func_on_blur : sc_gui_selector_list_on_blur,
		func_on_draw : sc_gui_selector_list_on_draw,
	});

	show_debug_message("[global][sc_gui_selector_list_config] constructor!");	
}

/// @function		sc_gui_selector_elem_config_construct()
/// @description	constructor gui selector config in global
function sc_gui_selector_elem_config_construct() {
	var _class1 = {cid : GUI_CLASS.SELECTOR_ELEM, inherit : GUI_CLASS.DEFAULT };
	sc_gui_config_set_attr_value(_class1, {
		flag_stretch : true,
		func_on_release : sc_gui_selector_elem_on_press,
	});
	show_debug_message("[global][sc_gui_selector_elem_config] constructor!");	
}

/// @function		sc_gui_selector(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui selector node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
function sc_gui_selector(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	var _icon = { triangle : { 
		w : 13, h : 13, tri_color: c_orange,
		orient: GUI_TRIANLE_ORIENT.RIGHT, 
		direct: GUI_FLEX_DIRECT.NONE,
		margin_type: GUI_VALUE_TYPE.PERCENT,
		margin_left: 1,
		margin_top: 0.5,
		anchor_width : 0.5,
		anchor_height : 0.5}
	};
	if (variable_struct_exists(__attr, "text")) {
		return sc_gui_node([_icon, __attr], function(__args) {
			sc_gui_selector_list(, __args[0], __args[1]);
		}, [__func_attach, __func_agrs], GUI_CLASS.SELECTOR);
	} else {
		return sc_gui_node([{text : {str: "Select!"}}, _icon, __attr], function(__args) {
			sc_gui_selector_list(, __args[0], __args[1]);
		}, [__func_attach, __func_agrs], GUI_CLASS.SELECTOR);
		

	}
}

/// @function		sc_gui_selector_list(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui selector_list node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
function sc_gui_selector_list(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_friend(__attr, __func_attach, __func_agrs, GUI_CLASS.SELECTOR_LIST);
}

/// @function		sc_gui_selector_elem(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui selector node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
function sc_gui_selector_elem(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_node(__attr, __func_attach, __func_agrs, GUI_CLASS.SELECTOR_ELEM);
}

function sc_gui_selector_on_ready()
{
	var _dst = self;
	with (friends[? "1"]) {
		sc_gui_layout_relative_width(_dst);
		//sc_gui_layout_relative_height(_dst);
	}
}

function sc_gui_selector_on_press()
{
	sc_gui_node_insert_focus();
	with (friends[? "1"]) {
		sc_gui_node_insert_focus();
	}
	sc_gui_node_event_update_by_args({orient: GUI_TRIANLE_ORIENT.DOWN, color : c_green},
		"/decorate/cid/" + string(GUI_CLASS.TRIANGLE));
}

function sc_gui_selector_on_blur()
{
	sc_gui_node_event_update_by_args({orient: GUI_TRIANLE_ORIENT.RIGHT, color : c_orange},
		"/decorate/cid/" + string(GUI_CLASS.TRIANGLE));
}

function sc_gui_selector_list_on_focus()
{
	flag_visable = true;
}

function sc_gui_selector_list_on_blur()
{
	flag_visable = false;
}

function sc_gui_selector_list_on_draw()
{
	if (flag_visable) {
		//sc_gui_layout_relative_loto(friends[? "0"]);
		//sc_gui_layout_relative_lito(friends[? "0"]);
		//sc_gui_layout_relative_loti(friends[? "0"]);
		//sc_gui_layout_relative_liti(friends[? "0"]);
		//sc_gui_layout_relative_lobo(friends[? "0"]);
		sc_gui_layout_relative_libo(friends[? "0"]);
		//sc_gui_layout_relative_lobi(friends[? "0"]);
		//sc_gui_layout_relative_libi(friends[? "0"]);
	
		//sc_gui_layout_relative_roto(friends[? "0"]);
		//sc_gui_layout_relative_rito(friends[? "0"]);
		//sc_gui_layout_relative_roti(friends[? "0"]);
		//sc_gui_layout_relative_riti(friends[? "0"]);
		//sc_gui_layout_relative_robo(friends[? "0"]);
		//sc_gui_layout_relative_ribo(friends[? "0"]);
		//sc_gui_layout_relative_robi(friends[? "0"]);
		//sc_gui_layout_relative_ribi(friends[? "0"]);
		sc_gui_node_draw();
	}
}

function sc_gui_selector_elem_on_press()
{
	sc_gui_node_event_update_by_uri(
		"/decorate/cid/" + string(GUI_CLASS.TEXT), "text_str", 
		"/parent/friends/0/decorate/cid/" + string(GUI_CLASS.TEXT), "str");
	sc_gui_node_remove_focus();
}