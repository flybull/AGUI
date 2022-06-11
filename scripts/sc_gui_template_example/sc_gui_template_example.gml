function sc_gui_example_construct()
{
	gml_pragma("global", "sc_gui_example_construct()");
	var _classid = GUI_CLASS.EXAMPLE;
	sc_gui_global_set_class_construct(
		_classid, "example",
		sc_gui_example_config_construct,
		sc_gui_example
	);
}
function sc_gui_example_config_construct()
{
    var _class = {cid : GUI_CLASS.EXAMPLE, inherit : GUI_CLASS.DEFAULT };
    // For parse
    sc_gui_config_attr_alias_set(_class, ["debug_one", "debug_aa"], "debug");
    // For default value
    sc_gui_config_attr_value_set(_class, {
        debug : "",
        func_on_press : function() { show_debug_message("[press]" + debug); },
		func_on_release : sc_gui_example_on_release,
    });
    // For parse function
    sc_gui_config_attr_parse_set(_class, "debug", function(__attr, __name, __realname, __self) {
		var _val = variable_struct_get(__attr, __name);
        debug = string(_val);
    });
}

function sc_gui_example(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_node(__attr, __func_attach, __func_agrs, GUI_CLASS.EXAMPLE);
}

function sc_gui_example_on_release()
{
	show_debug_message("[release]" + debug);
}