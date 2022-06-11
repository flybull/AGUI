function sc_gui_move(__hold_x, __hold_y, __asix = GUI_AXIS_TYPE.BOTH)
{
	gml_pragma("forceinline");

	if (is_undefined(parent)) {
		sc_gui_move_in_layer(__hold_x, __hold_y, __asix);
		exit;
	}
	switch (parent.block_direct) {
	case GUI_FLEX_DIRECT.ROW:
	case GUI_FLEX_DIRECT.RROW:
	case GUI_FLEX_DIRECT.COL:
	case GUI_FLEX_DIRECT.RCOL:
		sc_gui_move_in_flex(__hold_x, __hold_y, __asix);
		break;
	case GUI_FLEX_DIRECT.GRID:
		sc_gui_move_in_grid(__hold_x, __hold_y, __asix);
		break;
	case GUI_FLEX_DIRECT.NONE:
		sc_gui_move_in_layer(__hold_x, __hold_y, __asix);
		break;
	}
}

function sc_gui_move_by_relative(__pos_x, __pos_y)
{
	gml_pragma("forceinline");
	relative_pos_x = __pos_x;
	relative_pos_y = __pos_y;
	sc_ds_list_foreach_before("childs", sc_gui_node_move_xy);
}

function sc_gui_move_in_layer(__hold_x, __hold_y, __asix)
{
	gml_pragma("forceinline");
	if (__asix == GUI_AXIS_TYPE.NONE) {
		exit;
	}
	sc_gui_move_by_relative(
		sc_gui_move_pos_get_x(__hold_x, __asix),
		sc_gui_move_pos_get_y(__hold_y, __asix)
	);
}

function sc_gui_move_in_flex(__hold_x, __hold_y, __asix)
{
	if (__asix == GUI_AXIS_TYPE.NONE) {
		exit;
	}
	var _relative_pos_x = sc_gui_move_pos_get_x(0, __asix);
	var _relative_pos_y = sc_gui_move_pos_get_y(0, __asix);
	var _self = self;
	var _scan_layer = 0;
	var _find = false;
	var _width = 0;
	var _height = 0;
	with (parent) {
		var _layer = ds_list_size(content_childs);
		var n = ds_list_size(childs);
		var _block_direct = block_direct;
		var _tmp = undefined;
		for (_scan_layer = 0; _scan_layer < _layer; ++_scan_layer) {
			_width += sc_gui_node_layer_get_content_width(GUI_ENTITY_TYPE.LAYER, _scan_layer);
			_height += sc_gui_node_layer_get_content_height(GUI_ENTITY_TYPE.LAYER, _scan_layer);
			if (point_in_rectangle(_relative_pos_x, _relative_pos_y, 0, 0, _width, _height)) {
				break;
			}
		}
		if (_scan_layer == _layer) {
			break;
		}
		
		for (var i = 0; i < n && !_find; ++i) {
			var _node = childs[| i];
			if (_scan_layer > _node.content_layer) {
				continue;
			} else if (_scan_layer < _node.content_layer) {
				break;
			}
			switch (_block_direct) {
			case GUI_FLEX_DIRECT.ROW:
				if (_relative_pos_x <= _node.relative_pos_x + _node.view_width) {
					_find = true;
				}
				break;
			case GUI_FLEX_DIRECT.RROW:
				if (_relative_pos_x >= _node.relative_pos_x) {
					_find = true;
				}
				break;
			case GUI_FLEX_DIRECT.COL:
				if (_relative_pos_y <= _node.relative_pos_y + _node.view_height) {
					_find = true;
				}
				break;
			case GUI_FLEX_DIRECT.RCOL:
				if (_relative_pos_y >= _node.relative_pos_y) {
					_find = true;
					
				}
				break;
			}
			_tmp = _node;
		}
		if (is_undefined(_tmp)) {
			break;
		}
		if (_find = false && sc_gui_node_layout_is_crlf(_tmp)) {
			break;
		}
		if (_tmp.sid == _self.sid) {
			break;
		}
		sc_gui_node_event_insert_by_obj(self, _self, _tmp.list_pos);
		exit;
	}
	//sc_gui_move_in_layer(__hold_x, __hold_y);
}

