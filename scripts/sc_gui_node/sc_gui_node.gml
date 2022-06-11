enum GUI_NODE_TYPE {
	ROOT,
	NODE,
	ORPHAN,
	FRIEND,
}

/// @function		sc_gui_node_construct()
/// @description	constructor gui node config in global
function sc_gui_node_construct()
{
	gml_pragma("global", "sc_gui_node_construct()");
	var _classid = GUI_CLASS.DEFAULT;
	sc_gui_global_set_class_construct(
		_classid, "default",
		sc_base_empty_call,
		undefined
	);
}

/// @function		sc_gui_node_constructor(
///							__sn, __cid, __inherit, 
///							__origin = undefined, 
///							__parent = undefined)
/// @description	Constructor Gui node
/// @param:         __sn
/// @param:         __classid  {real or GUI_CLASS} class id
/// @param:         __inherit  {real or GUI_CLASS} inherit class id
/// @param:         __type  {enum} GUI_WIDGET_E
/// @param:			__origin  origin node
/// @param:			__parent  parent node
function sc_gui_node_constructor(__sn, __cid, __inherit, __origin = undefined, __parent = undefined) constructor
{
	___mark = undefined; // mark is node constructor for decorate.
	sid = __sn; // sequence id
	cid = __cid;	// class id
	inherit = __inherit;

	fid = undefined;   //string
	//prvid = undefined; // [friend/child]
	//pubid = undefined; // [global/local]
	refcount = 0;

	origin = is_undefined(__origin) ? self : __origin;
	parent = __parent;
	//siblings = ds_list_create();	// just referent, best use tree.
	friends = ds_map_create();	// just referent, best use tree. pop-over
	childs = ds_list_create();
	decorate = ds_list_create();
	reserver = ds_list_create(); // save sid for safe.
	scrollbar = undefined;
	scalebar = undefined;
	shape = undefined;  // border + backgroup

	// Don't change order
	// for rotate
	domain_width = 0;
	domain_height = 0;

	//block_x = 0; // __x
	//block_y = 0; // __y
	block_width = 0;
	block_height = 0;
	sc_gui_config_syn_attr_value(self);

	/* view surface */
	view_surface_wrap = undefined;
	view_surface = undefined;
	view_prev_id = -1; //screen
	// view = (origin block) + padding + border
	view_width = 0;
	view_height = 0;
	view_width_last = undefined;
	view_height_last = undefined;
	// view content coordinates
	view_x = 0;
	view_y = 0;

	// border
	border_px = 0;

	// shift (block x/y)
	shift_x = 0;
	shift_y = 0;

	// auxiliary (use for layout)
	auxiliary_max_width = 0;
	auxiliary_max_height = 0;
	auxiliary_width = 0;
	auxiliary_height = 0;
	auxiliary_pos_x = 0;
	auxiliary_pos_y = 0;
	// offset (margin replaced with offset)
	relative_pos_x = 0; // is_undefined(__parent) ? __x : 0;
	relative_pos_y = 0; // is_undefined(__parent) ? __y : 0;
	// record layout relative_pos for node recalc.
	stub_pos_x = 0;
	stub_pos_y = 0;
	
	// childs/decorate pos
	list_pos = undefined;

	// content (use for layout or flex)
	// content == max(width), max(height)
	// content maybe doesn't equal (block - padding - border)
	content_width = 0;
	content_height = 0;
	// Record every line width and height for accurate content width and height
	content_childs = undefined;
	content_layer = 0; // in parent.content_layer pos.
	// grid for childs
	grid_mark = undefined;
	grid_max_rnum = 1;
	grid_max_cnum = 1;
	// grid for self
	grid_pos_row = undefined;
	grid_pos_col = undefined;

	// status (only write by internal)
	// if child node have been stretch, then parent will stretch content
	// [sc_gui_layout]
	status_stretch = false;
	// [sc_gui_layout_flex]
	// if status_wrap = true then stop recursion to wrap
	status_wrap = false;
	// [sc_gui_hover]
	status_pressed = false;
	status_hover = false;
	status_focus = false;
	status_hold = false;
	
	// if node have been update width or height or padding, 
	// then you must be setted this status_stub
	// make relative_pos is real.
	status_stub = true;

	// [o_gui_impl]
	status_update = false;
	status_skip = false;
	// [sc_gui_draw]
	status_bits = GUI_STATUS.NONE;
	// [layout]
	// status_alter_size = false;
	// status_alter_pos = false;

	// constraint draw child's node.
	status_draw = true;
	status_surface = false;
	status_transition = false;
	status_nospace = false;
	status_die = false;
	
	// hover (mouse x/y in this node)
	// [sc_gui_hover]
	hover_x = 0;
	hover_y = 0;
	hold_x = 0;
	hold_y = 0;
}

