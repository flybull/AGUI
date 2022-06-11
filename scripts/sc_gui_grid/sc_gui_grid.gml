/// @function		sc_gui_grid_construct()
/// @description	constructor gui grid config in global
function sc_gui_grid_construct()
{
	gml_pragma("global", "sc_gui_grid_construct()");
	var _classid = GUI_CLASS.GRID;
	sc_gui_global_set_class_construct(
		_classid, "grid",
		sc_gui_grid_config_construct,
		sc_gui_grid
	);
}

/// @function		sc_gui_grid_config_construct()
/// @description	constructor gui grid config in global
function sc_gui_grid_config_construct() {
	var _class = {cid : GUI_CLASS.GRID, inherit : GUI_CLASS.DEFAULT};
	sc_gui_config_attr_alias_set(_class, ["row_col", "grc"], "grid_rc");
	sc_gui_config_attr_alias_set(_class, ["slot_wh", "gsz"], "grid_sz");
	sc_gui_config_attr_value_set(_class, {
		grid_row_num : 0,
		grid_col_num : 0,
		grid_slot_width : 64,
		grid_slot_height : 64,
		
		flag_wrap: true,
		flag_hover_hole : true,
	});
	sc_gui_config_attr_parse_set(_class, "grid_rc", function(__attr, __name, __realname, __self) {
		var _val = sc_string_split("*", variable_struct_get(__attr, __name));
		sc_assert(array_length(_val) == 2, "parse grid_rc failed.");
		grid_row_num = int64(_val[0]);
		grid_col_num = int64(_val[1]);
	});
	sc_gui_config_attr_parse_set(_class, "grid_sz", function(__attr, __name, __realname, __self) {
		var _val = sc_string_split("*", variable_struct_get(__attr, __name));
		sc_assert(array_length(_val) == 2, "parse grid_sz failed.");
		grid_slot_width = int64(_val[0]);
		grid_slot_height = int64(_val[1]);
	});
	show_debug_message("[global][sc_gui_grid_config] constructor!");	
}

/// @function		sc_gui_grid(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui grid node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
function sc_gui_grid(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_node(__attr, function(__args) {
		var _rnum = grid_row_num;
		var _cnum = grid_col_num;
		var _slotw = grid_slot_width;
		var _sloth = grid_slot_height;
		// 1. recalc size for slot
		spec_width = _slotw * _rnum + span_w * (_rnum - 1);
		spec_height = _sloth * _cnum + span_h * (_cnum - 1);
		sc_gui_node_begin_size();
		// 2. create childs's slot
		for (var i = 0; i < _rnum; ++i) {
			for (var j = 0; j < _cnum; ++j) {
				//sc_base_safe_call(__func_attach, __func_agrs);
				sc_gui_drag({ w : _slotw, h : _sloth,
					//w : _slotw * ((i & 0x01) + 1),
					//h : _sloth * ((j & 0x01) + 1), 
					text:{ str : string(i * _cnum + j)}, flag_stretch : false});
			}
		}
	}, , GUI_CLASS.GRID);
}


