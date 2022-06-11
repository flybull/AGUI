
#region "Flex Layout"
/// @function		sc_gui_node_flex_layout()
/// @description	Layout child node and calc node weight and height.
///                 parent node direct constraint child node layout
///	@note			calling by with (child) {}
function sc_gui_node_flex_layout()
{
	// Setting child's margin by parent.
	// Code Tip: sc_gui_node_end
	var _parent = parent;
	relative_pos_x = _parent.auxiliary_pos_x;
	relative_pos_y = _parent.auxiliary_pos_y;
	switch (_parent.block_direct) {
	case GUI_FLEX_DIRECT.ROW:
	case GUI_FLEX_DIRECT.RROW:
		sc_gui_node_layout_row_calc();
		break;
	case GUI_FLEX_DIRECT.COL:
	case GUI_FLEX_DIRECT.RCOL:
		sc_gui_node_layout_col_calc();
		break;
	case GUI_FLEX_DIRECT.GRID:
		sc_gui_node_layout_grid_calc();
		break;
	}
}

/// @function		sc_gui_node_layout_row_calc()
/// @description	Calculate Node postion and width
function sc_gui_node_layout_row_calc()
{
	gml_pragma("forceinline");

	var _width = domain_width;//view_width;
	var _height = domain_height;// view_height;
	var _wrap = false;
	with (parent) {
		var _aux_width = auxiliary_width;
		var _aux_height = auxiliary_height + _height;
		var _span_w = span_w;
		
		// [flex-wrap] 
		if (flag_wrap && (_aux_width + _width /*+ _span_w */ > 
			(block_width - padding_right))) {
			_wrap = true;
			break;
		}
		
		// 更新下一容器绘制起始坐标
		auxiliary_pos_x += _width + _span_w; 
		
		// 更新下一父类Content大小
		_aux_width += _width + _span_w;
		if (content_width < _aux_width) {
			content_width = _aux_width;
		}
		auxiliary_width = _aux_width;
		
		if (content_height < _aux_height) {
			content_height = _aux_height;
		}
	}
	if (_wrap && !status_wrap) {
		status_wrap = true;
		sc_gui_node_crlf_layout(true);
		sc_gui_node_layout();
		status_wrap = false;
	}
}

/// @function		sc_gui_node_layout_col_calc()
/// @description	Calculate Node postion and height
function sc_gui_node_layout_col_calc()
{
	gml_pragma("forceinline");

	var _width = domain_width;//view_width;
	var _height = domain_height;// view_height;
	var _wrap = false;
	with (parent) {
		var _aux_width = auxiliary_width + _width;
		var _aux_height = auxiliary_height;
		var _span_h = span_h;
		
		// [flex-wrap] 
		if (flag_wrap && (_aux_height + _height /*+ _span_h */ > 
			(block_height - padding_bottom))) {
			_wrap = true;
			break;
		}
		
		// 更新下一容器绘制起始坐标
		auxiliary_pos_y += _height + _span_h; 

		// 更新Content大小
		if (content_width < _aux_width) {
			content_width = _aux_width;
		}

		_aux_height += _height + _span_h;
		if (content_height < _aux_height) {
			content_height = _aux_height;
		}
		auxiliary_height = _aux_height;
	}
	if (_wrap && !status_wrap) {
		status_wrap = true;
		sc_gui_node_crlf_layout(true);
		sc_gui_node_layout();
		status_wrap = false;
	}
}