/// @function		sc_gui_root(__attr = undefined, 
///								__func_attach = undefined, 
///								__func_agrs = undefined,
///								__classid = GUI_CLASS.DEFAULT,
///                             __inherit = GUI_CLASS.DEFAULT)
/// @description	Constructor Gui root node
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
/// @param          __classid  {real or GUI_CLASS} class id
/// @param          __inherit  {real or GUI_CLASS} inherit class id
function sc_gui_root(__attr = undefined, __func_attach = undefined, __func_agrs = undefined, __classid = GUI_CLASS.DEFAULT, __inherit = GUI_CLASS.DEFAULT)
{
	var _node = sc_gui_global_node_obtain(__classid, __inherit);
	sc_gui_list_add(global.gui.list_node, _node);
	
	with(_node) {
		func[GUI_FUNC_TYPE.ON_INIT_BEGIN](__attr);
		if (!is_undefined(__func_attach)) {
			sc_base_safe_call(__func_attach, __func_agrs);
		}
		func[GUI_FUNC_TYPE.ON_INIT_END]();
	}
		
	return _node;
}

/// @function		sc_gui_node(__attr = undefined,
///								__func_attach = undefined,
///								__func_agrs = undefined,
///								__classid = GUI_CLASS.DEFAULT,
///                             __inherit = GUI_CLASS.DEFAULT)
/// @description	Constructor Gui sub node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
/// @param          __classid  {real or GUI_CLASS} class id
/// @param          __inherit  {real or GUI_CLASS} inherit class id
function sc_gui_node(__attr = undefined, __func_attach = undefined, __func_agrs = undefined, __classid = GUI_CLASS.DEFAULT, __inherit = GUI_CLASS.DEFAULT)
{
	var _node = sc_gui_global_node_obtain(__classid, __inherit, origin, self);
	sc_gui_list_add(childs, _node);
	with(_node) {
		func[GUI_FUNC_TYPE.ON_INIT_BEGIN](__attr);
		if (!is_undefined(__func_attach)) {
			sc_base_safe_call(__func_attach, __func_agrs);
		}
		func[GUI_FUNC_TYPE.ON_INIT_END]();
	}
		
	return _node;
}


/// @function		sc_gui_orphan(__attr = undefined,
///								__func_attach = undefined,
///								__func_agrs = undefined,
///								__classid = GUI_CLASS.DEFAULT,
///                             __inherit = GUI_CLASS.DEFAULT)
/// @description	Constructor Gui node's orphan.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
/// @param          __classid  {real or GUI_CLASS} class id
/// @param          __inherit  {real or GUI_CLASS} inherit class id
function sc_gui_orphan(__attr = undefined, __func_attach = undefined, __func_agrs = undefined, __classid = GUI_CLASS.DEFAULT, __inherit = GUI_CLASS.DEFAULT)
{
	var _node = sc_gui_global_node_obtain(__classid, __inherit, origin, self);
	with(_node) {
		func[GUI_FUNC_TYPE.ON_INIT_BEGIN](__attr);
		if (!is_undefined(__func_attach)) {
			sc_base_safe_call(__func_attach, __func_agrs);
		}
		func[GUI_FUNC_TYPE.ON_INIT_END]();
	}
		
	return _node;
}

