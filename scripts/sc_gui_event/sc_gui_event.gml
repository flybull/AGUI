
/// @function		sc_gui_node_event_input()
/// @description	Check event input. event from child to origin.(api)
function sc_gui_node_event_input()
{
	var _keyboard_key = keyboard_key;
	var _mouse_button = mouse_button;
	var _wheel_up = mouse_wheel_up();
	var _wheel_down = mouse_wheel_down();
	if (!(_keyboard_key != vk_nokey) &&
		!(_mouse_button != mb_none) &&
		!_wheel_up &&
		!_wheel_down) {
		exit;
	}
	
	for (var _node = sc_gui_global_node_find(global.gui.hover_node_id);
		!is_undefined(_node); 
		_node = _node.parent) {
		with (_node) {
			if (status_pressed) {
				exit;
			}
			if (_wheel_up && !is_undefined(func[GUI_FUNC_TYPE.ON_WHEEL_UP])) {
				func[GUI_FUNC_TYPE.ON_WHEEL_UP]();
				origin.status_draw = true;
				exit;
			}
			if (_wheel_down && !is_undefined(func[GUI_FUNC_TYPE.ON_WHEEL_DOWN])) {
				func[GUI_FUNC_TYPE.ON_WHEEL_DOWN]();
				origin.status_draw = true;
				exit;
			}
			status_pressed = func[GUI_FUNC_TYPE.CHECK_PRESS]();
			if (status_pressed) {
				hold_x = hover_x - view_x;
				hold_y = hover_y - view_y;
				func[GUI_FUNC_TYPE.ON_PRESS]();
				global.gui.hold_node_id = sid;
				origin.status_draw = true;
				exit;
			}
			if (flag_cutoff) {
				exit;
			}
		}
	}
}

/// @function		sc_gui_node_event_is_hold()
/// @description	If node status_press equal true, then this node is hold.(internal use)
function sc_gui_node_event_is_hold()
{
	var _node = sc_gui_global_node_find(global.gui.hold_node_id);
	if (is_undefined(_node)) {
		return false;
	}
	if (!_node.status_pressed) {
		return false;
	}
	with (_node) {
		if (func[GUI_FUNC_TYPE.CHECK_RELEASE]()) {
			global.gui.hold_node_id = undefined;
			status_pressed = false;
			status_hold = false;
			hold_x = 0;
			hold_y = 0;
			func[GUI_FUNC_TYPE.ON_RELEASE]();
			if (sid != global.gui.hover_node_id) {
				func[GUI_FUNC_TYPE.ON_AWAY]();
				origin.status_draw = true;
				status_hover = false;
				status_pressed = false;
				status_hold = false;
			}
		} else {
			status_hold = true;
			func[GUI_FUNC_TYPE.ON_HOLD]();
		}
		origin.status_draw = true;
	}
	return true;
}


/// @function		sc_gui_node_event_is_lock()
/// @description	If node status_press equal true, then this node is hovered.(internal use)
function sc_gui_node_event_is_lock()
{
	gml_pragma("forceinline");

	var _node = sc_gui_global_node_find(global.gui.hover_node_id);
	if (is_undefined(_node)) {
		return false;
	}
	if (!_node.status_pressed) {
		return false;
	}
	return _node.flag_hover_lock;
	
	// check top window node
	//if (global.gui.hover_origin_id != sid) {
	//	return true;
	//}
	//with (_node) {
	//	if (func[GUI_FUNC_TYPE.CHECK_RELEASE]()) {
	//		status_pressed = false;
	//		status_hold = false;
	//		func[GUI_FUNC_TYPE.ON_RELEASE]();
	//	} else {
	//		status_hold = true;
	//		func[GUI_FUNC_TYPE.ON_HOLD]();
	//	}
	//	origin.status_draw = true;
	//}
	//return true;
}


function sc_gui_config_default_check_press()
{
	return mouse_check_button_pressed(mb_left);
}

function sc_gui_config_default_on_press()
{
	sc_gui_node_remove_focus();
}

function sc_gui_config_default_check_release()
{
	return mouse_check_button_released(mb_left);
}

function sc_gui_event_keyboard_input() {
	switch (keyboard_key) {
	case vk_nokey: 
	    break;
	case vk_anykey: 
	    break;
	case vk_left: 
	    break;
	case vk_right: 
	    break;
	case vk_up: 
	    break;
	case vk_down: 
	    break;
	case vk_enter: 
	    break;
	case vk_escape: 
	    break;
	case vk_space: 
	    break;
	case vk_shift: 
	    break;
	case vk_control: 
	    break;
	case vk_alt: 
	    break;
	case vk_backspace: 
	    break;
	case vk_tab: 
	    break;
	case vk_home: 
	    break;
	case vk_end: 
	    break;
	case vk_delete: 
	    break;
	case vk_insert: 
	    break;
	case vk_pageup: 
	    break;
	case vk_pagedown: 
	    break;
	case vk_pause: 
	    break;
	case vk_printscreen: 
	    break;
	case vk_f1: 
	    break;
	case vk_f2: 
	    break;
	case vk_f3: 
	    break;
	case vk_f4: 
	    break;
	case vk_f5: 
	    break;
	case vk_f6: 
	    break;
	case vk_f7: 
	    break;
	case vk_f8: 
	    break;
	case vk_f9: 
	    break;
	case vk_f10: 
	    break;
	case vk_f11: 
	    break;
	case vk_f12: 
	    break;
	case vk_numpad0: 
	    break;
	case vk_numpad1: 
	    break;
	case vk_numpad2: 
	    break;
	case vk_numpad3: 
	    break;
	case vk_numpad4: 
	    break;
	case vk_numpad5: 
	    break;
	case vk_numpad6: 
	    break;
	case vk_numpad7: 
	    break;
	case vk_numpad8: 
	    break;
	case vk_numpad9: 
	    break;
	case vk_multiply: 
	    break;
	case vk_divide: 
	    break;
	case vk_add: 
	    break;
	case vk_subtract: 
	    break;
	case vk_decimal: 
	    break;
	}
}