/// @function		sc_gui_node_draw()
/// @description	Draw Gui node.
/// @note			gpu_set_blendmode_ext( bm_one , bm_zero )
///					gpu_set_blendenable(false);
///					gpu_set_blendmode(bm_normal);
///					gpu_set_blendenable(true);
function sc_gui_node_draw()
{
	gml_pragma("forceinline");
	if (!flag_visable) {
		exit;
	}
	// 1. update status bits for dynmic draw
	sc_gui_node_status_combine();
	
	if (!is_undefined(attr_animation)) {
		sc_gui_node_draw_animate_wrap(sc_gui_node_draw_template);
		exit;
	}
	if (status_transition) {
		sc_gui_node_draw_transition_wrap(sc_gui_node_draw_template);
		exit;
	}
	sc_gui_node_draw_template();
	sc_gui_debug_draw_rotate();
}

/// @function		sc_gui_node_draw_template()
/// @description	Draw Gui node draw template.
function sc_gui_node_draw_template()
{
	gml_pragma("forceinline");
	sc_gui_node_draw_begin();
	sc_gui_node_draw_do();
	sc_gui_node_draw_end();
}

/// @function		sc_gui_node_surface_build(__function)
/// @description	Draw Gui node build surface for draw.
function sc_gui_node_surface_build(__surface, __width, __height)
{
	gml_pragma("forceinline");
	if (is_undefined(__surface) || !surface_exists(__surface)) {
		var _power_w = ceil(log2(__width));
		var _power_h = ceil(log2(__height));
		var _block_width = power(2, _power_w);
		var _block_height = power(2, _power_h);
		
		if (_block_width < __width) {
			_block_width = power(2, _power_w + 1); 
		}
		if (_block_height < __height) {
			_block_height = power(2, _power_h + 1); 
		}
		__surface = surface_create(_block_width, _block_height);
		origin.status_draw = true;
	}
	surface_set_target(__surface);
	if (status_draw) {
		draw_clear_alpha(c_black, 0); // 1
	}
	return __surface;
}

/// @function		sc_gui_node_draw_animate_wrap(__function)
/// @description	Draw Gui node draw animate wrap.
function sc_gui_node_draw_animate_wrap(__function)
{
	gml_pragma("forceinline");

		
	var _view_prev_id = surface_get_target();
	if (_view_prev_id != -1) {
		surface_reset_target();
	}
	view_surface_wrap = sc_gui_node_surface_build(view_surface_wrap, view_width, view_height);

	// [sc_gui_node_begin] 
	// status_surface must be true.
	// so just modify node's block_x and block_y 
	var _block_x = block_x;
	var _block_y = block_y;
	block_x = 0;
	block_y = 0;

	sc_base_safe_call(__function);

	block_x = _block_x;
	block_y = _block_y;
	origin.status_draw = true;
	
	surface_reset_target();
	if (_view_prev_id != -1) {
		surface_set_target(_view_prev_id);
	}

	//draw_surface_general();
	attr_animation.draw(view_surface_wrap, status_bits, block_x, block_y,
		view_width, view_height, scale_x, scale_y, rotate, c_white, alpha);
	sc_gui_debug_draw_rotate();
}

/// @function		sc_gui_node_draw_transition_wrap(__function)
/// @description	Draw Gui node draw transition wrap.
function sc_gui_node_draw_transition_wrap(__function)
{
	gml_pragma("forceinline");
	var _view_prev_id = surface_get_target();
	if (_view_prev_id != -1) {
		surface_reset_target();
	}
	view_surface_wrap = sc_gui_node_surface_build(view_surface_wrap, view_width, view_height);

	// [sc_gui_node_begin] 
	// status_surface must be true.
	// so just modify node's block_x and block_y 
	var _block_x = block_x;
	var _block_y = block_y;
	block_x = 0;
	block_y = 0;
	
	sc_base_safe_call(__function);

	block_x = _block_x;
	block_y = _block_y;
	origin.status_draw = true;
	
	surface_reset_target();
	if (_view_prev_id != -1) {
		surface_set_target(_view_prev_id);
	}

	draw_surface_general(view_surface_wrap, 0, 0,
		view_width, view_height, block_x, block_y,
		scale_x, scale_y, rotate,
		c_white, c_white, c_white, c_white,
		alpha
	);
	sc_gui_debug_draw_rotate();
}

