function sc_gui_layout_relative_api()
{
	sc_gui_layout_relative_screen_lt();
	sc_gui_layout_relative_loto(self);
	sc_gui_layout_relative_lito(self);
	sc_gui_layout_relative_loti(self);
	sc_gui_layout_relative_liti(self);
	sc_gui_layout_relative_lobo(self);
	sc_gui_layout_relative_libo(self);
	sc_gui_layout_relative_lobi(self);
	sc_gui_layout_relative_libi(self);
	
	sc_gui_layout_relative_roto(self);
	sc_gui_layout_relative_rito(self);
	sc_gui_layout_relative_roti(self);
	sc_gui_layout_relative_riti(self);
	sc_gui_layout_relative_robo(self);
	sc_gui_layout_relative_ribo(self);
	sc_gui_layout_relative_robi(self);
	sc_gui_layout_relative_ribi(self);
	
	sc_gui_layout_relative_width(self);
	sc_gui_layout_relative_height(self);
}

function sc_gui_layout_relative_moving(__res_x, __res_y)
{
	gml_pragma("forceinline");
	relative_pos_x = __res_x;
	relative_pos_y = __res_y;
	sc_gui_node_move_xy();
}

function sc_gui_layout_relative_screen_lt(__offset_x = 0, __offset_y = 0)
{
	gml_pragma("forceinline");
	relative_pos_x = __offset_x;
	relative_pos_y = __offset_y;
	sc_gui_node_move_xy();
}

function sc_gui_layout_relative_loto(__dst_node, __offset_x = 0, __offset_y = 0)
{
	gml_pragma("forceinline");
	var _screen;
	var _shift;
	with (__dst_node) {
		_screen = sc_gui_node_relative_screen();
		_shift = sc_gui_node_position_shift_rotate(_screen[2], 0, 0);
	}
	sc_gui_layout_relative_moving(
		sc_gui_measure_relative_left_outside(__dst_node, _screen, _shift, __offset_x),
		sc_gui_measure_relative_top_outside(__dst_node, _screen, _shift, __offset_y)
	);
}

function sc_gui_layout_relative_lito(__dst_node, __offset_x = 0, __offset_y = 0)
{
	gml_pragma("forceinline");
	var _screen;
	var _shift;
	with (__dst_node) {
		_screen = sc_gui_node_relative_screen();
		_shift = sc_gui_node_position_shift_rotate(_screen[2], 0, 0);
	}

	sc_gui_layout_relative_moving(
		sc_gui_measure_relative_left_inside(__dst_node, _screen, _shift, __offset_x),
		sc_gui_measure_relative_top_outside(__dst_node, _screen, _shift, __offset_y)
	);
}

function sc_gui_layout_relative_loti(__dst_node, __offset_x = 0, __offset_y = 0)
{
	gml_pragma("forceinline");
	var _screen;
	var _shift;
	with (__dst_node) {
		_screen = sc_gui_node_relative_screen();
		_shift = sc_gui_node_position_shift_rotate(_screen[2], 0, 0);
	}
	sc_gui_layout_relative_moving(
		sc_gui_measure_relative_left_outside(__dst_node, _screen, _shift, __offset_x),
		sc_gui_measure_relative_top_inside(__dst_node, _screen, _shift, __offset_y)
	);
}
function sc_gui_layout_relative_liti(__dst_node, __offset_x = 0, __offset_y = 0)
{
	gml_pragma("forceinline");
	var _screen;
	var _shift;
	with (__dst_node) {
		_screen = sc_gui_node_relative_screen();
		_shift = sc_gui_node_position_shift_rotate(_screen[2], 0, 0);
	}
	sc_gui_layout_relative_moving(
		sc_gui_measure_relative_left_inside(__dst_node, _screen, _shift, __offset_x),
		sc_gui_measure_relative_top_inside(__dst_node, _screen, _shift, __offset_y)
	);
}

function sc_gui_layout_relative_lobo(__dst_node, __offset_x = 0, __offset_y = 0)
{
	gml_pragma("forceinline");
	var _screen;
	var _shift;
	with (__dst_node) {
		_screen = sc_gui_node_relative_screen();
		_shift = sc_gui_node_position_shift_rotate(_screen[2], 0, 1);
	}
	sc_gui_layout_relative_moving(
		sc_gui_measure_relative_left_outside(__dst_node, _screen, _shift, __offset_x),
		sc_gui_measure_relative_bottom_outside(__dst_node, _screen, _shift, __offset_y)
	);
}

function sc_gui_layout_relative_libo(__dst_node, __offset_x = 0, __offset_y = 0)
{
	gml_pragma("forceinline");
	var _screen;
	var _shift;
	with (__dst_node) {
		_screen = sc_gui_node_relative_screen();
		_shift = sc_gui_node_position_shift_rotate(_screen[2], 0, 1);
	}
	sc_gui_layout_relative_moving(
		sc_gui_measure_relative_left_inside(__dst_node, _screen, _shift, __offset_x),
		sc_gui_measure_relative_bottom_outside(__dst_node, _screen, _shift, __offset_y)
	);
}

