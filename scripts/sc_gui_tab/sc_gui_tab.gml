/// @function		sc_gui_tab_construct()
/// @description	constructor gui tab config in global
function sc_gui_tab_construct()
{
	gml_pragma("global", "sc_gui_tab_construct()");
	var _classid = GUI_CLASS.TAB_MENU;
	sc_gui_global_set_class_construct(
		_classid, "tab_menu",
		sc_gui_tab_config_construct,
		sc_gui_tab_menu,
	);
	 _classid = GUI_CLASS.TAB_ELEM;
	sc_gui_global_set_class_construct(
		_classid, "tab_elem",
		sc_gui_tab_elem_config_construct,
		sc_gui_tab_elem,
	);
}

/// @function		sc_gui_tab_config_construct()
/// @description	constructor gui tab config in global
function sc_gui_tab_config_construct() {
	var _class = {cid : GUI_CLASS.TAB_MENU, inherit : GUI_CLASS.DEFAULT};
	sc_gui_config_set_attr_value(_class, {
		flex_algin: GUI_FLEX_ALIGN.STRETCH, 
		flex_justify: GUI_FLEX_JUSTIFY.STRETCH,
		flag_stretch : true,
		flag_hover_hole : true,
		form: undefined,
	});

	show_debug_message("[global][sc_gui_tab_config] constructor!");	
}

/// @function		sc_gui_tab_elem_config_construct()
/// @description	constructor gui tab_elem config in global
function sc_gui_tab_elem_config_construct() {
	var _class_elem = {cid : GUI_CLASS.TAB_ELEM, inherit : GUI_CLASS.DEFAULT};
	sc_gui_config_set_attr_parse(_class_elem, ["str", "text_str", "txt"], function(__attr, __name, __realname, __self) {
		var _str = variable_struct_get(__attr, __name);
		sc_gui_config_syn_add_other_attr_value(__self, { text: {	
			str: _str, 
			flex_algin: GUI_FLEX_ALIGN.CENTER, 
			flex_justify: GUI_FLEX_JUSTIFY.START,
			flag_hover_hole : true,
		}});
	});
	sc_gui_config_set_attr_value(_class_elem, {
		tab_node_sid : undefined,
		func_on_press : sc_gui_tab_elem_on_press,
	});

	show_debug_message("[global][sc_gui_tab_elem_config] constructor!");	
}

/// @function		sc_gui_tab_menu(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui tab-menu node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
function sc_gui_tab_menu(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_node(__attr, function(__args) {
		var _scroll = GUI_AXIS_TYPE.NONE;
		switch (block_direct) {
		case GUI_FLEX_DIRECT.ROW: _scroll = GUI_AXIS_TYPE.HORIZONTAL; break;
		case GUI_FLEX_DIRECT.RROW: _scroll = GUI_AXIS_TYPE.HORIZONTAL; break;
		case GUI_FLEX_DIRECT.COL: _scroll = GUI_AXIS_TYPE.VERTICAL; break;
		case GUI_FLEX_DIRECT.RCOL: _scroll = GUI_AXIS_TYPE.VERTICAL; break;
		}
		sc_gui_node({attr_scroll : {func_on_draw : sc_base_empty_call},
			flag_stretch : true, flag_scroll : _scroll }, __args[1], __args[2]);
		sc_gui_node([{flag_scroll : GUI_AXIS_TYPE.BOTH}, __args[0]]);
	}, [__attr, __func_attach, __func_agrs], GUI_CLASS.TAB_MENU);
}

/// @function		sc_gui_tab_elem(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui tab-elem node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
function sc_gui_tab_elem(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_node(__attr, function(__args) {
		if (!is_undefined(__args[0])) {
			sc_base_safe_call(__args[0], __args[1]);
			var _node =  childs[| 0];
			tab_node_sid = _node.sid;
			with (_node) {
				sc_gui_affiliation_to_none();
			}
			sc_gui_list_ref(reserver, _node);
		}
	}, [__func_attach, __func_agrs], GUI_CLASS.TAB_ELEM);
}

function sc_gui_tab_elem_on_press()
{
	var _tab_node = sc_gui_global_node_find(tab_node_sid);
	if (!is_undefined(_tab_node)) {
		var _container = parent.parent.childs[| 1];
		with(_container) {
			sc_ds_list_foreach(childs, sc_gui_affiliation_to_none);
			sc_gui_node_event_insert_by_obj(self, _tab_node);
		}
	}
}
