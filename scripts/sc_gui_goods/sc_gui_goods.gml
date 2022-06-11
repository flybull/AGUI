/// @function		sc_gui_goods_construct()
/// @description	constructor gui goods config in global
function sc_gui_goods_construct()
{
	gml_pragma("global", "sc_gui_goods_construct()");
	var _classid = GUI_CLASS.GOODS;
	sc_gui_global_set_class_construct(
		_classid, "goods",
		sc_gui_goods_config_construct,
		sc_gui_goods
	);
	var _classid = GUI_CLASS.GOODS_SLOT;
	sc_gui_global_set_class_construct(
		_classid, "goods_slot",
		sc_gui_goods_slot_config_construct,
		sc_gui_goods_slot
	);
	var _classid = GUI_CLASS.GOODS_SHELF;
	sc_gui_global_set_class_construct(
		_classid, "goods_shelf",
		sc_gui_goods_shelf_config_construct,
		sc_gui_goods_shelf
	);
}

/// @function		sc_gui_goods_config_construct()
/// @description	constructor gui goods config in global
function sc_gui_goods_config_construct() {
	var _class = {cid : GUI_CLASS.GOODS, inherit : GUI_CLASS.DEFAULT };
	sc_gui_config_attr_alias_set(_class, "name", "goods_name");
	sc_gui_config_attr_value_set(_class, {
		goods_slot_sid : undefined,
		goods_type : undefined,
		goods_name : "goods",
		flag_hover_lock : false,
		func_on_press : sc_gui_goods_on_press,
		func_on_hold : sc_gui_goods_on_hold,
		func_on_release : sc_gui_goods_on_release,
	});

	show_debug_message("[global][sc_gui_goods_config_construct] constructor!");
}

/// @function		sc_gui_goods_slot_config_construct()
/// @description	constructor gui goods_slot config in global
function sc_gui_goods_slot_config_construct() {
	var _class = {cid : GUI_CLASS.GOODS_SLOT, inherit : GUI_CLASS.DEFAULT };
	sc_gui_config_attr_alias_set(_class, "name", "goods_name");
	sc_gui_config_attr_value_set(_class, {
		goods_name : "slot",
		goods_type : undefined,
		
		flex_algin : GUI_FLEX_ALIGN.STRETCH, 
		flex_justify : GUI_FLEX_JUSTIFY.STRETCH,
	});

	show_debug_message("[global][sc_gui_goods_config_construct] constructor!");
}

/// @function		sc_gui_goods_shelf_config_construct()
/// @description	constructor gui goods_shelf config in global
function sc_gui_goods_shelf_config_construct() {
	var _class = {cid : GUI_CLASS.GOODS_SHELF, inherit : GUI_CLASS.DEFAULT };
	sc_gui_config_attr_alias_set(_class, ["row_col", "grc"], "shelf_rc");
	sc_gui_config_attr_alias_set(_class, ["slot_wh", "gsz"], "shelf_sz");
	sc_gui_config_attr_alias_set(_class, "name", "goods_name");
	sc_gui_config_attr_value_set(_class, {
		goods_name : "shelf",
		goods_type : undefined,
		shelf_row_num : 0,
		shelf_col_num : 0,
		shelf_slot_width : 64,
		shelf_slot_height : 64,

		flag_wrap: true,
		flag_hover_hole : true,
	});
	sc_gui_config_attr_parse_set(_class, "shelf_rc", function(__attr, __name, __realname, __self) {
		var _val = sc_string_split("*", variable_struct_get(__attr, __name));
		sc_assert(array_length(_val) == 2, "parse shelf_rc failed.");
		shelf_row_num = int64(_val[0]);
		shelf_col_num = int64(_val[1]);
	});
	sc_gui_config_attr_parse_set(_class, "shelf_sz", function(__attr, __name, __realname, __self) {
		var _val = sc_string_split("*", variable_struct_get(__attr, __name));
		sc_assert(array_length(_val) == 2, "parse shelf_sz failed.");
		shelf_slot_width = int64(_val[0]);
		shelf_slot_height = int64(_val[1]);
	});


	show_debug_message("[global][sc_gui_goods_config_construct] constructor!");
}

