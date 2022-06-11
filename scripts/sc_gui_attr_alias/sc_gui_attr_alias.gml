/// @function:		sc_gui_config_attr_alias_construct() 
/// @description:	Gui config_func attribute alias construct.
function sc_gui_config_attr_alias_construct()
{
	gml_pragma("global", "sc_gui_config_attr_alias_construct()");
	var _class = { cid : GUI_CLASS.DEFAULT, inherit : GUI_CLASS.DEFAULT};
	sc_gui_global_preload_set_factor(
		global.gui_preload.factor_attr_alias,
		_class,
		function(__class)   { return ds_map_create(); },
		function(__obj)		{ ds_map_destroy(__obj); },
		sc_gui_config_attr_alias_clone,
		sc_gui_config_attr_alias_syn_default,
	);
}

/// @function:		sc_gui_config_attr_alias_build() 
/// @description:	Gui config_func attribute alias build.
function sc_gui_config_attr_alias_build()
{
	if (!is_undefined(global.gui.config_attr_alias)) {
		exit;
	}
	global.gui.config_attr_alias = sc_gui_global_config_construct(
		global.gui_preload.factor_attr_alias);
	sc_gui_global_config_build(global.gui_preload.factor_attr_alias);
}

/// @function:		sc_gui_global_attr_alias_destroy() 
/// @description:	Gui config_func attribute alias destroy.
function sc_gui_global_attr_alias_destroy()
{
	if (is_undefined(global.gui.config_attr_alias)) {
		exit;
	}
	sc_gui_global_config_destroy(
		global.gui.config_attr_alias, 
		global.gui_preload.factor_attr_alias);
	global.gui.config_attr_alias= undefined;
}

/// @function:		sc_gui_config_attr_alias_syn_default(__self) 
/// @description:	Gui config_func attribute alias construct set default value.
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}
function sc_gui_config_attr_alias_syn_default(__self)
{
	// see [sc_gui_node_constructor]
	sc_gui_config_attr_alias_set(__self, [
		"sid", "refcount", /*___mark, cid, inherit, fid*/
		"origin", "parent", "childs", "friends", "decorate", "reserver",
		"scrollbar", "scalebar", "shape", 
		"domain_width", "domain_height", "block_width", "block_height", /*block_x, block_y*/
		"view_surface_wrap", "view_surface", "view_prev_id",
		"view_width", "view_height", "view_x", "view_y", "view_width_last", "view_height_last",
		"border_px",
		"shift_x", "shift_y",
		"auxiliary_max_width", "auxiliary_max_height",
		"auxiliary_width", "auxiliary_height", 
		"auxiliary_pos_x", "auxiliary_pos_y",
		"relative_pos_x", "relative_pos_y",
		"stub_pos_x", "stub_pos_y",
		"list_pos",
		"content_width", "content_height", "content_childs", "content_layer",
		"grid_mark", "grid_max_rnum", "grid_max_cnum",
		"grid_pos_row", "grid_pos_col",
		"status_pressed", "status_hover", "status_focus", "status_hold",
		"status_update", "status_skip", "status_stretch", "status_wrap",
		"status_stub", "status_bits", "status_draw", "status_surface",
		"status_nospace", "status_die",
		"hover_x", "hover_y", "hold_x", "hold_y"
	], "private");

	sc_gui_config_attr_alias_set(__self, ["block_x", "bx"], "x");
	sc_gui_config_attr_alias_set(__self, ["block_y", "by"], "y");

	sc_gui_config_attr_alias_set(__self, ["width", "w"], "w");
	sc_gui_config_attr_alias_set(__self, ["height", "h"], "h");
	sc_gui_config_attr_alias_set(__self, ["max_width", "max_w"], "max_w");
	sc_gui_config_attr_alias_set(__self, ["max_height", "max_h"], "max_h");


	sc_gui_config_attr_alias_set(__self, ["margin_top", "mt"], "mt");
	sc_gui_config_attr_alias_set(__self, ["margin_bottom", "mb"], "mb");
	sc_gui_config_attr_alias_set(__self, ["margin_left", "ml"], "ml");
	sc_gui_config_attr_alias_set(__self, ["margin_right", "mr"], "mr");

	sc_gui_config_attr_alias_set(__self, ["padding_top", "pt"], "pt");
	sc_gui_config_attr_alias_set(__self, ["padding_bottom", "pb"], "pb");
	sc_gui_config_attr_alias_set(__self, ["padding_left", "pl"], "pl");
	sc_gui_config_attr_alias_set(__self, ["padding_right", "pr"], "pr");
	
	sc_gui_config_attr_alias_set(__self, ["block_direct", "bd", "dir", "direct"], "bd");

	sc_gui_config_attr_alias_set(__self, ["flag_crlf", "crlf"], "flag_crlf");
	
	sc_gui_config_attr_alias_set(__self, ["value", "val"], "value");
	
	sc_gui_config_attr_alias_set(__self, ["attr_shape", "ashape"], "attr_shape");
	
}

/// @function:		sc_gui_config_attr_alias_clone(__self) 
/// @description:	Gui config_func attribute alias clone.
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}
function sc_gui_config_attr_alias_clone(__self)
{
	gml_pragma("forceinline");
	var _classid = __self.cid;
	var _inherit = __self.inherit;
	var _alias = ds_map_create();
	if (sc_gui_is_fast_classid(_inherit)) {
		ds_map_copy(_alias, global.gui.config_attr_alias[@ _inherit]);
	} else {
		ds_map_copy(_alias, global.gui.config_attr_alias[@ GUI_CLASS.MAX][? _inherit]);
	}
	global.gui.config_attr_alias[@ GUI_CLASS.MAX][? _classid] = _alias;
	return _alias;
}

/// @function:		sc_gui_config_attr_alias_set(__self, __alias_names, __real_name) 
/// @description:	Gui config_func attribute set alias name.
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}
/// @param:         {__alias_names} {string or array string} alias name
/// @param:         {__real_name}   {string} real name
function sc_gui_config_attr_alias_set(__self, __alias_names, __real_name)
{
	var _alias;
	_alias = sc_gui_global_config_get(global.gui.config_attr_alias, 
				global.gui_preload.factor_attr_alias, __self);
	if (is_array(__alias_names)) {
		for (var i = 0; i < array_length(__alias_names); ++i) {
			if (ds_map_exists(_alias, __alias_names[i])) {
				throw("[sc_gui_config_attr_alias_set] conflict!!" +
					"class:" + string(__self.cid) + "alias:" + 
					__alias_names[i] + ",real:" + __real_name);
			}
			_alias[? __alias_names[i]] = __real_name;
		}
	} else {
		_alias[? __alias_names] = __real_name;
	}
}

/// @function:		sc_gui_config_attr_alias_get(__self, __name) 
/// @description:	Gui config_func attribute get real name.
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}
/// @param:         {__name}     {string} alias name
function sc_gui_config_attr_alias_get(__self, __name)
{
	gml_pragma("forceinline");
	var _alias = sc_gui_global_config_get(global.gui.config_attr_alias, 
					global.gui_preload.factor_attr_alias, __self);
	return _alias[? __name];
}