/// @function		sc_gui_friend(__attr = undefined,
///								 __func_attach = undefined,
///								 __func_agrs = undefined,
///								 __classid = GUI_CLASS.DEFAULT,
///                              __inherit = GUI_CLASS.DEFAULT)
/// @description	Constructor Gui linker with the associate node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
/// @param          __classid  {real or GUI_CLASS} class id
/// @param          __inherit  {real or GUI_CLASS} inherit class id
function sc_gui_friend(__attr = undefined, __func_attach = undefined, __func_agrs = undefined, __classid = GUI_CLASS.DEFAULT, __inherit = GUI_CLASS.DEFAULT)
{
	gml_pragma("forceinline");
	var _node = sc_gui_global_node_obtain(__classid, __inherit);
	sc_gui_list_add(global.gui.list_node, _node);
	sc_assert(!is_undefined(fid) && !is_undefined(_node.fid), 
				"[sc_gui_linker] only link a node!");
	if (!ds_map_add(_node.friends, fid, self) ||
		!ds_map_add(friends, _node.fid, _node)) {
		sc_assert(false, "[sc_gui_friend] friend id conflicts!");
	}
	with(_node) {
		func[GUI_FUNC_TYPE.ON_INIT_BEGIN](__attr);
		if (!is_undefined(__func_attach)) {
			sc_base_safe_call(__func_attach, __func_agrs);
		}
		func[GUI_FUNC_TYPE.ON_INIT_END]();
	}
		
	return _node;
}

/// @function		sc_gui_decorate(__attr = undefined,
///								 __func_attach = undefined,
///								 __func_agrs = undefined,
///								 __classid = GUI_CLASS.DEFAULT,
///                              __inherit = GUI_CLASS.DEFAULT)
/// @description	Constructor Gui decorate the node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
/// @param          __classid  {real or GUI_CLASS} class id
/// @param          __inherit  {real or GUI_CLASS} inherit class id
function sc_gui_decorate(__attr = undefined, __func_attach = undefined, __func_agrs = undefined, __classid = GUI_CLASS.DEFAULT, __inherit = GUI_CLASS.DEFAULT)
{
	var _node = sc_gui_global_node_obtain(__classid, __inherit, origin, self);
	sc_gui_list_add(decorate, _node);
	with(_node) {
		func[GUI_FUNC_TYPE.ON_INIT_BEGIN](__attr);
		if (!is_undefined(__func_attach)) {
			sc_base_safe_call(__func_attach, __func_agrs);
		}
		func[GUI_FUNC_TYPE.ON_INIT_END]();
	}
		
	return _node;
}

/// @function		sc_gui_node_reset()
/// @description	Gui node reset.
function sc_gui_node_reset()
{
	/* view surface */
	if (!is_undefined(view_surface_wrap)) {
		surface_free(view_surface_wrap);
		view_surface_wrap = undefined;
	}
	if (!is_undefined(view_surface)) {
		surface_free(view_surface);
		view_surface = undefined;
	}
	view_prev_id = -1;
	// view = (origin block) + padding + border
	view_width_last = view_width;
	view_height_last = view_height;
	view_width = 0;
	view_height = 0;

	// auxiliary (use for layout)
	auxiliary_max_width = 0;
	auxiliary_max_height = 0;
	auxiliary_width = 0;
	auxiliary_height = 0;
	auxiliary_pos_x = 0;
	auxiliary_pos_y = 0;
	relative_pos_x = is_undefined(parent) ? block_x : 0;
	relative_pos_y = is_undefined(parent) ? block_y : 0;
	stub_pos_x = 0;
	stub_pos_y = 0;

	// block
	block_width = 0;
	block_height = 0;
	// content (use for layout or flex)
	// content == max(width), max(height)
	// content maybe doesn't equal (block - padding - border)
	content_width = 0;
	content_height = 0;
	// Record every line width and height for accurate content width and height
	if (!is_undefined(content_childs)) {
		ds_list_clear(content_childs);
		ds_list_destroy(content_childs);
		content_childs = undefined;
	}
	content_layer = 0;
	// don't do it, keep origin position
	//if (!is_undefined(grid_mark)) {
	//	for (var i = 0; i < spec_row; ++i) {
	//		for (var j = 0; j < spec_col; ++j) {
	//			grid_mark[@ i][@ j] = 0;
	//		}
	//	}
	//}
	// need to recalc it.( don't care grid's node move, and update after delete. )
	grid_max_rnum = 1;
	grid_max_cnum = 1;
	
	// don't release scrollbar or scalebar, 
	// because the node maybe is hover

	// flag
	status_stretch = false;
	status_stub = true;
	status_draw = true;
	status_transition = false;
	status_nospace = false;
}