function sc_gui_move_in_grid(__hold_x, __hold_y, __asix)
{
	if (__asix == GUI_AXIS_TYPE.NONE) {
		exit;
	}
	var _relative_pos_x = sc_gui_move_pos_get_x(__hold_x, __asix);
	var _relative_pos_y = sc_gui_move_pos_get_y(__hold_y, __asix);
	var _width = view_width;
	var _height = view_height;
	var _pos_row = grid_pos_row;
	var _pos_col = grid_pos_col;
	var _list_pos = list_pos;
	var _self = self;
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
		var _lbw = sc_gui_node_layer_get_content_width(GUI_ENTITY_TYPE.LTPB);
		var _lbh = sc_gui_node_layer_get_content_height(GUI_ENTITY_TYPE.LTPB);	
		_relative_pos_x -= _lbw;
		_relative_pos_y -= _lbh;
		
		var _row_idx = floor(_relative_pos_x / (_unit_width + span_w));
		var _col_idx = floor(_relative_pos_y / (_unit_height + span_h));
		if (_row_idx >= _spec_row || _col_idx >= _spec_col) {
			break;
		}
		if (_row_idx == _pos_row && _col_idx == _pos_col) {
			break;
		}
		sc_gui_grid2_unmark(_grid_mark, _pos_row, _pos_col, _norm_row, _norm_col, _list_pos);
		if (sc_gui_grid2_mark(_grid_mark, _row_idx, _col_idx, _norm_row, _norm_col, _list_pos)) {
			var _relative_pos_x = _lbw + _row_idx * (_unit_width + span_w);
			var _relative_pos_y = _lbw +  _col_idx * (_unit_height + span_h);
			with (_self) {
				status_nospace = false;
				grid_pos_row = _row_idx;
				grid_pos_col = _col_idx;
				sc_gui_move_by_relative(_relative_pos_x, _relative_pos_y);
			}
		} else {
			sc_gui_grid2_mark(_grid_mark, _pos_row, _pos_col, _norm_row, _norm_col, _list_pos);
		}
	}
}

function sc_gui_move_pos_get_x(__hold_x, __asix)
{
	gml_pragma("forceinline");
	switch (__asix) {
	case GUI_AXIS_TYPE.BOTH:
	case GUI_AXIS_TYPE.HORIZONTAL:
		return sc_gui_move_pos_calc_x(__hold_x);
	case GUI_AXIS_TYPE.VERTICAL:
	default:
		return relative_pos_x;
	}
}

function sc_gui_move_pos_get_y(__hold_y, __asix)
{
	gml_pragma("forceinline");
	switch (__asix) {
	case GUI_AXIS_TYPE.BOTH:
	case GUI_AXIS_TYPE.VERTICAL:
		return sc_gui_move_pos_calc_y(__hold_y);
	case GUI_AXIS_TYPE.HORIZONTAL:
	default:
		return relative_pos_y;
	}
}

function sc_gui_move_pos_calc_x(__hold_x)
{
	gml_pragma("forceinline");
	var _block_width;
	var _mlt_width;
	if (is_undefined(parent)) {
		_block_width = display_get_gui_width();
		_mlt_width = 0;
	} else {
		with (parent) {
			_block_width = sc_gui_node_layer_get_content_width(GUI_ENTITY_TYPE.BLOCK_NO_PB) +
						sc_gui_node_layer_get_content_width(GUI_ENTITY_TYPE.RBPB);
			_mlt_width = sc_gui_node_layer_get_content_width(GUI_ENTITY_TYPE.LTPB);
		}
	}
	var _view_width = view_width;
	var _pos_x = sc_gui_node_on_layer_x(__hold_x);
	_pos_x = max(_mlt_width, _pos_x);
	return min(_pos_x, _block_width - _view_width);;
}

function sc_gui_move_pos_calc_y(__hold_y)
{
	gml_pragma("forceinline");
	var _block_height;
	var _mlt_height;
	if (is_undefined(parent)) {
		_block_height = display_get_gui_height();
		_mlt_height = 0;
	} else {
		with (parent) {
			_block_height = sc_gui_node_layer_get_content_height(GUI_ENTITY_TYPE.BLOCK_NO_PB) +
						sc_gui_node_layer_get_content_height(GUI_ENTITY_TYPE.RBPB);
			_mlt_height = sc_gui_node_layer_get_content_height(GUI_ENTITY_TYPE.LTPB);
		}
	}
	var _view_height = view_height;
	var _pos_y = sc_gui_node_on_layer_y(__hold_y);
	_pos_y = max(_mlt_height, _pos_y);
	return min(_pos_y, _block_height - _view_height);
}
