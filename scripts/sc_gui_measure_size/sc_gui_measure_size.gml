enum GUI_ENTITY_TYPE {
	BLOCK_NO_PB,
	VIEW_NO_PB,
	PB,
	LTPB,
	RBPB,
	CONTENT,
	CONTENT_ORG,
	LAYER,
	LAYER_ORG,
}

/// @function		sc_gui_node_stretch(__block_direct)
/// @description	Stretch node to parent boundary.
function sc_gui_node_stretch(__block_direct)
{
	if (!flag_stretch /* || flag_scroll != GUI_AXIS_TYPE.NONE*/) {
		exit;
	}
	if (rotate != 0) {
		exit;
	}
	if (is_undefined(parent)) {
		exit;
	}
	switch (__block_direct) {
	case GUI_FLEX_DIRECT.ROW:
	case GUI_FLEX_DIRECT.RROW:
		sc_gui_node_stretch_width();
		break;
	case GUI_FLEX_DIRECT.COL:
	case GUI_FLEX_DIRECT.RCOL:
		sc_gui_node_stretch_height();
		break;
		break;
	}
}

function sc_gui_node_stretch_width()
{
	gml_pragma("forceinline");
	var _val = sc_gui_measure_n2p_block_width();
	if (block_width == _val) {
		exit;
	}
	if (block_width < _val) {
		block_width = _val;
		content_width = sc_gui_node_layer_get_content_width(GUI_ENTITY_TYPE.BLOCK_NO_PB);
	}
	view_width = _val;
	domain_width = _val;
	if (!is_undefined(shape)) {
		shape.update(view_width, view_height);
	}
}

function sc_gui_node_stretch_height()
{
	gml_pragma("forceinline");
	var _val = sc_gui_measure_n2p_block_height();
	if (block_height == _val) {
		exit;
	}
	if (block_height < _val) {
		block_height = _val;
		content_height = sc_gui_node_layer_get_content_height(GUI_ENTITY_TYPE.BLOCK_NO_PB);
	}
	view_height = _val;
	domain_height = _val;
	if (!is_undefined(shape)) {
		shape.update(view_width, view_height);
	}
}

function sc_gui_measure_n2p_block_width()
{
	gml_pragma("forceinline");
	var _parent = parent;
	var _pos = relative_pos_x;
	if (is_undefined(_parent)) {
		return block_width;
	}
	with (_parent) {
		return block_width - _pos - padding_right - border_px;
	}	
}

function sc_gui_measure_n2p_block_height()
{
	gml_pragma("forceinline");
	var _parent = parent;
	var _pos = relative_pos_y;
	if (is_undefined(_parent)) {
		return block_height;
	}
	with (parent) {
		return block_height - _pos - padding_top - border_px;
	}	
}

function sc_gui_measure_nl2pl_view_width()
{
	gml_pragma("forceinline");
	var _pos = relative_pos_x;
	var _parent = parent;
	var _view_width = view_width;
	if (is_undefined(_parent)) {
		return _view_width;
	}
	with (_parent) {
		return min(0, (_pos - view_x) - padding_left - border_px);
	}
}

function sc_gui_measure_nr2pr_view_width()
{
	gml_pragma("forceinline");
	var _pos = relative_pos_x;
	var _parent = parent;
	var _view_width = view_width;
	if (is_undefined(_parent)) {
		return max(0, display_get_gui_width() - _view_width);
	}
	with (_parent) {
		return min(_view_width, view_width - (_pos - view_x) - padding_right - border_px);
	}
}

function sc_gui_measure_nt2pt_view_height()
{
	gml_pragma("forceinline");
	var _pos = relative_pos_y;
	var _parent = parent;
	var _view_height = view_height;
	if (is_undefined(_parent)) {
		return _view_height;
	}
	with (_parent) {
		return min(0, (_pos - view_y) - padding_top - border_px);
	}
}

function sc_gui_measure_nb2pb_view_height()
{
	gml_pragma("forceinline");
	var _pos = relative_pos_y;
	var _parent = parent;
	var _view_height = view_height;
	if (is_undefined(_parent)) {
		return max(0, display_get_gui_height() - _view_height);
	}
	with (_parent) {
		return min(_view_height, view_height - (_pos - view_y) - padding_bottom - border_px);
	}
}

