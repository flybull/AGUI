/// @function		sc_gui_node_update_layout()
/// @description	Layout child node and parent relative site.
function sc_gui_node_update_layout()
{
	if (!flag_visable) {
		exit
	}
	var _parent = parent;
	if (status_stub) {
		status_stub = false;
		stub_pos_x = relative_pos_x;
		stub_pos_y = relative_pos_y;
	}
	// Don't change the order.
	if (!is_undefined(_parent)) {
		// this child will recalc when parent's node update
		switch (_parent.block_direct) {
		case GUI_FLEX_DIRECT.ROW:
		case GUI_FLEX_DIRECT.COL:
		case GUI_FLEX_DIRECT.RROW:
		case GUI_FLEX_DIRECT.RCOL:
			relative_pos_x = stub_pos_x;
			relative_pos_y = stub_pos_y;

			// 1. re-calc border + content
			sc_gui_node_border_squeeze();
			// 2. strech.
			sc_gui_node_stretch(_parent.block_direct);
			sc_gui_node_flex_algin_size(_parent.flex_algin);
			sc_gui_node_flex_justify_size(_parent.flex_justify);
			// 3. flex.
			sc_gui_node_flex_direction();
			sc_gui_node_flex_algin();
			sc_gui_node_flex_justify();
			break;
		case GUI_FLEX_DIRECT.NONE:
			relative_pos_x = _parent.padding_left;
			relative_pos_y = _parent.padding_top;

			// 1. re-calc left-right margin
			sc_gui_node_margin_lr();
			// 2. re-calc top-button margin
			sc_gui_node_margin_tb();
			// 3. re-calc border + content
			sc_gui_node_border_squeeze();
			break;
		case GUI_FLEX_DIRECT.GRID:
			relative_pos_x = stub_pos_x;
			relative_pos_y = stub_pos_y;
			sc_gui_node_border_squeeze();
			sc_gui_node_stretch_grid();
			break;
		}
		
		relative_pos_x += shift_x;
		relative_pos_y += shift_y;
		// 4. update x-y coordinates.
		sc_gui_node_update_xy();
	}
	// 未重置的但是也被更新..
	sc_ds_list_foreach(decorate, sc_gui_node_update_decorate_layout);
	
	func[@ GUI_FUNC_TYPE.ON_INIT_READY]();
}


/// @function		sc_gui_node_layout()
/// @description	Layout child node and calc node weight and height.
///                 The parent node direct constraint child node layout
///	@note			calling by with (child) {}
function sc_gui_node_layout()
{
	gml_pragma("forceinline");
	if (!flag_visable) {
		exit;
	}
	if (parent.block_direct != GUI_FLEX_DIRECT.NONE) {
		sc_gui_node_flex_layout();
		sc_gui_node_crlf_layout();
	} else {
		sc_gui_node_none_layout();
	}
}

/// @function		sc_gui_node_border_squeeze()
/// @description	Squeezing node content to adapt to the position.
function sc_gui_node_border_squeeze()
{
	gml_pragma("forceinline");
	if (is_undefined(parent)) {
		exit;
	}
	relative_pos_x += parent.border_px;
	relative_pos_y += parent.border_px;
}

/// @function		sc_gui_node_update_xy()
/// @description	Update node x and y.
function sc_gui_node_update_xy()
{
	gml_pragma("forceinline");

	if (is_undefined(parent)) {
		block_x = relative_pos_x;
		block_y = relative_pos_y;
	} else {
		var _block_x = 0, _block_y = 0;
		var _relative_pos_x = relative_pos_x;
		var _relative_pos_y = relative_pos_y;
		with (parent) {
			if (status_surface) {
				// border在外圈,所以不计算在内 - border
				_block_x = _relative_pos_x - padding_left - border_px;
				_block_y = _relative_pos_y - padding_top - border_px;
			} else {
				_block_x = block_x + _relative_pos_x;
				_block_y = block_y + _relative_pos_y;
			}
		}
		sc_assert_debug(_block_x >= 0 && _block_y >= 0, "node's block_x and block_y < 0");
		block_x = _block_x;// + shift_x;
		block_y = _block_y;// + shift_y;
	}
	func[GUI_FUNC_TYPE.ON_MOVE]();
}

/// @function		sc_gui_node_move_xy()
/// @description	Move node x and y.
function sc_gui_node_move_xy()
{
	gml_pragma("forceinline");
	if (!flag_visable) {
		exit;
	}
	sc_gui_node_update_xy();
	sc_ds_list_foreach(decorate, sc_gui_node_update_xy);
}



