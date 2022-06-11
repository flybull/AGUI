#region "Gui Node decorate"
function sc_gui_node_decorate_layout()
{
	gml_pragma("forceinline");
	if (block_direct != GUI_FLEX_DIRECT.NONE) {
		sc_gui_node_decorate_layout_calc();
	} else {
		sc_gui_node_none_layout();
	}
}

function sc_gui_node_decorate_layout_calc()
{
	gml_pragma("forceinline");
	var _width = domain_width;  // view_width;
	var _height = domain_height;// view_height;

	with (parent) {
		content_width = max(content_width, _width);
		content_height = max(content_height, _height);
	}
}

function sc_gui_node_update_decorate_layout()
{
	// Don't change the order.
	if (is_undefined(parent)) {
		exit;
	}
	
	if (block_direct != GUI_FLEX_DIRECT.NONE) {
		relative_pos_x = parent.padding_left;
		relative_pos_y = parent.padding_top;
	
		// 1. re-calc border + content
		sc_gui_node_border_squeeze();
		// 2. strech.
		sc_gui_node_stretch(block_direct);
		sc_gui_node_flex_algin_size(flex_algin);
		sc_gui_node_flex_justify_size(flex_justify);
		// 3. flex.
		sc_gui_node_decorate_direction();
		sc_gui_node_decorate_algin();
		sc_gui_node_decorate_justify();
	} else {
		relative_pos_x = parent.padding_left;
		relative_pos_y = parent.padding_top;

		// 1. re-calc left-right margin
		sc_gui_node_margin_lr();
		// 2. re-calc top-button margin
		sc_gui_node_margin_tb();
		// 3. re-calc border + content
		sc_gui_node_border_squeeze();
	}

	relative_pos_x += shift_x;
	relative_pos_y += shift_y;
	// 4. update x-y coordinates.
	sc_gui_node_update_xy();
}

function sc_gui_node_decorate_direction()
{
	if (is_undefined(parent)) {
		exit;
	}
	switch (block_direct) {
	case GUI_FLEX_DIRECT.RROW:
		relative_pos_x = parent.block_width - (parent.padding_right/* + parent.border_px*/) - view_width - relative_pos_x;
		break;
	case GUI_FLEX_DIRECT.RCOL:
		relative_pos_y = parent.block_height - (parent.padding_bottom/* + parent.border_px*/) - view_height - relative_pos_y;
		break;
	case GUI_FLEX_DIRECT.ROW:
	case GUI_FLEX_DIRECT.COL:
		// keep
		break;
	}
}

function sc_gui_node_decorate_algin()
{
	if (is_undefined(parent)) {
		exit;
	}
	var _height;
	with (parent) {
		_height = sc_gui_node_layer_get_content_height(GUI_ENTITY_TYPE.BLOCK_NO_PB); // content_height
	}
	
	switch (flex_algin) {
	case GUI_FLEX_ALIGN.START:
		break;
	case GUI_FLEX_ALIGN.CENTER:
		if (block_direct == GUI_FLEX_DIRECT.RCOL) {
			relative_pos_y -= floor((_height - view_height) / 2);
		} else {
			relative_pos_y += floor((_height - view_height) / 2);
		}
		break;
	case GUI_FLEX_ALIGN.END:
		if (block_direct == GUI_FLEX_DIRECT.RCOL) {
			relative_pos_y -= _height - view_height;
		} else {
			relative_pos_y += _height - view_height;
		}
		break;
	}
}

function sc_gui_node_decorate_justify()
{
	if (is_undefined(parent)) {
		exit;
	}
	var _width;
	with (parent) {
		_width = sc_gui_node_layer_get_content_width(GUI_ENTITY_TYPE.BLOCK_NO_PB);  // content_width
	}
	switch (flex_justify) {
	case GUI_FLEX_JUSTIFY.START:
		break;
	case GUI_FLEX_JUSTIFY.CENTER:
		if (block_direct == GUI_FLEX_DIRECT.RROW) {
			relative_pos_x -= floor((_width - view_width) / 2);
		} else {
			relative_pos_x += floor((_width - view_width) / 2);
		}
		break;
	case GUI_FLEX_JUSTIFY.END:
		if (block_direct == GUI_FLEX_DIRECT.RROW) {
			relative_pos_x -= _width - view_width;
		} else {
			relative_pos_x += _width - view_width;
		}
		break;
	}
}
#endregion