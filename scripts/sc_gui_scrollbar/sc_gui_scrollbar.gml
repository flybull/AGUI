

/// @function		sc_gui_scrollbar_construct()
/// @description	constructor gui scrollbar config in global
function sc_gui_scrollbar_construct()
{
	gml_pragma("global", "sc_gui_scrollbar_construct()");
	var _classid = GUI_CLASS.SCROLLBAR;
	sc_gui_global_set_class_construct(
		_classid, "scrollbar",
		sc_gui_scrollbar_config_construct,
		sc_gui_scrollbar
	);
}

/// @function		sc_gui_scrollbar_config_construct()
/// @description	constructor gui scrollbar config in global
function sc_gui_scrollbar_config_construct()
{
	var _class = {cid : GUI_CLASS.SCROLLBAR, inherit : GUI_CLASS.DEFAULT};
	sc_gui_config_set_attr_value(_class, {
		direct : GUI_FLEX_DIRECT.NONE,
		attr_shape : undefined,
		scrollbar_px : 6,
		scrollbar_axis : GUI_AXIS_TYPE.NONE,
		func_check_hover : sc_gui_scrollbar_check_hover,
		func_on_press : sc_gui_scrollbar_on_press,
		func_on_hold : sc_gui_scrollbar_on_hold,
		func_on_draw : sc_gui_scrollbar_on_draw,
	});
	show_debug_message("[global][sc_gui_scrollbar_config_construct] constructor!");	
}

/// @function		sc_gui_scrollbar(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui scrollbar node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
function sc_gui_scrollbar(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_orphan(__attr, __func_attach, __func_agrs, GUI_CLASS.SCROLLBAR);
} 

/// @function		sc_gui_scrollbar_check_hover()
/// @description	container_check_hover must ture.
function sc_gui_scrollbar_check_hover()
{
	var _parent = parent;
	var _axis = GUI_AXIS_TYPE.NONE;
	var _bar_px = scrollbar_px;
	
	if (_bar_px == 0) {
		return false;
	}

	with (_parent) {
		var _border_px = 2 * border_px;
		var _view_width = view_width;
		var _view_height = view_height;
		var _viewbox_width = _view_width - _border_px - 1;
		var _viewbox_height = _view_height - _border_px - 1;
		var _flag_horizontal = _view_width < block_width;
		var _flag_vertical = _view_height < block_height;
		var _mouse_x = hover_x - view_x;
		var _mouse_y = hover_y - view_y;

		if (_flag_horizontal) {
			if (point_in_rectangle(_mouse_x, _mouse_y, 
					0,  _viewbox_height - _bar_px, 
					_viewbox_width, _viewbox_height)) {
				_axis = GUI_AXIS_TYPE.HORIZONTAL;
				break;
			}
		}
		if (_flag_vertical) {
			if (point_in_rectangle(_mouse_x, _mouse_y, 
				_viewbox_width - _bar_px, 0,
				_viewbox_width,  _viewbox_height)) {
				_axis = GUI_AXIS_TYPE.VERTICAL;
				break;
			}
		}
	}
	scrollbar_axis = _axis;
	return _axis == GUI_AXIS_TYPE.NONE ? false : true;
}

/// @function		sc_gui_scrollbar_on_press()
function sc_gui_scrollbar_on_press()
{
	var _parent = parent;
	var _axis = scrollbar_axis;
	var _bar_px = scrollbar_px;

	hover_x = sc_gui_mouse_x;
	hover_y = sc_gui_mouse_y;
	with (_parent) {
		var _block_width = block_width, _block_height = block_height;
		var _view_width = view_width, _view_height = view_height;
		var _viewbox_width = _view_width - 2 * border_px - 1;
		var _viewbox_height = _view_height - 2 * border_px - 1;
		var _mouse_x = hover_x - view_x;
		var _mouse_y = hover_y - view_y;
		var _remain = (_view_width < _block_width && _view_height < _block_height) ? _bar_px : 0;

		switch (_axis) {
		case GUI_AXIS_TYPE.HORIZONTAL:
			var _button_size = floor(((_view_width - _remain) / _block_width) * (_view_width - _remain));
			var _button_x = floor((view_x / _block_width) * (_view_width - _remain));
			var _view_x = (_mouse_x / _viewbox_width) * _block_width;
			if (_button_x > _mouse_x) {
				view_x = max(0, _view_x);
			} else if (_mouse_x > _button_x + _button_size) {
				view_x = min(_block_width - _view_width, _view_x);
			}
			break;
		case GUI_AXIS_TYPE.VERTICAL:
			var _button_size = floor(((_view_height - _remain) / _block_height) * (_view_height - _remain));
			var _button_y = floor((view_y / _block_height) * (_view_height - _remain));
			var _view_y = (_mouse_y / _viewbox_height) * _block_height;
			if (_button_y > _mouse_y) {
				view_y = max(0, _view_y);
			} else if (_mouse_y > _button_y + _button_size) {
				view_y = min(_block_height - _view_height, _view_y);
			}	
			break;
		case GUI_AXIS_TYPE.NONE:
			break;
		}
	}
}