/// @function		sc_gui_node_layout_grid_calc()
/// @description	Calculate Node postion and height
function sc_gui_node_layout_grid_calc()
{
	gml_pragma("forceinline");

	var _relative_pos_x = relative_pos_x;
	var _relative_pos_y = relative_pos_y;
	var _width = view_width;
	var _height = view_height;
	var _status_nospace = true;
	var _grid_pos_row = undefined;
	var _grid_pos_col = undefined;
	var _list_pos = list_pos;
	with (parent) {
		var _grid_mark = grid_mark;
		var _spec_row = spec_row;
		var _spec_col = spec_col;
		var _unit_width = sc_gui_measure_grid_unit_width();
		var _unit_height = sc_gui_measure_grid_unit_height();
		var _norm_row = sc_gui_measure_grid_norm_row(_width);
		var _norm_col = sc_gui_measure_grid_norm_cal(_height);
		
		if ((_norm_row == 0 || _norm_row > _spec_row) ||
			(_norm_row == 0 || _norm_col > _spec_col)) {
			break;
		}
		for (var j = 0; j <= _spec_col - _norm_col; ++j) {
			for (var i = 0; i <= _spec_row - _norm_row; ++i) {
				if (sc_gui_grid2_mark(_grid_mark, i, j, _norm_row, _norm_col, _list_pos)) {
					grid_max_rnum = max(grid_max_rnum, _norm_row);
					grid_max_cnum = max(grid_max_cnum, _norm_col);
					_grid_pos_row = i;
					_grid_pos_col = j;
					_relative_pos_x += i * (_unit_width + span_w);
					_relative_pos_y += j * (_unit_height + span_h);
					//i = _spec_row - _norm_row; // break
					j = _spec_col - _norm_col;
					_status_nospace = false;
					break;
				} 
			}
		}
	}
	if (_status_nospace) {
		flag_visable = false;
	}
	status_nospace = _status_nospace;
	relative_pos_x = _relative_pos_x;
	relative_pos_y = _relative_pos_y;
	grid_pos_row = _grid_pos_row;
	grid_pos_col = _grid_pos_col;
}

#endregion

#region "CRLF Layout"
/// @function		sc_gui_node_crlf_layout(__force = false)
/// @description	Layout child node and calc node crlf.
///                 parent node direct constraint child node layout
///	@note			calling by with (child) {}
function sc_gui_node_crlf_layout(__force = false)
{
	var _flag_stretch = flag_stretch;
	if (!is_undefined(parent.content_childs)) {
		content_layer = ds_list_size(parent.content_childs);
	}
	if (!__force && (!flag_crlf && !_flag_stretch)) {
		exit;
	}

	with (parent) {
		if (block_direct == GUI_FLEX_DIRECT.GRID) {
			exit;
		}
		if (_flag_stretch) {
			status_stretch = true;
		}
		if (is_undefined(content_childs)) {
			content_childs = ds_list_create();
		}
		switch (block_direct) {
		case GUI_FLEX_DIRECT.ROW:
		case GUI_FLEX_DIRECT.RROW:
			sc_gui_node_layout_row_crlf(_flag_stretch);
			break;
		case GUI_FLEX_DIRECT.COL:
		case GUI_FLEX_DIRECT.RCOL:
			sc_gui_node_layout_col_crlf(_flag_stretch);
			break;
		}
	}
}

/// @function		sc_gui_node_layout_row_crlf()
/// @description	Layout child node and calc node row crlf.
///                 parent node direct constraint child node layout
/// @param          __flag_stretch {bool} child node's flag_stretch
///	@note			calling by with (parent) {}
function sc_gui_node_layout_row_crlf(__flag_stretch)
{
	gml_pragma("forceinline");
	ds_list_add(content_childs, [
		// This last  add span_w, so sub it.
		// -1: stretch will change width
		__flag_stretch ? -1 : auxiliary_width - span_w, 
		content_height - auxiliary_height,
		// origin size
		auxiliary_width - span_w,
		content_height - auxiliary_height,
	]);

	if (content_width == auxiliary_width) {
		content_width -= span_w;
		sc_assert_debug(content_width >= 0, "content_width < 0");
	}
	auxiliary_max_width = max(auxiliary_max_width, content_width);
	auxiliary_width = 0;
	auxiliary_height = content_height + span_h
	// Code Tip: sc_gui_node_end
	auxiliary_pos_x = padding_left;
	auxiliary_pos_y = content_height + span_h + padding_top;
}

/// @function		sc_gui_node_layout_col_crlf()
/// @description	Layout child node and calc node col crlf.
///                 parent node direct constraint child node layout
/// @param          __flag_stretch {bool} child node's flag_stretch
///	@note			calling by with (parent) {}
function sc_gui_node_layout_col_crlf(__flag_stretch)
{
	gml_pragma("forceinline");
	ds_list_add(content_childs, [
		content_width - auxiliary_width,
		// This last  add span_h, so sub it.
		// -1: stretch will change height
		__flag_stretch ? -1 : auxiliary_height - span_h,
		// origin size
		content_width - auxiliary_width,
		auxiliary_height - span_h
	]);

	if (content_height == auxiliary_height) {
		content_height -= span_h;
	}
	auxiliary_max_height = max(auxiliary_max_height, content_height);
	auxiliary_height = 0;
	auxiliary_width = content_width + span_w;
	// Code Tip: sc_gui_node_end
	auxiliary_pos_x = content_width + span_w + padding_left;
	auxiliary_pos_y = padding_top;
}

