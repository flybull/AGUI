function sc_gui_eliminate_warn()
{
	if (1) {
		exit;
	}
	sc_gui_api_warn()
	sc_gui_config_construct_warn();
	sc_gui_config_attr_eliminate_warn();
	sc_gui_node_eliminate_warn();
	
}

/// @function:		sc_gui_api_warn() 
/// @description:	Gui node api eliminate warning.
function sc_gui_api_warn()
{
	sc_gui_layout_relative_api();
	sc_gui_node_focus_api();
	sc_gui_node_event_update_api();
}

/// @function:		sc_gui_config_construct_warn() 
/// @description:	Gui config construct eliminate warning.
function sc_gui_config_construct_warn()
{
	sc_gui_config_attr_alias_construct();
	sc_gui_config_attr_parse_construct();
	sc_gui_config_attr_theme_construct();
	sc_gui_config_attr_value_construct();

	sc_gui_node_construct();
	sc_gui_container_construct();
	sc_gui_close_construct();
	sc_gui_hide_construct();
	sc_gui_screen_construct();
	sc_gui_drag_construct();
	sc_gui_scale_construct();
	sc_gui_scrollbar_construct();
	
	sc_gui_shape_rect_construct();
	sc_gui_shape_roundrect_construct();
	sc_gui_shape_sprite_construct();
	sc_gui_shape_circle_construct();
	
	sc_gui_animation_construct();
	sc_gui_animation_prop_construct();
	
	sc_gui_text_construct();
	sc_gui_sprite_construct();
	sc_gui_rect_construct();
	sc_gui_roundrect_construct();
	sc_gui_circle_construct();
	sc_gui_triangle_construct();
	
	sc_gui_line_construct();
	sc_gui_bezier_construct();
	
	sc_gui_checkbox_construct();
	sc_gui_input_construct();
	sc_gui_slider_construct();
	
	sc_gui_selector_construct();
	sc_gui_tree_construct();
	sc_gui_tab_construct();
	sc_gui_window_construct();
	sc_gui_grid_construct();
	sc_gui_goods_construct();
}

/// @function:		sc_gui_config_attr_eliminate_warn() 
/// @description:	Gui config eliminate warning.
function sc_gui_config_attr_eliminate_warn()
{

	#region "ignore warning"
	func_check_hover = undefined;
	func_check_hover_scale = undefined;
	func_check_hover_scroll = undefined;
	func_check_hover_childs = undefined;
	func_check_press = undefined;
	func_check_release = undefined;
	
	func_observe_press = undefined;
	func_observe_release = undefined;
	
	func_on_hover = undefined;
	func_on_away = undefined;
	func_on_focus = undefined;
	func_on_blur = undefined;
	func_on_move = undefined;
	func_on_press = undefined;
	func_on_hold = undefined;
	func_on_release = undefined;
	func_on_move = undefined;
	
	func_on_input = undefined;
	func_on_begin = undefined;
	func_on_end = undefined;
	func_on_ready = undefined;
	func_on_destroy = undefined;
	
	func_on_step = undefined;
	func_on_draw = undefined;
	func_draw_backward = undefined;
	func_draw_forward = undefined;
	func_draw_border = undefined;
	func_draw_background = undefined;
	func_draw_grids = undefined;
	func_draw_childs = undefined;
	show_debug_message(
		typeof(func_check_hover) +
		typeof(func_check_hover_scale) +
		typeof(func_check_hover_scroll) +
		typeof(func_check_hover_childs)+
		typeof(func_check_press) +
		typeof(func_check_release) +
		typeof(func_observe_press) +
		typeof(func_observe_release) +
		typeof(func_on_hover) +
		typeof(func_on_away) +
		typeof(func_on_focus) +
		typeof(func_on_blur) +
		typeof(func_on_press) +
		typeof(func_on_hold) +
		typeof(func_on_release) +
		typeof(func_on_input) +
		typeof(func_on_begin) +
		typeof(func_on_end) +
		typeof(func_on_ready) +
		typeof(func_on_destroy) +
		typeof(func_on_move) +
		typeof(func_on_step) +
		typeof(func_on_draw) +
		typeof(func_draw_backward) + 
		typeof(func_draw_forward) +
		typeof(func_draw_border) +
		typeof(func_draw_background) +
		typeof(func_draw_grids) +
		typeof(func_draw_childs) 
	);
	#endregion
}

/// @function:		sc_gui_node_eliminate_warn() 
/// @description:	Gui config eliminate warning.
function sc_gui_node_eliminate_warn()
{
	show_debug_message(string(___mark));
}