/// @function		sc_gui_goods(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui goods node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
function sc_gui_goods(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_node(__attr, __func_attach, __func_agrs, GUI_CLASS.GOODS);
}

/// @function		sc_gui_goods_slot(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui goods_slot node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
function sc_gui_goods_slot(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_node(__attr, __func_attach, __func_agrs, GUI_CLASS.GOODS_SLOT);
}

/// @function		sc_gui_goods_shelf(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui goods_shelf node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
function sc_gui_goods_shelf(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_node(__attr, function(__args) {
		var _rnum = shelf_row_num;
		var _cnum = shelf_col_num;
		var _slotw = shelf_slot_width;
		var _sloth = shelf_slot_height;
		// 1. recalc size for slot
		spec_width = _slotw * _rnum + span_w * (_rnum - 1);
		spec_height = _sloth * _cnum + span_h * (_cnum - 1);
		sc_gui_node_begin_size();
		// 2. create childs's slot
		for (var i = 0; i < _rnum; ++i) {
			for (var j = 0; j < _cnum; ++j) {
				//sc_gui_goods_slot({ w : _slotw, h : _sloth});
				sc_gui_goods_slot({ w : _slotw, h : _sloth }, function(__args) {
					if (int64(__args[0]) & 0x01) {
						sc_gui_goods({ /*w : __args[1] - 2, h: __args[2] - 2,*/ text: { str : __args[0]}});
					}
				}, [string(i * _cnum + j), _slotw, _sloth]);
			}
		}
	}, , GUI_CLASS.GOODS_SHELF);
}

function sc_gui_goods_cid_check(__node)
{
	gml_pragma("forceinline");
	switch (__node.cid) {
	case GUI_CLASS.GOODS:
	case GUI_CLASS.GOODS_SLOT:
		return true;
	}
	return false;
}

function sc_gui_goods_on_press()
{
	goods_slot_sid = parent.sid;
	//sc_gui_layout_relative_inner_width(parent);
	//sc_gui_layout_relative_inner_height(parent);
	sc_gui_node_event_insert_by_obj(undefined, self);
}

function sc_gui_goods_on_hold()
{
	sc_gui_move(hold_x, hold_y);
}

function sc_gui_goods_on_release()
{
	var _dst = sc_gui_global_node_find(global.gui.hover_node_id);
	var _src = sc_gui_global_node_find(goods_slot_sid);
	var _mismatch = false;
	if (is_undefined(_src)) {
		sc_assert(false, "this isn't possible!");
		sc_gui_node_event_delete_by_obj(self);
		exit;
	}
	// 1. check valid slot.	
	if (is_undefined(_dst) || is_undefined(_dst.parent) || _dst.sid == _src.sid ||
		!sc_gui_goods_cid_check(_dst) || !sc_gui_goods_cid_check(_src)) {
		_mismatch = true;
	} else {
		switch (_dst.cid) {
		case  GUI_CLASS.GOODS:
			if (_dst.parent.goods_type != _src.goods_type || _dst.goods_type != goods_type) {
				_mismatch = true;
				break;
			}
			//sc_assert(_dst.parent.goods_name == "slot", "error");
			sc_gui_node_event_insert_by_obj(_dst.parent, self);
			sc_gui_node_event_insert_by_obj(_src, _dst);
			break;
		case GUI_CLASS.GOODS_SLOT:
			if (_dst.goods_type != _src.goods_type) {
				_mismatch = true;
				break;
			}
			if (!ds_list_size(_dst.childs)) {
				sc_gui_node_event_insert_by_obj(_dst, self);
				break;
			}
			var _node = sc_ds_list_find_direct(_dst.childs, function(__goods_type) {
				return goods_type == __goods_type;
			}, goods_type);
			
			if (is_undefined(_node)) {
				_mismatch = true;
				break;
			}
			sc_gui_node_event_insert_by_obj(_dst, self);
			sc_gui_node_event_insert_by_obj(_src, _node);
			break;
		default:
			_mismatch = true;
			break;
		}
	}
	if (_mismatch) {
		sc_gui_node_event_insert_by_obj(_src, self);
		goods_slot_sid = undefined;
	}

	goods_slot_sid = undefined;
}