/// @function		sc_gui_node_draw_begin()
/// @description	Draw Gui node draw begin.
function sc_gui_node_draw_begin()
{
	gml_pragma("forceinline");

	if (!status_surface) {
		exit;
	}
	
	view_prev_id = surface_get_target();
	if (view_prev_id != -1) {
		surface_reset_target();
	}
	view_surface = sc_gui_node_surface_build(view_surface, block_width, block_height);
}

/// @function		sc_gui_node_draw_do()
/// @description	Draw Gui node draw self.
function sc_gui_node_draw_do()
{
	gml_pragma("forceinline");

	var _status_draw = status_draw;
	if (!status_surface) {
		func[GUI_FUNC_TYPE.DRAW_BACKGROUND]();
		func[GUI_FUNC_TYPE.DRAW_GRIDS]();
		func[GUI_FUNC_TYPE.DRAW_BACKWARD]();
	}
	// because child's node maybe need to update.(animate)
	// so setting this status_draw before childs draw.
	if (is_undefined(parent)) {
		status_draw = false;
	}
	if (_status_draw) {
		// if haven't surface then need to draw child's node (status_draw)
		func[GUI_FUNC_TYPE.DRAW_DECORATE]();
		func[GUI_FUNC_TYPE.DRAW_CHILDS]();
	}
}

/// @function		sc_gui_node_draw_end()
/// @description	Draw Gui node draw end.
function sc_gui_node_draw_end()
{
	gml_pragma("forceinline");
	if (status_surface) {
		// NOTE: If you have not previously set a render target with the function surface_set_target(),
		// using this function will silently (ie: without any error messages) end all further code execution for the event.
		surface_reset_target();
		if (view_prev_id != -1) {
			surface_set_target(view_prev_id);
			view_prev_id = -1;
		}

		func[GUI_FUNC_TYPE.DRAW_BACKGROUND]();
		func[GUI_FUNC_TYPE.DRAW_GRIDS]();
		func[GUI_FUNC_TYPE.DRAW_BACKWARD]();

		// [sc_gui_node_update_xy] see
		// only draw content range
		draw_surface_part(view_surface, view_x, view_y,
			max(0, view_width - padding_left - padding_right - 2 * border_px),
			max(0, view_height - padding_top - padding_bottom - 2 * border_px), 
			block_x + padding_left + border_px,
			block_y + padding_top + border_px);
	}
	func[GUI_FUNC_TYPE.DRAW_FORWARD]();
	func[GUI_FUNC_TYPE.DRAW_BORDER]();
	if (!is_undefined(scrollbar)) {
		with(scrollbar) {
			func[GUI_FUNC_TYPE.ON_DRAW]();
		}
	}
}

/// @function		sc_gui_node_draw_border()
/// @description	Draw Gui node border.
function sc_gui_node_draw_border()
{
	gml_pragma("forceinline");
	if (is_undefined(shape)) {
		exit;
	}
	var _block_x = block_x;
	var _block_y = block_y;
	shape.draw_border(_block_x, _block_y, 
		_block_x + view_width, 
		_block_y + view_height,
		status_bits);
}

/// @function		sc_gui_node_draw_backgroud()
/// @description	Draw Gui node backgroud.
function sc_gui_node_draw_backgroud()
{
	gml_pragma("forceinline");
	if (is_undefined(shape)) {
		exit;
	}
	var _block_x = block_x;
	var _block_y = block_y;
	shape.draw_backdrop(_block_x, _block_y, 
		_block_x + view_width, 
		_block_y + view_height,
		status_bits);
}

