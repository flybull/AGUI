/// @function		sc_gui_container_construct()
/// @description	constructor gui container config in global
function sc_gui_container_construct()
{
	gml_pragma("global", "sc_gui_container_construct()");
	var _classid = GUI_CLASS.CONTAINER;
	sc_gui_global_set_class_construct(
		_classid, "container",
		sc_gui_container_config_construct,
		sc_gui_container
	);
}

/// @function		sc_gui_container_config_construct()
/// @description	constructor gui container config in global
function sc_gui_container_config_construct() {
	var _class = {cid : GUI_CLASS.CONTAINER, inherit : GUI_CLASS.DEFAULT};
	sc_gui_config_set_attr_value(_class, {
		flag_hover_hole : true,
		flag_stretch : true,
	});
	show_debug_message("[global][sc_gui_container_config] constructor!");	
}

/// @function		sc_gui_container(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui container node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
function sc_gui_container(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_node(__attr, __func_attach, __func_agrs, GUI_CLASS.CONTAINER);
}
