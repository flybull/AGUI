function sc_gui_node_to_boundary_left()
{
	gml_pragma("forceinline");
	var _parent = parent;
	return is_undefined(_parent) ? relative_pos_x : 
		relative_pos_x - _parent.padding_left - _parent.border_px;
}

function sc_gui_node_to_boundary_right()
{
	gml_pragma("forceinline");
	var _parent = parent;
	var _length = relative_pos_x + view_width;
	return is_undefined(_parent) ? display_get_gui_width() - _length :
		_parent.block_width - _parent.padding_right - _parent.border_px - _length;
}

function sc_gui_node_to_boundary_top()
{
	gml_pragma("forceinline");
	var _parent = parent;
	return is_undefined(_parent) ? relative_pos_y :
		relative_pos_y - _parent.padding_top - _parent.border_px;	
}

function sc_gui_node_to_boundary_bottom()
{
	gml_pragma("forceinline");
	var _parent = parent;
	var _length = relative_pos_y + view_height;
	return is_undefined(_parent) ? display_get_gui_height() - _length : 
		_parent.block_height - _parent.padding_bottom - _parent.border_px - _length;
}