/// @function		sc_gui_node_begin(__attr = undefined)
/// @description	Gui node init begin.
/// @param          __attr  {struct} init property
function sc_gui_node_begin(__attr = undefined)
{
	if (!is_undefined(parent)) {
		// Update Node relative to container direction.
		if (block_direct == GUI_FLEX_DIRECT.INHERT && 
			parent.block_direct != GUI_FLEX_DIRECT.GRID) {
			block_direct = parent.block_direct;
		}
	}
	// Update self attribute
	if (!is_undefined(__attr)) {
		sc_gui_config_syn_add_other_attr_value(self, __attr);
	}
	// don't support rotate in stretch
	rotate = flag_stretch ? 0 : rotate;
	
	sc_gui_node_begin_func();
	sc_gui_node_begin_size();

	relative_pos_x = is_undefined(parent) ? block_x : 0;
	relative_pos_y = is_undefined(parent) ? block_y : 0;
	
	status_transition = rotate != 0 ? true : false;
		
	// [!is_undefined(attr_animation) for draw animatation x,y]
	if (is_undefined(parent) || 
		!is_undefined(attr_animation) || 
		status_transition) {
		status_surface = true;
	} else {
		status_surface = flag_scroll == GUI_AXIS_TYPE.NONE ? false : true;
	}

}

/// @function		sc_gui_node_begin_size()
/// @description	Gui node init begin set default size value.
///                 Because parse attr's value is out-of-order, 
///                 So don't set value in the parse.
function sc_gui_node_begin_size()
{
	gml_pragma("forceinline");
	if (block_direct == GUI_FLEX_DIRECT.GRID) {
		span_w = span_w ? 1 : 0;
		span_h = span_h ? 1 : 0;
		// sc_gui_measure_grid_unit_width
		spec_width = ceil(spec_width / spec_row) * spec_row + span_w * (spec_row - 1);
		spec_height = ceil(spec_height / spec_col) * spec_col + span_h * (spec_col - 1);

		grid_mark = sc_gui_grid2_create(spec_row, spec_col);
	}
	block_width = spec_width * scale_x + padding_left + padding_right;
	block_height = spec_height * scale_y + padding_top + padding_bottom;
	view_width = block_width;
	view_height = block_height;
}
/// @function		sc_gui_node_begin_func()
/// @description	Gui node init begin set default func value.
///                 Because parse attr's value is out-of-order, 
///                 So don't set value in the parse.
function sc_gui_node_begin_func()
{
	gml_pragma("forceinline");
	if (flag_scroll != GUI_AXIS_TYPE.NONE) {
		if (is_undefined(func[GUI_FUNC_TYPE.ON_WHEEL_UP])) {
			func[@ GUI_FUNC_TYPE.ON_WHEEL_UP] = method(undefined, sc_gui_scrollbar_on_wheel_up);
		}
		if (is_undefined(func[GUI_FUNC_TYPE.ON_WHEEL_DOWN])) {
			func[@ GUI_FUNC_TYPE.ON_WHEEL_DOWN] = method(undefined, sc_gui_scrollbar_on_wheel_down);
		}
	}
	if (block_direct == GUI_FLEX_DIRECT.INHERT) {
		block_direct = GUI_FLEX_DIRECT.ROW;
	}	
}

