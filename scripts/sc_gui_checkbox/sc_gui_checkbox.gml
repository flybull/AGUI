/// @function		sc_gui_checkbox_construct()
/// @description	constructor gui checkbox config in global
function sc_gui_checkbox_construct()
{
	gml_pragma("global", "sc_gui_checkbox_construct()");
	sc_gui_global_set_class_construct(
		GUI_CLASS.SCHECKBOX, "scheckbox",
		sc_gui_scheckbox_config_construct,
		sc_gui_scheckbox
	);
	sc_gui_global_set_class_construct(
		GUI_CLASS.MCHECKBOX, "mcheckbox",
		sc_gui_mcheckbox_config_construct,
		sc_gui_mcheckbox
	);
}

/// @function		sc_gui_scheckbox_config_construct()
/// @description	constructor gui select bar config in global
function sc_gui_scheckbox_config_construct() {
	var _class = {cid : GUI_CLASS.SCHECKBOX, inherit : GUI_CLASS.DEFAULT};
	sc_gui_config_attr_value_set(_class, {
		select_hit : undefined, 
		//attr_shape : undefined,
		padding : 8, span_w : 4, span_h : 4,
		flag_stretch : true,
		flex_algin : GUI_FLEX_ALIGN.CENTER,
	});
	show_debug_message("[global][sc_gui_scheckbox_config_construct] constructor!")
}

/// @function		sc_gui_mcheckbox_config_construct()
/// @description	constructor gui select bar config in global
function sc_gui_mcheckbox_config_construct() {
	var _class = {cid : GUI_CLASS.MCHECKBOX, inherit : GUI_CLASS.DEFAULT};
	sc_gui_config_attr_value_set(_class, {
		padding : 8, span_w : 4, span_h : 4,
		attr_shape : undefined,
		flag_stretch : true,
		flex_algin : GUI_FLEX_ALIGN.CENTER,
	});

	show_debug_message("[global][sc_gui_mcheckbox_config_construct] constructor!")
}

/// @function		sc_gui_scheckbox(__args, __attr = undefined)
/// @description	Constructor Gui single select node.
/// @param          __args  {array} ex. [string, string]
/// @param          __attr {struct} init property
function sc_gui_scheckbox(__args, __attr = undefined)
{
	gml_pragma("forceinline");

	return sc_gui_node(__attr, function(__args) {
		sc_assert(is_array(__args), "[sc_gui_scheckbox] args.value type error! type:" + typeof(__args));
		for (var i = 0; i < array_length(__args); ++i) {
			sc_gui_sprite({sprite_id : s_select, sprite_idx : 0, select_val : __args[i], func_on_press : sc_gui_scheckbox_set_val});
			sc_gui_text({pattern : __args[i], flag_stretch: true, flag_hover_hole : true});
		}
	}, __args, GUI_CLASS.SCHECKBOX);
}

/// @function		sc_gui_scheckbox_set_val()
/// @description	Gui single select set value.
function sc_gui_scheckbox_set_val() {
	var _parent = parent;
	if (is_undefined(_parent.select_hit)) {
		_parent.select_hit = self;
		_parent.select_hit.sprite_idx = 1;
	} else {
		_parent.select_hit.sprite_idx = 0;
		_parent.select_hit = self;
		_parent.select_hit.sprite_idx = 1;
	}
}

/// @function		sc_gui_mcheckbox(__args, __attr = undefined)
/// @description	Constructor Gui multiple select node.
/// @param          __args  {struct} ex. {value:[string, string]}
/// @param          __attr  {struct} init property
function sc_gui_mcheckbox(__args, __attr = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_node(__attr, function(__args) {
		sc_assert(is_array(__args), "[sc_gui_scheckbox] args.value type error! type:" + typeof(__args));
		for (var i = 0; i < array_length(__args); ++i) {
			sc_gui_sprite({ sprite_id : s_select, sprite_idx : 0, select_val : __args[i], func_on_press : sc_gui_mcheckbox_set_val});
			sc_gui_text({pattern : __args[i], flag_stretch: true, flag_hover_hole : true});
		}
	}, __args, GUI_CLASS.MCHECKBOX);
}

/// @function		sc_gui_mcheckbox_set_val()
/// @description	Gui single multiple set value.
function sc_gui_mcheckbox_set_val() {
	sprite_idx = sprite_idx ? 0 : 1;
}