/// @function		sc_gui_node_draw_gridding()
/// @description	Draw Gui node gridding.
function sc_gui_node_draw_gridding()
{
	gml_pragma("forceinline");
	if (block_direct != GUI_FLEX_DIRECT.GRID) {
		exit;
	}
	var _span_w = span_w;
	var _span_h = span_h;
	var _span_wa = _span_w * (spec_row - 1);
	var _span_ha = _span_h * (spec_col - 1);
	var _width = sc_gui_measure_grid_unit_width();
	var _height = sc_gui_measure_grid_unit_height();
	var _ltw = sc_gui_node_layer_get_content_width(GUI_ENTITY_TYPE.LTPB);
	var _lth = sc_gui_node_layer_get_content_height(GUI_ENTITY_TYPE.LTPB);
	var _vwidth = sc_gui_node_layer_get_content_width(GUI_ENTITY_TYPE.VIEW_NO_PB);
	var _vheight = sc_gui_node_layer_get_content_height(GUI_ENTITY_TYPE.VIEW_NO_PB);

	// max_col_num + 1
	var _grid_max_rnum = _span_w * grid_max_rnum + 1;
	var _grid_max_cnum = _span_h * grid_max_cnum + 1;
	var _block_y = block_y + _lth - _grid_max_cnum;
	for (var _block_x = block_x + _ltw - floor(_grid_max_rnum / 2); _block_x <= block_x + _vwidth + _ltw + _span_wa; _block_x += _width + _span_w) {
		draw_line_width_colour(_block_x, _block_y, 
			_block_x, 
			_block_y + _vheight + _span_h + _grid_max_cnum,
			_grid_max_rnum, c_blue, c_blue);
	}
	var _block_x = block_x + _ltw - _grid_max_rnum;
	for (var _block_y = block_y + _lth - floor(_grid_max_cnum / 2); _block_y <= block_y + _vheight + _lth + _span_ha; _block_y += _height + _span_h) {
		draw_line_width_colour(_block_x, _block_y,
			_block_x + _vwidth + _span_w + _grid_max_rnum,
			_block_y,
			_grid_max_cnum, c_blue, c_blue);
	}	
	
	//for (var i = padding_left + border_px; i <= view_width - padding_right - border_px; i += _width) {
	//	draw_line_color(block_x + i, block_y + padding_top + border_px, block_x + i, block_y + view_height - padding_bottom - border_px, c_blue, c_blue);
	//}
	//for (var i = padding_top + border_px; i <= view_height - padding_bottom - border_px; i += _height) {
	//	draw_line_color(block_x + padding_left + border_px, block_y + i, block_x + view_width - padding_right - border_px, block_y + i, c_blue, c_blue);
	//}	
}

/// @function		sc_gui_node_draw_decorate()
/// @description	Draw Gui node decorate.
function sc_gui_node_draw_decorate()
{
	gml_pragma("forceinline");
	sc_ds_list_foreach(decorate, function() {
		func[GUI_FUNC_TYPE.ON_DRAW]();
	});
}

/// @function		sc_gui_node_draw_childs()
/// @description	Draw Gui node draw childs.
function sc_gui_node_draw_childs()
{
	gml_pragma("forceinline");
	// There were only a focus and a press/hold node at the layer at most.
	// Maybe I could use stack to defer draw.
	var _defer_focus_node = undefined;
	var _defer_press_node = undefined;
	var n = ds_list_size(childs);
	for (var i = 0; i < n; ++i) {
		with(childs[| i]) {
			if (status_focus) {
				sc_assert_debug(is_undefined(_defer_focus_node), "only one focus node");
				_defer_focus_node = self;
				break;
			}
			if (status_pressed) {
				sc_assert_debug(is_undefined(_defer_press_node), "only one press node");
				_defer_press_node = self;
				break;
			}
			func[GUI_FUNC_TYPE.ON_DRAW]();
		}
	}
	if (!is_undefined(_defer_focus_node)) {
		with(_defer_focus_node) {
			func[GUI_FUNC_TYPE.ON_DRAW]();
		}
	}
	if (!is_undefined(_defer_press_node)) {
		with(_defer_press_node) {
			func[GUI_FUNC_TYPE.ON_DRAW]();
		}
	}
}



