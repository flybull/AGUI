/// @function		sc_gui_tree_construct()
/// @description	constructor gui tree config in global
function sc_gui_tree_construct()
{
	gml_pragma("global", "sc_gui_tree_construct()");
	var _classid = GUI_CLASS.TREE;
	sc_gui_global_set_class_construct(
		_classid, "tree",
		sc_gui_tree_config_construct,
		sc_gui_tree
	);
	
	_classid = GUI_CLASS.TREE_ELEM;
	sc_gui_global_set_class_construct(
		_classid, "tree_elem",
		sc_gui_tree_elem_config_construct,
		sc_gui_tree_elem
	);
}

/// @function		sc_gui_tree_config_construct()
/// @description	constructor gui tree config in global
function sc_gui_tree_config_construct() {
	var _class = {cid : GUI_CLASS.TREE, inherit : GUI_CLASS.DEFAULT};
	sc_gui_config_attr_value_set(_class, {
		tree_exhibits : false,
		flag_stretch : true,
		flag_hover_hole : true,
		attr_shape: undefined,
	});

	show_debug_message("[global][sc_gui_tree_config] constructor!");	
}

/// @function		sc_gui_tree_elem_config_construct()
/// @description	constructor gui tree_elem config in global
function sc_gui_tree_elem_config_construct()
{
	var _class_elem = {cid : GUI_CLASS.TREE_ELEM, inherit : GUI_CLASS.DEFAULT};
	sc_gui_config_attr_parse_set(_class_elem, ["str", "text_str", "txt"], function(__attr, __name, __realname, __self) {
		var _str = variable_struct_get(__attr, __name);
		sc_gui_text({str : _str, flex_algin: GUI_FLEX_ALIGN.CENTER, 
			flex_justify: GUI_FLEX_ALIGN.START, flag_hover_hole : true});
	});
	sc_gui_config_attr_value_set(_class_elem, {
		flag_stretch : true,
		func_on_begin : sc_gui_tree_elem_on_init,
	});
	show_debug_message("[global][sc_gui_tree_elem_config] constructor!");	
}

/// @function		sc_gui_tree(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui tree node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
function sc_gui_tree(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_node(, function(__args) {
		sc_gui_node([{attr_shape: { border: false }, func_on_press : sc_gui_tree_on_press}, __args[0]], , , GUI_CLASS.TREE_ELEM);
		sc_gui_container({form: undefined, flag_hover_hole : true, flag_visable : false}, __args[1], __args[2]);
	}, [__attr, __func_attach, __func_agrs], GUI_CLASS.TREE);
}

/// @function		sc_gui_tree_elem(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui tree-elem node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
function sc_gui_tree_elem(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_node([{attr_shape: { border: false }}, __attr], , , GUI_CLASS.TREE_ELEM);
}

function sc_gui_tree_on_press()
{
	with(parent) {
		var _list = childs[| 1];
		if (!ds_list_size(_list.childs) && tree_exhibits == false) {
			exit;
		}
		tree_exhibits = !tree_exhibits;
		var _tree_exhibits = tree_exhibits;
		with (childs[| 1]) {
			sc_gui_node_event_update_by_args({flag_visable : _tree_exhibits});
		}
	}
}

function sc_gui_tree_elem_on_init(__attr)
{
	var _layer = 0;
	if (parent.cid == GUI_CLASS.TREE) {
		_layer -= 1;
	}
	for (var _parent = parent; 
		!is_undefined(_parent);
		_parent = _parent.parent) {
		if (_parent.cid == GUI_CLASS.TREE) {
			_layer += 1;
		}
	}
	if (_layer != -1) {
		padding_left = _layer * 16;
	}
	sc_gui_node_begin(__attr);
}