/// @function		sc_gui_node_end()
/// @description	Gui node init end.
function sc_gui_node_end()
{
	#region "Layout"
	// Don't change the order.
	// 首先需要计算子类布局，因为flex需要换行计算尺寸
	// 1. 编排整理子类布局，
	// Code Tip: sc_gui_node_layout_crlf
	//           sc_gui_node_layout_calc
	auxiliary_pos_x = padding_left;
	auxiliary_pos_y = padding_top;
	
	// 2.Layout child node and calc node weight and height.
	sc_ds_list_foreach(childs, sc_gui_node_layout);

	// 3.Set last content layer.
	sc_gui_node_layout_last_crlf();
	#endregion

	#region "Calc Layout / Calcuate node width and height"
	sc_ds_list_foreach(decorate, sc_gui_node_decorate_layout);
	#endregion

	#region  "Redress width and height"
	// 4.Update node width and height
	content_width = max(auxiliary_max_width, content_width);
	content_height = max(auxiliary_max_height, content_height);
	block_width = max(block_width, content_width + padding_left + padding_right);
	block_height = max(block_height, content_height + padding_top + padding_bottom);
	// sc_assert(block_width >= view_width, "[sc_gui_node_end] block_width < view_width");
	// sc_assert(block_height >= view_height, "[sc_gui_node_end] block_height < view_height");

	// 5. scrollbar
	sc_gui_node_recalc_view_wh_by_scroll();
	// 6. scrollbar node create;
	sc_gui_node_attach_scrollbar();
	sc_gui_node_attach_scalebar();
	
	// 7. evaluate border size(don't change on transform)
	if (!is_undefined(shape)) {
		border_px = shape.get_borderpx(view_width, view_height);
	}
	// 8. re-calc node size
	block_width += 2 * border_px;
	block_height += 2 * border_px;
	view_width += 2 * border_px;
	view_height += 2 * border_px;

	// 9. calc domain size by rotate
	if (rotate != 0) {
		var _domain = sc_gui_rotate_rect_wh(rotate, view_width, view_height);
		domain_width = _domain[0];
		domain_height = _domain[1];
		shift_x = _domain[2];
		shift_y = _domain[3];
	} else {
		domain_width = view_width;
		domain_height = view_height;	
	}
	if (!is_undefined(shape)) {
		shape.update(view_width, view_height);
	}

	// 10.If children's node has been stretched, then re-calc content size;
	// 此时的content含义和layout不一致，即内容真实的大小
	if (status_stretch) {
		switch (block_direct) {
		case GUI_FLEX_DIRECT.ROW:
		case GUI_FLEX_DIRECT.RROW:
			content_width = sc_gui_node_layer_get_content_width(GUI_ENTITY_TYPE.BLOCK_NO_PB);
			break;
		case GUI_FLEX_DIRECT.COL:
		case GUI_FLEX_DIRECT.RCOL:
			content_height = sc_gui_node_layer_get_content_height(GUI_ENTITY_TYPE.BLOCK_NO_PB);
			break;
		}
	}
	#endregion
	
	#region "Process Top node in last(only once)."
	if (!is_undefined(parent)) {
		exit;
	}
	// Update node site.
	sc_ds_list_foreach_before("childs", sc_gui_node_update_layout);
	#endregion
}