/// @function		sc_gui_node_layout_last_crlf()
/// @description	If it is multiple layers, then set the last child's crlf
///                     parent node direct constraint child node layout
/// @note               calling by with (child) {}
function sc_gui_node_layout_last_crlf()
{
	gml_pragma("forceinline");

	var num = ds_list_size(childs);
	if (num == 0) {
		exit;
	}
	var _child = childs[| num - 1];
	if (sc_gui_node_layout_is_crlf(_child)) {
		exit;
	}
	with (_child) {
		sc_gui_node_crlf_layout(true);
	}
}

/// @function		sc_gui_node_layout_is_crlf(__node)
function sc_gui_node_layout_is_crlf(__node)
{
	gml_pragma("forceinline");
	return __node.flag_crlf || __node.flag_stretch;
}
#endregion

#region "Gui Node Flex Align"
/// @function		sc_gui_node_flex_direction()
/// @description	Adjust node flex direction .
function sc_gui_node_flex_direction()
{
	if (is_undefined(parent)) {
		exit;
	}
	switch (parent.block_direct) {
	case GUI_FLEX_DIRECT.RROW:
		relative_pos_x = parent.block_width - (parent.padding_right + parent.border_px) - view_width 
			- (relative_pos_x - parent.padding_left - parent.border_px);
		break;
	case GUI_FLEX_DIRECT.RCOL:
		relative_pos_y = parent.block_height - (parent.padding_bottom + parent.border_px) - view_height
			- (relative_pos_y - parent.padding_top - parent.border_px);
		break;
	case GUI_FLEX_DIRECT.ROW:
	case GUI_FLEX_DIRECT.COL:
		// keep
		break;
	}
}

/// @function		sc_gui_node_flex_algin_size(__flex_algin)
/// @description	Adjust node flex algin for size.(row)
function sc_gui_node_flex_algin_size(__flex_algin)
{	
	gml_pragma("forceinline");
	switch (__flex_algin) {
	case GUI_FLEX_ALIGN.STRETCH:
		if (sc_gui_node_flex_algin_stretch_check()) {
			sc_gui_node_stretch_height();
		}
		break;
	}
}
/// @function		sc_gui_node_flex_algin()
/// @description	Adjust node flex algin.(column)
function sc_gui_node_flex_algin()
{
	if (is_undefined(parent)) {
		exit;
	}
	switch (parent.flex_algin) {
	case GUI_FLEX_ALIGN.START:
		// keep;
		break;
	case GUI_FLEX_ALIGN.CENTER:
		sc_gui_node_flex_algin_center_block(GUI_ENTITY_TYPE.BLOCK_NO_PB, GUI_ENTITY_TYPE.CONTENT);
		sc_gui_node_flex_algin_center_content();
		break;
	case GUI_FLEX_ALIGN.END:
		sc_gui_node_flex_algin_end_block(GUI_ENTITY_TYPE.BLOCK_NO_PB, GUI_ENTITY_TYPE.CONTENT);
		sc_gui_node_flex_algin_end_content();
		break;
	}
}

/// @function		sc_gui_node_flex_algin_center_block(__block_type, __content_type, __content_layer = 0)
/// @description	Adjust node flex algin-center block parent and childs.(column)
function sc_gui_node_flex_algin_center_block(__block_type, __content_type, __content_layer = 0)
{
	gml_pragma("forceinline");
	var _relative_pos_y = 0;
	with (parent) {
		var _bheight = sc_gui_node_layer_get_content_height(__block_type);
		var _cheight = sc_gui_node_layer_get_content_height(__content_type, __content_layer);
		if (_bheight == _cheight) {
			exit;
		}
		sc_assert_debug(_bheight > _cheight, "[sc_gui_node_flex_algin_center_block]");
		if (block_direct == GUI_FLEX_DIRECT.RCOL) {
			_relative_pos_y -= floor((_bheight - _cheight) / 2);
		} else {
			_relative_pos_y += floor((_bheight - _cheight) / 2);
		}
	}
	relative_pos_y += _relative_pos_y;
}

