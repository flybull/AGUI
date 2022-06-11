/// @function		sc_gui_slider_construct()
/// @description	constructor gui slider config in global
function sc_gui_slider_construct()
{
	gml_pragma("global", "sc_gui_slider_construct()");
	var _classid = GUI_CLASS.SLIDER;
	sc_gui_global_set_class_construct(
		_classid, "slider",
		sc_gui_slider_config_construct,
		sc_gui_slider
	);
	var _classid = GUI_CLASS.SLIDER_CELL;
	sc_gui_global_set_class_construct(
		_classid, "slider_cell",
		sc_gui_slider_cell_config_construct,
		sc_gui_slider_cell
	);
}

/// @function		sc_gui_slider_config_construct()
/// @description	constructor gui slider config in global
function sc_gui_slider_config_construct() {
	var _class = {cid : GUI_CLASS.SLIDER, inherit : GUI_CLASS.DEFAULT };
	sc_gui_config_attr_value_set(_class, {
		//attr_shape : {type : "rect", border_visual : false},
		padding : 0,
		block_direct : GUI_FLEX_DIRECT.NONE,
		slider_asix : GUI_AXIS_TYPE.HORIZONTAL,
		flex_algin : GUI_FLEX_ALIGN.CENTER,
		flag_hover_hole : true,
		func_draw_backward : sc_gui_slider_draw_line,
	});
	
	show_debug_message("[global][sc_gui_slider_config_construct] constructor!");
}

/// @function		sc_gui_slider_cell_config_construct()
/// @description	constructor gui slider_cell config in global
function sc_gui_slider_cell_config_construct()
{
	var _class_cell = {cid : GUI_CLASS.SLIDER_CELL, inherit : GUI_CLASS.DEFAULT };
	sc_gui_config_attr_value_set(_class_cell, {
		attr_shape : {type : "circle", backdrop_color : c_orange},
		w: 8, h: 8,
		margin_type : GUI_VALUE_TYPE.PERCENT,
		anchor_width : 0.5,
		anchor_height : 0.5,
		func_on_press : sc_gui_slider_cell_on_press,
		func_on_hold: sc_gui_slider_cell_on_hold,
	});
	show_debug_message("[global][sc_gui_slider_cell_config_construct] constructor!");
}

/// @function		sc_gui_slider(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui slider node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
function sc_gui_slider(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_node(__attr, function() {
		if (slider_asix == GUI_AXIS_TYPE.HORIZONTAL) {
			sc_gui_slider_cell({margin_top : 0.5});
		} else {
			sc_gui_slider_cell({margin_left : 0.5});
		}
	}, , GUI_CLASS.SLIDER);
}

/// @function		sc_gui_slider_cell(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui slider_cell node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
function sc_gui_slider_cell(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_node(__attr, __func_attach, __func_agrs, GUI_CLASS.SLIDER_CELL);
}

function sc_gui_slider_draw_line()
{
	var _width = sc_gui_node_layer_get_content_width(GUI_ENTITY_TYPE.BLOCK_NO_PB);
	var _height = sc_gui_node_layer_get_content_height(GUI_ENTITY_TYPE.BLOCK_NO_PB);
	var _cell = childs[| 0];
	var _line_wh = floor(min(_cell.view_width, _cell.view_height) / 4);
	switch(slider_asix) {
	case GUI_AXIS_TYPE.HORIZONTAL:
		var _block_x = block_x + padding_left + border_px;
		var _block_y = floor(block_y + padding_top + border_px + _height / 2);
		// -2是因为中心对撑，锚点在中点 1-4,  (1,2,3,4)
		draw_rectangle_colour(_block_x, _block_y - _line_wh,
				max(_block_x, _block_x + _width - 1),
				_block_y + _line_wh  - 1,
				c_gray, c_gray, c_gray, c_gray, false);
		if (_cell.block_x != _block_x) {
			draw_rectangle_colour(_block_x, _block_y - _line_wh,
					_cell.block_x + _line_wh - 1,
					_block_y + _line_wh - 1,
					c_orange, c_orange, c_orange, c_orange, false);
		}
		break;
	case GUI_AXIS_TYPE.VERTICAL:
		var _block_x = floor(block_x + padding_left + border_px + _width / 2);
		var _block_y = block_y + padding_top + border_px;
		draw_rectangle_colour(_block_x - _line_wh, _block_y,
				_block_x + _line_wh - 1,
				max(_block_y, _block_y + _height - 1),
				c_gray, c_gray, c_gray, c_gray, false);
		if (_cell.block_y != _block_y) {
			draw_rectangle_colour(_block_x - _line_wh, _block_y,
					_block_x + _line_wh - 1,
					_cell.block_y + _line_wh - 1,
					c_orange, c_orange, c_orange, c_orange, false);
		}
		break;
	}
}

function sc_gui_slider_cell_on_press()
{
}

function sc_gui_slider_cell_on_hold()
{
	//var _ratio = parent.hover_x / parent.block_width;
	//parent.text = string(_ratio * real(parent.text));
	
	sc_gui_move(hold_x, hold_y, parent.slider_asix);
}