/// @function		sc_gui_node_destroy()
/// @description	Gui node destroy.
function sc_gui_node_destroy()
{
	sc_assert(status_die == false, "only once");
	status_die = true;
	if (!is_undefined(friends)) {
		ds_map_clear(friends);
		ds_map_destroy(friends);
		friends = undefined;
	}
	sc_gui_node_destroy_list(reserver);
	reserver = undefined;
	sc_gui_node_destroy_list(childs);
	childs = undefined;
	sc_gui_node_destroy_list(decorate);
	decorate = undefined;

	if (!is_undefined(shape)) {
		delete shape;
	}
	if (!is_undefined(scrollbar)) {
		with(scrollbar) {
			sc_gui_node_destroy();
			sc_gui_global_node_release();
		}
		delete scrollbar;
		scrollbar = undefined;
	}
	if (!is_undefined(scalebar)) {
		with (scalebar) {
			sc_gui_node_destroy();
			sc_gui_global_node_release();
		}
		delete scalebar;
		scalebar = undefined
	}
	if (!is_undefined(view_surface_wrap)) {
		surface_free(view_surface_wrap);
		view_surface_wrap = undefined;
	}
	if (!is_undefined(view_surface)) {
		surface_free(view_surface);
		view_surface = undefined;
	}
	array_delete(func, 0, array_length(func));
	func = undefined;
		
	if (!is_undefined(content_childs)) {
		ds_list_clear(content_childs);
		ds_list_destroy(content_childs);
		content_childs = undefined;
	}
	if (!is_undefined(grid_mark)) {
		sc_gui_grid2_destroy(grid_mark, spec_row, spec_col);
		grid_mark = undefined;
	}
	if (!is_undefined(keyboard_observe)) {
		global.gui.keyboard_impl.unregister_press(sid, variable_struct_get(keyboard_observe, "press"));
		global.gui.keyboard_impl.unregister_release(sid, variable_struct_get(keyboard_observe, "release"));
	}
}

/// @function		sc_gui_node_destroy_list()
/// @description	Gui list node destroy.
function sc_gui_node_destroy_list(__list, __ref = false)
{
	if (is_undefined(__list)) {
		exit;
	}
	if (__ref) {
		sc_gui_list_destroy(__list, function() {
			sc_gui_node_destroy();
			sc_gui_global_node_release();
		});		
	} else {
		sc_gui_list_destroy(__list, function() {
			list_pos = undefined;
			sc_gui_node_destroy();
			sc_gui_global_node_release();
		});
	}
	
}

/// @function		sc_gui_node_attach_scrollbar()
/// @description	Scrollbar attach to the node.
function sc_gui_node_attach_scrollbar()
{
	gml_pragma("forceinline");
	if (flag_scroll != GUI_AXIS_TYPE.NONE && is_undefined(scrollbar)) {
		scrollbar = sc_gui_scrollbar(attr_scroll);
	}	
}

/// @function		sc_gui_node_attach_scalebar()
/// @description	Scalebar attach to the node.
function sc_gui_node_attach_scalebar()
{
	gml_pragma("forceinline");
	if (flag_scale != GUI_AXIS_TYPE.NONE && is_undefined(scalebar)) {
		scalebar = sc_gui_scale(attr_scale);
	}	
}

/// @function		sc_gui_node_status_combine()
/// @description	Combine some status to status_bits.
function sc_gui_node_status_combine()
{
	gml_pragma("forceinline");
	var _status_bits = GUI_STATUS.NONE;
	if (status_focus) {
		_status_bits |= GUI_STATUS.FOCUS;
	}
	if (status_hover) {
		_status_bits |= GUI_STATUS.HOVER;
	}
	if (status_pressed) {
		_status_bits |= GUI_STATUS.PRESS;
	}
	if (status_hold) {
		_status_bits |= GUI_STATUS.HOLD;
	}
	status_bits = _status_bits;
	return _status_bits;
}

function sc_gui_node_update_size()
{
	gml_pragma("forceinline");
	// Depend on content_width and content_height
	block_width = max(block_width, content_width);
	block_height = max(block_height, content_height);
	view_width = block_width;
	view_height = block_height;
	domain_width = view_width;
	domain_height = view_height;	
}