/// @function		sc_gui_node_flex_algin_center_content()
/// @description	Adjust node flex algin-center content parent and childs.(column)
function sc_gui_node_flex_algin_center_content()
{
	gml_pragma("forceinline");
	var _relative_pos_y = 0;
	var _view_height = view_height;
	var _content_layer = content_layer;

	switch (parent.block_direct) {
	case GUI_FLEX_DIRECT.COL:
	case GUI_FLEX_DIRECT.RCOL:
		// parent.block & parent.content => parent.content & parent.layer.content 	
		sc_assert_debug(!is_undefined(parent.content_childs), "[sc_gui_node_flex_algin_center_content]");
		sc_gui_node_flex_algin_center_block(GUI_ENTITY_TYPE.CONTENT, GUI_ENTITY_TYPE.LAYER, _content_layer);
		break;
	case GUI_FLEX_DIRECT.ROW:
	case GUI_FLEX_DIRECT.RROW:
		with (parent) {
			var _height = sc_gui_node_layer_get_content_height(GUI_ENTITY_TYPE.LAYER, _content_layer);
			if (_height == _view_height) {
				exit;
			}
			sc_assert_debug(_height > _view_height, "[sc_gui_node_flex_algin_center_content]");
			if (block_direct == GUI_FLEX_DIRECT.RCOL) {
				_relative_pos_y -= floor((_height - _view_height) / 2);
			} else {
				_relative_pos_y += floor((_height - _view_height) / 2);
			}
			break;
		}
	}

	relative_pos_y += _relative_pos_y;
}

/// @function		sc_gui_node_flex_algin_end_block(__block_type, __content_type, __content_type = 0)
/// @description	Adjust node flex algin-end block parent and childs.(column)
function sc_gui_node_flex_algin_end_block(__block_type, __content_type, __content_layer = 0)
{
	gml_pragma("forceinline");
	var _relative_pos_y = 0;
	with (parent) {
		var _bheight = sc_gui_node_layer_get_content_height(__block_type);
		var _cheight = sc_gui_node_layer_get_content_height(__content_type, __content_layer);
		if (_bheight == _cheight) {
			exit;
		}
		sc_assert_debug(_bheight > _cheight, "[sc_gui_node_flex_algin_end_block]");
		if (block_direct == GUI_FLEX_DIRECT.RCOL) {
			_relative_pos_y -= _bheight - _cheight;
		} else {
			_relative_pos_y += _bheight - _cheight;
		}
	}

	relative_pos_y += _relative_pos_y;
}

/// @function		sc_gui_node_flex_algin_end_content()
/// @description	Adjust node flex algin-end content parent and childs.(column)
function sc_gui_node_flex_algin_end_content()
{
	gml_pragma("forceinline");
	var _relative_pos_y = 0;
	var _view_height = view_height;
	var _content_layer = content_layer;

	switch (parent.block_direct) {
	case GUI_FLEX_DIRECT.COL:
	case GUI_FLEX_DIRECT.RCOL:
		// parent.block & parent.content => parent.content & parent.layer.content 	
		sc_assert_debug(!is_undefined(parent.content_childs), "[sc_gui_node_flex_algin_end_content]");
		sc_gui_node_flex_algin_end_block(GUI_ENTITY_TYPE.CONTENT, GUI_ENTITY_TYPE.LAYER, _content_layer);
		break;
	case GUI_FLEX_DIRECT.ROW:
	case GUI_FLEX_DIRECT.RROW:
		with (parent) {
			var _height = sc_gui_node_layer_get_content_height(GUI_ENTITY_TYPE.LAYER, _content_layer);
			if (_height == _view_height) {
				exit;
			}
			sc_assert_debug(_height > _view_height, "[sc_gui_node_flex_algin_end_content]");
			if (block_direct == GUI_FLEX_DIRECT.RCOL) {
				_relative_pos_y -= _height - _view_height;
			} else {
				_relative_pos_y += _height - _view_height;
			}
		}
		break;
	}

	relative_pos_y += _relative_pos_y;
}

