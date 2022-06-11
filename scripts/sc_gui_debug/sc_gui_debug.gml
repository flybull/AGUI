function sc_gui_debug_draw_hover()
{
	exit;
	
	draw_set_font(Font1);
	draw_text(600, 500, 
		"\nmouse_x:" + string(sc_gui_mouse_x) + 
		"\nmouse_y:" + string(sc_gui_mouse_y));
	var _node = sc_gui_global_node_find(global.gui.hover_node_id);
	if (!is_undefined(_node)) {
		with (_node) {
			draw_set_font(Font1);
			draw_text(600, 600, 
				"point:" + string(cid) + "-" + string(sid) + 
				"\npress:" + string(status_pressed) +
				"\nmouse_x:" + string(hover_x) + ",sc_gui_mouse_y:" + string(hover_y) +
				"\nhold_x:" + string(hold_x) +  ",hold_y:" + string(hold_y) + 
				"\nshift_x:" + string(shift_x) + ",shift_y:" + string(shift_y) +
				"\nlastkey:" + string(keyboard_lastkey) + ",lastchar:" + string(keyboard_lastchar));
				//+	"\nfps:" + string(fps) + ",cpu-step=" + string(fps_real));
			var _point = [relative_pos_x, relative_pos_y];
			var _point0 = sc_gui_node_position(0  ,  0);
			var _point1 = sc_gui_node_position(0.5,  0);
			var _point2 = sc_gui_node_position(1  ,  0);
			var _point3 = sc_gui_node_position(1  ,0.5);
			var _point4 = sc_gui_node_position(1  ,  1);
			var _point5 = sc_gui_node_position(0.5,  1);
			var _point6 = sc_gui_node_position(0  ,  1);
			var _point7 = sc_gui_node_position(0  ,0.5);
			draw_rectangle_color(0, 100 +  30, 40, 100 +  53,c_red    ,c_red    ,c_red    ,c_red    , false);
			draw_rectangle_color(0, 100 +  55, 40, 100 +  75,c_orange ,c_orange ,c_orange ,c_orange , false);
			draw_rectangle_color(0, 100 +  80, 40, 100 + 100,c_yellow ,c_yellow ,c_yellow ,c_yellow , false);
			draw_rectangle_color(0, 100 + 100, 40, 100 + 123,c_green  ,c_green  ,c_green  ,c_green  , false);
			draw_rectangle_color(0, 100 + 123, 40, 100 + 146,c_aqua   ,c_aqua   ,c_aqua   ,c_aqua   , false);
			draw_rectangle_color(0, 100 + 148, 40, 100 + 170,c_blue   ,c_blue   ,c_blue   ,c_blue   , false);
			draw_rectangle_color(0, 100 + 173, 40, 100 + 196,c_teal   ,c_teal   ,c_teal   ,c_teal   , false);
			draw_rectangle_color(0, 100 + 198, 40, 100 + 220,c_purple ,c_purple ,c_purple ,c_purple , false);
			draw_text(0, 100,  
				"relative_pos:"+ string(_point) + 
				"\nc_red    :" + string(_point0)  +
				"\nc_orange :" + string(_point1) +
				"\nc_yellow :" + string(_point2) +
				"\nc_green  :" + string(_point3) +
				"\nc_aqua   :" + string(_point4) +
				"\nc_blue   :" + string(_point5) +
				"\nc_teal   :" + string(_point6) +
				"\nc_purple :" + string(_point7));
		}
	}
}

function sc_gui_debug_draw_rotate()
{
	exit;
	
	if (!status_hover) {
		exit;
	}
	var _point0 = sc_gui_node_position(0  ,  0);
	var _point1 = sc_gui_node_position(0.5,  0);
	var _point2 = sc_gui_node_position(1  ,  0);
	var _point3 = sc_gui_node_position(1  ,0.5);
	var _point4 = sc_gui_node_position(1  ,  1);
	var _point5 = sc_gui_node_position(0.5,  1);
	var _point6 = sc_gui_node_position(0  ,  1);
	var _point7 = sc_gui_node_position(0  ,0.5);
	
	draw_circle_color(_point0[0] - 1, _point0[1] - 1, 3, c_red    , c_red    , false);
	draw_circle_color(_point1[0] - 1, _point1[1] - 1, 3, c_orange , c_orange , false);
	draw_circle_color(_point2[0] - 1, _point2[1] - 1, 3, c_yellow , c_yellow , false);
	draw_circle_color(_point3[0] - 1, _point3[1] - 1, 3, c_green  , c_green  , false);
	draw_circle_color(_point4[0] - 1, _point4[1] - 1, 3, c_aqua   , c_aqua   , false);
	draw_circle_color(_point5[0] - 1, _point5[1] - 1, 3, c_blue   , c_blue   , false);
	draw_circle_color(_point6[0] - 1, _point6[1] - 1, 3, c_teal   , c_teal   , false);
	draw_circle_color(_point7[0] - 1, _point7[1] - 1, 3, c_purple , c_purple , false);
}