function sc_gui_layout_relative_lobi(__dst_node, __offset_x = 0, __offset_y = 0)
{
	gml_pragma("forceinline");
	var _screen;
	var _shift;
	with (__dst_node) {
		_screen = sc_gui_node_relative_screen();
		_shift = sc_gui_node_position_shift_rotate(_screen[2], 0, 1);
	}
	sc_gui_layout_relative_moving(
		sc_gui_measure_relative_left_outside(__dst_node, _screen, _shift, __offset_x),
		sc_gui_measure_relative_bottom_inside(__dst_node, _screen, _shift, __offset_y)
	);
}

function sc_gui_layout_relative_libi(__dst_node, __offset_x = 0, __offset_y = 0)
{
	gml_pragma("forceinline");
	var _screen;
	var _shift;
	with (__dst_node) {
		_screen = sc_gui_node_relative_screen();
		_shift = sc_gui_node_position_shift_rotate(_screen[2], 0, 1);
	}
	sc_gui_layout_relative_moving(
		sc_gui_measure_relative_left_inside(__dst_node, _screen, _shift, __offset_x),
		sc_gui_measure_relative_bottom_inside(__dst_node, _screen, _shift, __offset_y),
	);
}


function sc_gui_layout_relative_roto(__dst_node, __offset_x = 0, __offset_y = 0)
{
	gml_pragma("forceinline");
	var _screen;
	var _shift;
	with (__dst_node) {
		_screen = sc_gui_node_relative_screen();
		_shift = sc_gui_node_position_shift_rotate(_screen[2], 1, 0);
	}
	sc_gui_layout_relative_moving(
		sc_gui_measure_relative_right_outside(__dst_node, _screen, _shift, __offset_x),
		sc_gui_measure_relative_top_outside(__dst_node, _screen, _shift, __offset_y)
	);
}

function sc_gui_layout_relative_rito(__dst_node, __offset_x = 0, __offset_y = 0)
{
	gml_pragma("forceinline");
	var _screen;
	var _shift;
	with (__dst_node) {
		_screen = sc_gui_node_relative_screen();
		_shift = sc_gui_node_position_shift_rotate(_screen[2], 1, 0);
	}
	sc_gui_layout_relative_moving(
		sc_gui_measure_relative_right_inside(__dst_node, _screen, _shift, __offset_x),
		sc_gui_measure_relative_top_outside(__dst_node, _screen, _shift, __offset_y)
	);
}

function sc_gui_layout_relative_roti(__dst_node, __offset_x = 0, __offset_y = 0)
{
	gml_pragma("forceinline");
	var _screen;
	var _shift;
	with (__dst_node) {
		_screen = sc_gui_node_relative_screen();
		_shift = sc_gui_node_position_shift_rotate(_screen[2], 1, 0);
	}
	sc_gui_layout_relative_moving(
		sc_gui_measure_relative_right_outside(__dst_node, _screen, _shift, __offset_x),
		sc_gui_measure_relative_top_inside(__dst_node, _screen, _shift, __offset_y)
	);
}

function sc_gui_layout_relative_riti(__dst_node, __offset_x = 0, __offset_y = 0)
{
	gml_pragma("forceinline");
	var _screen;
	var _shift;
	with (__dst_node) {
		_screen = sc_gui_node_relative_screen();
		_shift = sc_gui_node_position_shift_rotate(_screen[2], 1, 0);
	}
	sc_gui_layout_relative_moving(
		sc_gui_measure_relative_right_inside(__dst_node, _screen, _shift, __offset_x),
		sc_gui_measure_relative_top_inside(__dst_node, _screen, _shift, __offset_y)
	);
}


function sc_gui_layout_relative_robo(__dst_node, __offset_x = 0, __offset_y = 0)
{
	gml_pragma("forceinline");
	var _screen;
	var _shift;
	with (__dst_node) {
		_screen = sc_gui_node_relative_screen();
		_shift = sc_gui_node_position_shift_rotate(_screen[2], 1, 1);
	}
	sc_gui_layout_relative_moving(
		sc_gui_measure_relative_right_outside(__dst_node, _screen, _shift, __offset_x),
		sc_gui_measure_relative_bottom_outside(__dst_node, _screen, _shift, __offset_y)
	);
}