function sc_gui_node_stretch_grid()
{
	gml_pragma("forceinline");
	if (is_undefined(parent)) {
		exit;
	}
	var _width = sc_gui_measure_grid_node_width();
	var _height = sc_gui_measure_grid_node_height();
	if (block_width != _width) {
		block_width = _width;
		view_width = _width;
		domain_width = _width;
		content_width = sc_gui_node_layer_get_content_width(GUI_ENTITY_TYPE.BLOCK_NO_PB);
	}
	if (block_height != _height) {
		block_height = _height;
		view_height = _height;
		domain_height = _width;
		content_height = sc_gui_node_layer_get_content_height(GUI_ENTITY_TYPE.BLOCK_NO_PB);
	}
	if (!is_undefined(shape)) {
		shape.update(view_width, view_height);
	}	
}

function sc_gui_measure_grid_node_width()
{		
	gml_pragma("forceinline");
	var _unit_width;
	with (parent) {
		_unit_width = sc_gui_measure_grid_unit_width();
	}
	return floor((view_width + _unit_width - 1) / _unit_width) * _unit_width;
}

function sc_gui_measure_grid_node_height()
{
	gml_pragma("forceinline");
	var _unit_height;
	with (parent) {
		_unit_height = sc_gui_measure_grid_unit_height();
	}
	return floor((view_height + _unit_height - 1) / _unit_height) * _unit_height;
}


function sc_gui_measure_grid_unit_width()
{		
	gml_pragma("forceinline");
	// see sc_gui_node_begin_size
	return floor((spec_width - span_w * (spec_row - 1)) / spec_row);
}

function sc_gui_measure_grid_unit_height()
{
	gml_pragma("forceinline");
	// see sc_gui_node_begin_size
	return floor((spec_height - span_h * (spec_col - 1)) / spec_col);
}

function sc_gui_measure_grid_norm_row(__view_width)
{		
	gml_pragma("forceinline");
	var _unit_width = sc_gui_measure_grid_unit_width();
	return floor((__view_width + _unit_width - 1) / _unit_width);
}

function sc_gui_measure_grid_norm_cal(__view_height)
{
	gml_pragma("forceinline");
	var _unit_height = sc_gui_measure_grid_unit_height();
	return floor((__view_height + _unit_height - 1) / _unit_height);
}

/// @function		sc_gui_node_layer_get_content_width(__type, __layer = 0)
/// @description	Get node someone layer content width from parent.
/// @param          __type {GUI_ENTITY_TYPE}
/// @param          __layer {int} childs.content_height
function sc_gui_node_layer_get_content_width(__type, __layer = 0)
{
	switch (__type) {
	case GUI_ENTITY_TYPE.BLOCK_NO_PB:
		return block_width - (padding_left + padding_right + 2 * border_px);
	case GUI_ENTITY_TYPE.VIEW_NO_PB:
		return view_width - (padding_left + padding_right + 2 * border_px);
	case GUI_ENTITY_TYPE.PB:
		return padding_left + padding_right + 2 * border_px;
	case GUI_ENTITY_TYPE.LTPB:
		return padding_left + border_px;
	case GUI_ENTITY_TYPE.RBPB:
		return padding_right + border_px;
	case GUI_ENTITY_TYPE.CONTENT:
		return content_width;
	case GUI_ENTITY_TYPE.CONTENT_ORG:
		return sc_gui_node_layer_get_content_org_width(__layer);
	case GUI_ENTITY_TYPE.LAYER:
	case GUI_ENTITY_TYPE.LAYER_ORG:
		var _prop = __type == GUI_ENTITY_TYPE.LAYER ? 0 : 2;
		if (is_undefined(content_childs)) {
			return content_width;
		}
		var _width = content_childs[| __layer][_prop];
		if (_width == -1) {
			_width = content_width;
		}
		return _width;
	}
	return 0;
}

