/// @function		sc_gui_node_none_layout()
/// @description	Layout child node and calc node weight and height.
///                 parent node direct constraint child node layout
///	@note			calling by with (child) {}
function sc_gui_node_none_layout()
{
	gml_pragma("forceinline");

	var _width = view_width;
	var _height = view_height;
	var _ml = margin_left;
	var _mr = margin_right;
	var _mt = margin_top;
	var _mb = margin_bottom;
	var _type = margin_type;
	
	with (parent) {
		var _content_width = content_width;
		var _content_height = content_height;

		if (_type == GUI_VALUE_TYPE.PIXEL) {
			_width += _mr >= 1 ? ceil(_mr) : (_ml >= 1 ? ceil(_ml) : 0);
			_height += _mb >= 1 ? ceil(_mb) : (_mt >= 1 ? ceil(_mt) : 0);
		}
		
		// fixme: modify weight and height and margin
		if (_content_width < _width) {
			content_width = _width;
		}
		if (_content_height < _height) {
			content_height = _height;
		}
	}
}

/// @function		sc_gui_node_margin_lr()
/// @description	Re-calc node left-right margin of relative parent's position.
/// @condition      parent.block_direct == GUI_FLEX_DIRECT.NONE
function sc_gui_node_margin_lr()
{
	gml_pragma("forceinline");

	var _parent = parent;
	var _ml = margin_left;
	var _mr = margin_right;

	if (is_undefined(_parent) ||
		(_ml == 0 && _mr == 0)) {
		exit;
	}
	
	var _pl;
	var _bw;
	var _vw = view_width;
	var _rpx;
	var _offset = floor(anchor_width * _vw);
	with (parent) {
		_pl = padding_left;
		_bw = sc_gui_node_layer_get_content_width(GUI_ENTITY_TYPE.BLOCK_NO_PB);
	}
	_rpx = _pl;
	if (margin_type == GUI_VALUE_TYPE.PIXEL) {
		_rpx += _mr >= 1 ? _bw - ceil(_mr) - _offset : 
				(_ml >= 1 ? ceil(_ml) - _offset : -_offset);
	} else {
		_rpx += 0 < _mr && _mr <= 1 ? max(0, ceil(_bw * (1 - _mr)) - _offset) :
				(0 < _ml && _ml <= 1 ? max(0, ceil(_bw * _ml) - _offset) : -_offset);
	}
	// If node out of boundary, then offset into boundary
	relative_pos_x = max(_pl, _rpx + min(0, (_bw + _pl) - (_rpx + _vw))) + shift_x;
}

/// @function		sc_gui_node_margin_tb()
/// @description	Re-calc node top-bottom margin of relative parent's position.
/// @condition      parent.block_direct == GUI_FLEX_DIRECT.NONE
function sc_gui_node_margin_tb()
{
	gml_pragma("forceinline");
	var _parent = parent;
	var _mt = margin_top;
	var _mb = margin_bottom;

	if (is_undefined(_parent) || 
		(_mt == 0 && _mb ==0)) {
		exit;
	}

	var _pt;
	var _bh;
	var _vh = view_height;
	var _rpy;
	var _offset = floor(anchor_height * _vh);
	with (_parent) {
		_pt = padding_top;
		_bh = sc_gui_node_layer_get_content_height(GUI_ENTITY_TYPE.BLOCK_NO_PB);
	}
	_rpy = _pt;
	if (margin_type == GUI_VALUE_TYPE.PIXEL) {
		_rpy += _mb >= 1 ? _bh - ceil(_mb) - _offset : 
				(_mt >= 1 ? ceil(_mt) - _offset : -_offset);		
	} else {
		_rpy += 0 < _mb && _mb <= 1 ? max(0, ceil(_bh * (1 - _mb)) - _offset) :
				(0 < _mt && _mt <= 1 ? max(0, ceil(_bh * _mt) - _offset) : -_offset);
	}
	// If node out of boundary, then offset into boundary
	relative_pos_y = max(_pt, _rpy + min(0, (_bh + _pt) - (_rpy + _vh))) + shift_y;
}