/// @function		sc_gui_node_flex_algin_stretch_check()
/// @description	Check node can flex algin-stretch content height size.(column)
function sc_gui_node_flex_algin_stretch_check()
{
	gml_pragma("forceinline");
	if (rotate != 0) {
		return false;
	}
	switch (parent.block_direct) {
	case GUI_FLEX_DIRECT.NONE:
		return true;
	case GUI_FLEX_DIRECT.COL:
	case GUI_FLEX_DIRECT.RCOL:
		var _childs = parent.childs;
		if (flag_crlf) {
			return true;
		}
		var _childs = parent.childs;
		var _n = ds_list_size(_childs) - 1;
		if (_n >= 0 && self == _childs[| _n]) {
			return true;
		}
		return false;
	case GUI_FLEX_DIRECT.ROW:
	case GUI_FLEX_DIRECT.RROW:
		return is_undefined(content_childs) || content_layer == (ds_list_size(parent.content_childs) - 1);
	}
	return false;
}

#endregion

#region "Gui Node Flex Justify"
/// @function		sc_gui_node_flex_justify_size(__flex_justify)
/// @description	Adjust node flex justify for size.(row)
function sc_gui_node_flex_justify_size(__flex_justify)
{
	gml_pragma("forceinline");
	switch (__flex_justify) {	
	case GUI_FLEX_JUSTIFY.STRETCH:
		if (sc_gui_node_flex_justify_stretch_check()) {
			sc_gui_node_stretch_width();
		}
		break;
	}
}

/// @function		sc_gui_node_flex_justify()
/// @description	Adjust node flex justify.(row)
function sc_gui_node_flex_justify()
{
	if (is_undefined(parent)) {
		exit;
	}
	switch (parent.flex_justify) {
	case GUI_FLEX_JUSTIFY.START:
		// keep;
		break;
	case GUI_FLEX_JUSTIFY.CENTER:
		sc_gui_node_flex_justify_center_block(GUI_ENTITY_TYPE.BLOCK_NO_PB, GUI_ENTITY_TYPE.CONTENT);
		sc_gui_node_flex_justify_center_content();
		break;
	case GUI_FLEX_JUSTIFY.END:
		sc_gui_node_flex_justify_end_block(GUI_ENTITY_TYPE.BLOCK_NO_PB, GUI_ENTITY_TYPE.CONTENT);
		sc_gui_node_flex_justify_end_content();
		break;
	}
}

/// @function		sc_gui_node_flex_justify_center_block(__block_type, __content_type, __content_layer = 0)
/// @description	Adjust node flex justify-center block parent and childs.(row)
function sc_gui_node_flex_justify_center_block(__block_type, __content_type, __content_layer = 0)
{
	gml_pragma("forceinline");
	var _relative_pos_x = 0;
	with (parent) {
		var _bwidth = sc_gui_node_layer_get_content_width(__block_type);
		var _cwidth = sc_gui_node_layer_get_content_width(__content_type, __content_layer);
		if (_bwidth == _cwidth) {
			exit;
		}
		sc_assert_debug(_bwidth > _cwidth, "[sc_gui_node_flex_justify_center_block]");
		if (block_direct == GUI_FLEX_DIRECT.RROW) {
			_relative_pos_x -= floor((_bwidth - _cwidth) / 2);
		} else {
			_relative_pos_x += floor((_bwidth - _cwidth) / 2);
		}
	}
	relative_pos_x += _relative_pos_x;
}