function sc_gui_layout_relative_ribo(__dst_node, __offset_x = 0, __offset_y = 0)
{
	gml_pragma("forceinline");
	var _screen;
	var _shift;
	with (__dst_node) {
		_screen = sc_gui_node_relative_screen();
		_shift = sc_gui_node_position_shift_rotate(_screen[2], 1, 1);
	}
	sc_gui_layout_relative_moving(
		sc_gui_measure_relative_right_inside(__dst_node, _screen, _shift, __offset_x),
		sc_gui_measure_relative_bottom_outside(__dst_node, _screen, _shift, __offset_y)
	);
}

function sc_gui_layout_relative_robi(__dst_node, __offset_x = 0, __offset_y = 0)
{
	gml_pragma("forceinline");
	var _screen;
	var _shift;
	with (__dst_node) {
		_screen = sc_gui_node_relative_screen();
		_shift = sc_gui_node_position_shift_rotate(_screen[2], 1, 1);
	}
	sc_gui_layout_relative_moving(
		sc_gui_measure_relative_right_outside(__dst_node, _screen, _shift, __offset_x),
		sc_gui_measure_relative_bottom_inside(__dst_node, _screen, _shift, __offset_y)
	);
}

function sc_gui_layout_relative_ribi(__dst_node, __offset_x = 0, __offset_y = 0)
{
	gml_pragma("forceinline");
	var _screen;
	var _shift;
	with (__dst_node) {
		_screen = sc_gui_node_relative_screen();
		_shift = sc_gui_node_position_shift_rotate(_screen[2], 1, 1);
	}
	sc_gui_layout_relative_moving(
		sc_gui_measure_relative_right_inside(__dst_node, _screen, _shift, __offset_x),
		sc_gui_measure_relative_bottom_inside(__dst_node, _screen, _shift, __offset_y)
	);
}

function sc_gui_layout_relative_width(__dst_node = undefined, __expand_size = 0)
{
	var _view_width;
	var _width;
	var _padding_left;
	var _padding_right;
	if (is_undefined(__dst_node)) {
		_view_width = max(0, display_get_gui_width() - __expand_size);
		_width = max(0, _view_width - sc_gui_node_layer_get_content_width(GUI_ENTITY_TYPE.PB));
		_padding_left = padding_left;
		_padding_right = padding_right;
	} else {
		with (__dst_node) {
			_view_width = max(0, view_width - __expand_size);
			_width = max(0, sc_gui_node_layer_get_content_width(GUI_ENTITY_TYPE.VIEW_NO_PB) - __expand_size);
			_padding_left = padding_left;
			_padding_right = padding_right;
		}
	}
	if ((padding_left != _padding_left) || 
		(padding_right != _padding_right)) {
		sc_ds_list_foreach(childs, function() {
			status_stub = true;
		});
	}
	if (_view_width != view_width || __expand_size) {
		// border need calc ? (no see o_node_selector)
		sc_gui_node_event_update_by_args({
			w : _width, 
			padding_left : _padding_left, 
			padding_right: _padding_right
		});
	}
}

function sc_gui_layout_relative_height(__dst_node = undefined, __expand_size = 0)
{
	var _view_height;
	var _height;
	var _padding_top = 0;
	var _padding_bottom = 0;
	if (is_undefined(__dst_node)) {
		_view_height = max(0, display_get_gui_height() - __expand_size);
		_height = max(0, _view_height - sc_gui_node_layer_get_content_height(GUI_ENTITY_TYPE.PB));
		_padding_top = padding_top;
		_padding_bottom = padding_bottom;
	} else {
		with (__dst_node) {
			_view_height = max(0, view_height - __expand_size);
			_height = max(0, sc_gui_node_layer_get_content_height(GUI_ENTITY_TYPE.VIEW_NO_PB) - __expand_size);
			_padding_top = padding_top;
			_padding_bottom = padding_bottom;
		}
	}
	if ((padding_top != _padding_top) || 
		(padding_bottom != _padding_bottom)) {
		sc_ds_list_foreach(childs, function() {
			status_stub = true;
		});
	}
	if (_view_height != view_height || __expand_size) {
		// border need calc ? (no see o_node_selector)
		sc_gui_node_event_update_by_args({
			h : _height, 
			padding_top : _padding_top, 
			padding_bottom: _padding_bottom
		});
	}
}

function sc_gui_layout_relative_inner_width(__dst_node, __expand_size = 0)
{
	gml_pragma("forceinline");
	if (is_undefined(__dst_node)) {
		sc_gui_layout_relative_width(__dst_node, __expand_size);
	} else {
		sc_gui_layout_relative_width(__dst_node, __dst_node.border_px * 2 + __expand_size);
	}
}

function sc_gui_layout_relative_inner_height(__dst_node, __expand_size = 0)
{
	gml_pragma("forceinline");
	if (is_undefined(__dst_node)) {
		sc_gui_layout_relative_height(__dst_node, __expand_size);
	} else {
		sc_gui_layout_relative_height(__dst_node, __dst_node.border_px * 2 + __expand_size);
	}
}