/// @function		sc_gui_node_layer_get_content_height(__type, __layer = 0)
/// @description	Get node someone layer content height from parent.
/// @param          __type {GUI_ENTITY_TYPE}
/// @param          __layer {int} childs.content_height
function sc_gui_node_layer_get_content_height(__type, __layer = 0)
{
	gml_pragma("forceinline");
	switch (__type) {
	case GUI_ENTITY_TYPE.BLOCK_NO_PB:
		return block_height - (padding_top + padding_bottom + 2 * border_px);
	case GUI_ENTITY_TYPE.VIEW_NO_PB:
		return view_height -  (padding_top + padding_bottom + 2 * border_px);
	case GUI_ENTITY_TYPE.PB:
		return padding_top + padding_bottom + 2 * border_px;
	case GUI_ENTITY_TYPE.LTPB:
		return padding_top + border_px;
	case GUI_ENTITY_TYPE.RBPB:
		return padding_bottom + border_px;
	case GUI_ENTITY_TYPE.CONTENT:
		return content_height;
	case GUI_ENTITY_TYPE.CONTENT_ORG:
		return sc_gui_node_layer_get_content_org_height(__layer);
	case GUI_ENTITY_TYPE.LAYER:
	case GUI_ENTITY_TYPE.LAYER_ORG:
		var _prop = __type == GUI_ENTITY_TYPE.LAYER ? 1 : 3;
		if (is_undefined(content_childs)) {
			return content_height;
		}
		var _height = content_childs[| __layer][_prop];
		if (_height == -1) {
			_height = content_height;
		}
		return _height;
	}

	return 0;
}

/// @function		sc_gui_node_layer_get_content_org_width(__layer)
/// @description	Get node content origin width from parent or self.
/// @param          __layer {int} childs.content_width
function sc_gui_node_layer_get_content_org_width(__layer)
{
	if (is_undefined(content_childs)) {
		return content_width;
	}
	var n = ds_list_size(content_childs);
	var _size = 0;
	switch (block_direct) {
	case GUI_FLEX_DIRECT.ROW:
	case GUI_FLEX_DIRECT.RROW:
		for (var i = 0; i < n; ++i) {
			_size = max(_size, sc_gui_node_layer_get_content_width(GUI_ENTITY_TYPE.LAYER_ORG, i));
		}
		return _size;
	case GUI_FLEX_DIRECT.COL:
	case GUI_FLEX_DIRECT.RCOL:
		for (var i = 0; i < n; ++i) {
			_size += sc_gui_node_layer_get_content_width(GUI_ENTITY_TYPE.LAYER_ORG, i);
		}
		return _size;
	}
	return content_width;
}

/// @function		sc_gui_node_layer_get_content_org_height(__layer)
/// @description	Get node content origin height from parent or self.
/// @param          __layer {int} childs.content_height
function sc_gui_node_layer_get_content_org_height(__layer)
{
	if (is_undefined(content_childs)) {
		return content_height;
	}
	var n = ds_list_size(content_childs);
	var _size = 0;
	switch (block_direct) {
	case GUI_FLEX_DIRECT.COL:
	case GUI_FLEX_DIRECT.RCOL:
		for (var i = 0; i < n; ++i) {
			_size = max(_size, sc_gui_node_layer_get_content_height(GUI_ENTITY_TYPE.LAYER_ORG, i));
		}
		return _size;
	case GUI_FLEX_DIRECT.ROW:
	case GUI_FLEX_DIRECT.RROW:
		for (var i = 0; i < n; ++i) {
			_size += sc_gui_node_layer_get_content_height(GUI_ENTITY_TYPE.LAYER_ORG, i);
		}
		return _size;
	}
	return content_height;
}

function sc_gui_node_recalc_view_wh_by_scroll()
{
	gml_pragma("forceinline");
	if (max_width) {
		if (max_width < block_width) {
			flag_scroll |= GUI_AXIS_TYPE.HORIZONTAL;
		} else {
			flag_scroll &= ~GUI_AXIS_TYPE.HORIZONTAL;
		}
		view_width = max_width;
	}
	if (max_height) {
		if (max_height < block_height) {
			flag_scroll |= GUI_AXIS_TYPE.VERTICAL;
		} else {
			flag_scroll &= ~GUI_AXIS_TYPE.VERTICAL;
		}
		view_height = max_height;
	}
	switch(flag_scroll) {
	case GUI_AXIS_TYPE.HORIZONTAL:
		view_width = min(view_width, block_width);
		view_height = block_height;
		view_x = min(view_x, block_width - view_width);
		break;
	case GUI_AXIS_TYPE.VERTICAL:
		view_width = block_width;
		view_height = min(view_height, block_height);
		view_y = min(view_y, block_height - view_height);
		break;
	case GUI_AXIS_TYPE.BOTH:
		view_width = min(view_width, block_width);
		view_height = min(view_height, block_height);
		view_x = min(view_x, block_width - view_width);
		view_y = min(view_y, block_height - view_height);
		break;
	case GUI_AXIS_TYPE.NONE:
		view_width = block_width;
		view_height = block_height;
		break;
	}
}