/// @function		sc_gui_node_flex_justify_center_content()
/// @description	Adjust node flex justify-center content parent and childs.(row)
function sc_gui_node_flex_justify_center_content()
{
	gml_pragma("forceinline");
	var _relative_pos_x = 0;
	var _view_width = view_width;
	var _content_layer = content_layer;

	switch (parent.block_direct) {
	case GUI_FLEX_DIRECT.ROW:
	case GUI_FLEX_DIRECT.RROW:
		// parent.block & parent.content => parent.content & parent.layer.content 	
		sc_assert_debug(!is_undefined(parent.content_childs), "[sc_gui_node_flex_justify_center_content]");
		sc_gui_node_flex_justify_center_block(GUI_ENTITY_TYPE.CONTENT, GUI_ENTITY_TYPE.LAYER, _content_layer);
		break;
	case GUI_FLEX_DIRECT.COL:
	case GUI_FLEX_DIRECT.RCOL:
		with (parent) {
			var _width = sc_gui_node_layer_get_content_width(GUI_ENTITY_TYPE.LAYER, _content_layer);
			if (_width == _view_width) {
				exit;
			}
			sc_assert_debug(_width > _view_width, "sc_gui_node_flex_justify_center_content");
			if (block_direct == GUI_FLEX_DIRECT.RROW) {
				_relative_pos_x -= floor((_width - _view_width) / 2);
			} else {
				_relative_pos_x += floor((_width - _view_width) / 2);
			}
		}
		break;
	}
	relative_pos_x += _relative_pos_x;
}

/// @function		sc_gui_node_flex_justify_end_block(__block_type, __content_type, __content_layer = 0)
/// @description	Adjust node flex justify-end block parent and childs.(row)
function sc_gui_node_flex_justify_end_block(__block_type, __content_type, __content_layer = 0)
{
	gml_pragma("forceinline");
	var _relative_pos_x = 0;
	with (parent) {
		var _bwidth = sc_gui_node_layer_get_content_width(__block_type);
		var _cwidth = sc_gui_node_layer_get_content_width(__content_type, __content_layer);

		if (_bwidth == _cwidth) {
			exit;
		}
		sc_assert_debug(_bwidth > _cwidth, "[sc_gui_node_flex_justify_end_block]");
		if (block_direct == GUI_FLEX_DIRECT.RROW) {
			_relative_pos_x -= _bwidth - _cwidth;
		} else {
			_relative_pos_x += _bwidth - _cwidth;
		}
	}
	relative_pos_x += _relative_pos_x;
}

/// @function		sc_gui_node_flex_justify_end_content()
/// @description	Adjust node flex justify-end content parent and childs.(row)
function sc_gui_node_flex_justify_end_content()
{
	gml_pragma("forceinline");
	var _relative_pos_x = 0;
	var _view_width = view_width;
	var _content_layer = content_layer;

	switch (parent.block_direct) {
	case GUI_FLEX_DIRECT.ROW:
	case GUI_FLEX_DIRECT.RROW:
		// parent.block & parent.content => parent.content & parent.layer.content 	
		sc_assert_debug(!is_undefined(parent.content_childs), "[sc_gui_node_flex_justify_end_content]");
		sc_gui_node_flex_justify_end_block(GUI_ENTITY_TYPE.CONTENT, GUI_ENTITY_TYPE.LAYER, _content_layer);
		break;
	case GUI_FLEX_DIRECT.COL:
	case GUI_FLEX_DIRECT.RCOL:
		with (parent) {
			var _width = sc_gui_node_layer_get_content_width(GUI_ENTITY_TYPE.LAYER, _content_layer);
			if (_width == _view_width) {
				exit;
			}
			sc_assert_debug(_width > _view_width, "[sc_gui_node_flex_justify_end_content]");
			if (block_direct == GUI_FLEX_DIRECT.RROW) {
				_relative_pos_x -= _width - _view_width;
			} else {
				_relative_pos_x += _width - _view_width;
			}
		}
	}
	relative_pos_x += _relative_pos_x;
}

/// @function		sc_gui_node_flex_justify_stretch_check()
/// @description	Check node can flex algin-stretch content width size.(row)
function sc_gui_node_flex_justify_stretch_check()
{
	gml_pragma("forceinline");

	if (rotate != 0) {
		return false;
	}
	switch (parent.block_direct) {
	case GUI_FLEX_DIRECT.NONE:
		return true;
	case GUI_FLEX_DIRECT.ROW:
	case GUI_FLEX_DIRECT.RROW:
		if (flag_crlf) {
			return true;
		}
		var _childs = parent.childs;
		var _n = ds_list_size(_childs) - 1;
		if (_n >= 0 && self == _childs[| _n]) {
			return true;
		}
		return false;
	case GUI_FLEX_DIRECT.COL:
	case GUI_FLEX_DIRECT.RCOL:
		return is_undefined(content_childs) ||  content_layer == (ds_list_size(parent.content_childs) - 1);
	}
	return false;
}
#endregion