/// @function		sc_gui_scrollbar_on_hold()
function sc_gui_scrollbar_on_hold()
{
	var _parent = parent;
	var _axis = scrollbar_axis;
	var _bar_px = scrollbar_px;
	var _last_x = hover_x;
	var _last_y = hover_y;

	hover_x = sc_gui_mouse_x;
	hover_y = sc_gui_mouse_y;

	with (_parent) {
		var _block_width = block_width, _block_height = block_height;
		var _view_width = view_width, _view_height = view_height;
		var _view_x = view_x, _view_y = view_y;

		var _remain = (_view_width < _block_width && _view_height < _block_height) ? _bar_px : 0;
		
		switch (_axis) {
		case GUI_AXIS_TYPE.HORIZONTAL:
			var _button_size = floor(((_view_width - _remain) / _block_width) * (_view_width - _remain));
			var _distance_x = point_distance(_last_x, 0, sc_gui_mouse_x, 0);
			_distance_x = _distance_x / (_view_width / _block_width);
			if (_last_x > sc_gui_mouse_x) {
				view_x = _view_x > _distance_x ? _view_x - _distance_x : 0;
			} else if (_last_x < sc_gui_mouse_x) {
				if (_view_x + _distance_x >= _block_width - _view_width) {
					view_x = _block_width - _view_width;
				} else {
					view_x = _view_x + _distance_x;
				}
			}
			break;
		case GUI_AXIS_TYPE.VERTICAL:
			var _button_size = floor(((_view_height - _remain) / _block_height) * (_view_height - _remain));
			var _distance_y = point_distance(0, _last_y, 0, sc_gui_mouse_y);
			_distance_y = _distance_y / (_view_height / _block_height);
			if (_last_y > sc_gui_mouse_y) {
				view_y = _view_y > _distance_y ? _view_y - _distance_y : 0;
			} else if (_last_y < sc_gui_mouse_y) {
				if (_view_y + _distance_y >= _block_height - _view_height) {
					view_y = _block_height - _view_height;
				} else {
					view_y = _view_y + _distance_y;
				}
			}
			break;
		case GUI_AXIS_TYPE.NONE:
			break;
		}
	}
}

function sc_gui_scrollbar_select_axis() {
	if (flag_scroll == GUI_AXIS_TYPE.BOTH) {
		return keyboard_check(vk_shift) ? GUI_AXIS_TYPE.HORIZONTAL : GUI_AXIS_TYPE.VERTICAL;
	}
	return flag_scroll;
}
/// @function		sc_gui_scrollbar_on_wheel_up()
function sc_gui_scrollbar_on_wheel_up()
{
	var _axis = sc_gui_scrollbar_select_axis();
	switch (_axis) {
	case GUI_AXIS_TYPE.HORIZONTAL:
		view_x = view_x > 8 ? view_x - 8 : 0;
		break;
	case GUI_AXIS_TYPE.VERTICAL:
		view_y = view_y > 8 ? view_y - 8 : 0;
		break;
	}
}

/// @function		sc_gui_scrollbar_on_wheel_down()
function sc_gui_scrollbar_on_wheel_down()
{
	var _axis = sc_gui_scrollbar_select_axis();
	switch (_axis) {
	case GUI_AXIS_TYPE.HORIZONTAL:
		if (view_x + 8 >= block_width - view_width) {
			view_x = block_width - view_width;
		} else {
			view_x = view_x + 8;
		}
		break;
	case GUI_AXIS_TYPE.VERTICAL:
		if (view_y + 8 >= block_height - view_height) {
			view_y = block_height - view_height;
		} else {
			view_y = view_y + 8;
		}
		break;
	}
}

