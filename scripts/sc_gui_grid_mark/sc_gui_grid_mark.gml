function sc_gui_grid2_create(__spec_row, __spec_col)
{
	gml_pragma("forceinline");
	var _grid_mark = array_create(__spec_row);
	for (var i = 0; i < __spec_row; ++i) {
		_grid_mark[@ i] = array_create(__spec_col, -1);
	}
	return _grid_mark;
}

function sc_gui_grid2_destroy(__grid_mark, __spec_row, __spec_col)
{
	gml_pragma("forceinline");
	if (!is_undefined(__grid_mark)) {
		for (var i = 0; i < __spec_row; ++i) {
			array_delete(__grid_mark[@ i], 0, __spec_col);
		}
		array_delete(__grid_mark, 0, __spec_row);
	}
}

function sc_gui_grid2_mark(__grid_mark, __row_idx, __col_idx, __norm_row, __norm_col, __mark_value)
{
	gml_pragma("forceinline");
	for (var c = 0; c < __norm_col; ++c) {
		for (var r = 0; r < __norm_row; ++r) {
			if (__grid_mark[__row_idx + r][__col_idx + c] != -1) {
				return false;
			}
		}
	}
	sc_assert_debug(!is_undefined(__mark_value));
	for (var c = 0; c < __norm_col; ++c) {
		for (var r = 0; r < __norm_row; ++r) {
			__grid_mark[@ __row_idx + r][@ __col_idx + c] = __mark_value;
		}
	}
	return true;
}

function sc_gui_grid2_unmark(__grid_mark, __row_idx, __col_idx, __norm_row, __norm_col, __mark_value)
{
	gml_pragma("forceinline");
	for (var c = 0; c < __norm_col; ++c) {
		for (var r = 0; r < __norm_row; ++r) {
			sc_assert_debug(__grid_mark[@ __row_idx + r][@ __col_idx + c] == __mark_value);
			__grid_mark[@ __row_idx + r][@ __col_idx + c] = -1;
		}
	}
}

function sc_gui_grid2_unmark_complex(__node)
{
	gml_pragma("forceinline");
	var _parent = __node.parent;
	if (is_undefined(_parent)) {
		exit;
	}
	if (_parent.block_direct != GUI_FLEX_DIRECT.GRID || __node.status_nospace) {
		exit;
	}
	with (_parent) {
		var _norm_row = sc_gui_measure_grid_norm_row(__node.view_width);
		var _norm_col = sc_gui_measure_grid_norm_cal(__node.view_height);
		sc_gui_grid2_unmark(grid_mark, __node.grid_pos_row, __node.grid_pos_col, _norm_row, _norm_col, __node.list_pos);
		__node.grid_pos_row = undefined;
		__node.grid_pos_col = undefined;	
		__node.status_nospace = true;
	}
}

function sc_gui_grid2_mark_find(_parent)
{
	gml_pragma("forceinline");
	if (_parent.block_direct != GUI_FLEX_DIRECT.GRID) {
		return undefined;
	}
	with (_parent) {
		var _relative_pos_x = hover_x - sc_gui_node_layer_get_content_width(GUI_ENTITY_TYPE.LTPB);
		var _relative_pos_y = hover_y - sc_gui_node_layer_get_content_height(GUI_ENTITY_TYPE.LTPB);
		var _unit_width = sc_gui_measure_grid_unit_width();
		var _unit_height = sc_gui_measure_grid_unit_height();

		var _row_idx = floor(_relative_pos_x / (_unit_width + span_w));
		var _col_idx = floor(_relative_pos_y / (_unit_height + span_h));
		if (_row_idx < 0 || _col_idx < 0) {
			return undefined;
		}
		if (_row_idx >= spec_row || _col_idx >= spec_col) {
			return undefined;
		}
		var _list_pos = grid_mark[_row_idx][_col_idx];
		return (_list_pos == -1) ? undefined : _list_pos;
	}
}


