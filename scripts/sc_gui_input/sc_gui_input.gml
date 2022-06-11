/// @function		sc_gui_input_construct()
/// @description	constructor gui input config in global
function sc_gui_input_construct()
{
	gml_pragma("global", "sc_gui_input_construct()");
	var _classid = GUI_CLASS.INPUTBOX;
	sc_gui_global_set_class_construct(
		_classid, "input",
		sc_gui_input_config_construct,
		sc_gui_input
	);
}

/// @function		sc_gui_input_config_construct()
/// @description	constructor gui input text config in global
function sc_gui_input_config_construct() {
	var _class = {cid : GUI_CLASS.INPUTBOX, inherit : GUI_CLASS.DEFAULT};
	sc_gui_config_set_attr_value(_class, {
		input_cursor_frame : 0,
		input_cursor_blink : false,
		input_string_limit : 8,
		w : 256,
		h : 32,
		flag_scroll : GUI_AXIS_TYPE.HORIZONTAL,
		attr_scroll : {func_on_draw : sc_base_empty_call},
		func_on_press : sc_gui_input_on_press,
		func_on_blur : sc_gui_input_on_blur,
		func_on_input : sc_gui_input_on_input,
		func_draw_backward : sc_gui_input_draw_cursor,
	});
	show_debug_message("[global][sc_gui_text_config_construct] constructor!");
}

/// @function		sc_gui_textbox(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui textbox node.
/// @param          __attr  {struct} init property
/// @param:			__func_attach {funtion} call method between init and init_end
/// @param:         __func_agrs  {Realm}  The  arguments(struct\array\...)
function sc_gui_input(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_node(__attr, function() {
		sc_gui_text({str:""});
	}, __func_agrs, GUI_CLASS.INPUTBOX);
}


function sc_gui_input_on_press()
{
	if (!status_focus) {
		var _text = sc_gui_node_uri_router("/childs/cid/" + string(GUI_CLASS.TEXT));
		keyboard_string = _text.text_str;
		//scrollbar.flag_visable = false;
		sc_gui_node_insert_focus();
	}
}

function sc_gui_input_on_blur() {
	keyboard_string = "";
}

function sc_gui_input_on_input()
{
	var _text = sc_gui_node_uri_router("/childs/cid/" + string(GUI_CLASS.TEXT));
	if (_text.text_str != keyboard_string) {
		if (input_string_limit < string_length(keyboard_string)) {
			keyboard_string = _text.text_str;
			exit;
		}
		with (_text) {
			sc_gui_node_event_update_by_args({str : keyboard_string});
		}
		view_x = max(0, _text.block_width - view_width);
		view_y = max(0, _text.block_height - view_height);
	}
}

function sc_gui_input_draw_cursor()
{
	if (!status_focus) {
		exit;
	}
	if (input_cursor_frame == 30) {
		input_cursor_frame = 0;
		input_cursor_blink = !input_cursor_blink;
	}
	input_cursor_frame++;
	if (input_cursor_blink) {
		var _text = sc_gui_node_uri_router("/childs/cid/" + string(GUI_CLASS.TEXT));
		var _color = sc_gui_config_attr_theme_get(
			self, GUI_THEME.CURSOR_COLOR_NORM);
		
		draw_rectangle_colour(block_x + _text.view_width + border_px, _text.block_y,
			block_x + _text.view_width + border_px,
			_text.block_y + _text.view_height,
			_color, _color, _color, _color, false);
	}
}