/// @function		sc_gui_scrollbar_on_draw()
/// @description	Gui draw scrollbar
function sc_gui_scrollbar_on_draw()
{
	var _parent = parent;
	if (is_undefined(_parent)) {
		exit;
	}
	if (_parent.flag_scroll == GUI_AXIS_TYPE.NONE ||
		flag_visable == false || scrollbar_px == 0 ||
		(!_parent.status_hover && !status_hover)) {
		exit;
	}
	var _bar_px = scrollbar_px;

	with (_parent) {
		var _block_width = block_width, _block_height = block_height;
		var _view_width = view_width, _view_height = view_height;
		var _viewbox_width = _view_width - 2 * border_px - 1;
		var _viewbox_height = _view_height - 2 * border_px - 1;
		var _flag_horizontal = _view_width < _block_width;
		var _flag_vertical = _view_height < _block_height;
		var _block_x = block_x + 1;
		var _block_y = block_y + 1;
		var _remain = (_view_width < _block_width && _view_height < _block_height) ? _bar_px : 0;
	
		// horizontal
		if (_flag_horizontal && _viewbox_width >= 6) {
			var _button_size = floor(((_view_width - _remain) / _block_width) * (_view_width - _remain));
			var _button_x = floor((view_x / _block_width) * (_view_width - _remain));
			var _status_bits = sc_gui_node_status_combine();
			var _bgcolor = sc_gui_config_attr_theme_get_by_stat(self, GUI_THEME_TYPE.SCROLLBAR_BG, _status_bits);
			var _btcolor = sc_gui_config_attr_theme_get_by_stat(self, GUI_THEME_TYPE.SCROLLBAR_BT, _status_bits);
			var _brcolor = sc_gui_config_attr_theme_get_by_stat(self, GUI_THEME_TYPE.SCROLLBAR_BR, _status_bits);
	
			// backgroud
			draw_rectangle_color(
				_block_x,
				_block_y + _viewbox_height - _bar_px,
				_block_x + _viewbox_width - _remain,
				_block_y + _viewbox_height,
				_bgcolor, _bgcolor, _bgcolor, _bgcolor, false);
			// button
			draw_rectangle_color(
				_block_x + _button_x + 1,
				_block_y + _viewbox_height - _bar_px + 1,
				min(_block_x + _viewbox_width, _block_x + _button_x +  _button_size - 1),
				_block_y + _viewbox_height - 1,
				_btcolor, _btcolor, _btcolor, _btcolor, false);
			
			// border
			draw_rectangle_color(
				_block_x + 1,
				_block_y + _viewbox_height - _bar_px + 1,
				_block_x + _viewbox_width - _remain - 1 ,
				_block_y + _viewbox_height - 1,
				_brcolor, _brcolor, _brcolor, _brcolor, true);
		}
	
		//// vertical
		if (_flag_vertical && _viewbox_height >= 6) {
			var _button_size = floor(((_view_height - _remain) / _block_height) * (_view_height - _remain));
			var _button_y = floor((view_y / _block_height) * (_view_height - _remain));
			var _status_bits = sc_gui_node_status_combine();
			var _bgcolor = sc_gui_config_attr_theme_get_by_stat(self, GUI_THEME_TYPE.SCROLLBAR_BG, _status_bits);
			var _btcolor = sc_gui_config_attr_theme_get_by_stat(self, GUI_THEME_TYPE.SCROLLBAR_BT, _status_bits);
			var _brcolor = sc_gui_config_attr_theme_get_by_stat(self, GUI_THEME_TYPE.SCROLLBAR_BR, _status_bits);

			// backgroud
			draw_rectangle_color(
				_block_x + _viewbox_width - _bar_px,
				_block_y,
				_block_x + _viewbox_width,
				_block_y +  _viewbox_height - _remain,
				_bgcolor, _bgcolor, _bgcolor, _bgcolor, false);
			// button
			draw_rectangle_color(
				_block_x + _viewbox_width - _bar_px + 1 ,
				_block_y + _button_y + 1 ,
				_block_x + _viewbox_width - 1,
				min(_block_y + _viewbox_height, _block_y + _button_y + _button_size - 1),
				_btcolor, _btcolor, _btcolor, _btcolor, false);
			// border
			draw_rectangle_color(
				_block_x + _viewbox_width - _bar_px + 1 ,
				_block_y + 1 ,
				_block_x + _viewbox_width - 1,
				_block_y +  _viewbox_height - _remain - 1,
				_brcolor, _brcolor, _brcolor, _brcolor, true);
		}
	}
}
