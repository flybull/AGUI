function sc_gui_keyboard_impl() constructor
{
	keyboard_max_value = 256;
	keyboard_map = ds_map_create();
	sc_gui_keyboard_map_setting(keyboard_map);
	
	keyboard_input_record = ds_list_create();
	keyboard_input_status = array_create(keyboard_max_value, 0);
	keyboard_input_observer_press = array_create(keyboard_max_value, undefined);
	keyboard_input_observer_release = array_create(keyboard_max_value, undefined);
	keyboard_input_observer_any_press = ds_list_create();
	keyboard_input_observer_any_release = ds_list_create();
	for (var i = 0; i < keyboard_max_value; ++i) {
		keyboard_input_observer_press[@ i] = ds_list_create();
		keyboard_input_observer_release[@ i] = ds_list_create();
	}

	static observe = sc_gui_keyboard_observe;

	static destroy = function()
	{
		ds_map_clear(keyboard_map);
		ds_map_destroy(keyboard_map);
		ds_list_destroy(keyboard_input_record);
		ds_list_destroy(keyboard_input_observer_any_press);
		ds_list_destroy(keyboard_input_observer_any_release);
		for (var i = 0; i < keyboard_max_value; ++i) {
			ds_list_destroy(keyboard_input_observer_press[i]);
			ds_list_destroy(keyboard_input_observer_release[i]);
		}
		array_delete(keyboard_input_observer_press, 0, keyboard_max_value);
		array_delete(keyboard_input_observer_release, 0, keyboard_max_value);
	}

	static register_press = function(__sid, __value) {
		if (is_undefined(__value)) {
			exit;
		}
		if (__value == "any") {
			ds_list_add(keyboard_input_observer_any_press, __sid);
			exit;
		}
		var _keys = sc_gui_keyboard_convert_s2v(keyboard_map, __value);
		var n = array_length(_keys);
		for (var i = 0; i < n; ++i) {
			ds_list_add(keyboard_input_observer_press[_keys[i]], __sid);
		}
	}
	static unregister_press = function(__sid, __value) {
		if (is_undefined(__value)) {
			exit;
		}
		if (__value == "any") {
			sc_ds_list_delete(keyboard_input_observer_any_press, __sid);
			exit;
		}
		var _keys = sc_gui_keyboard_convert_s2v(keyboard_map, __value);
		var n = array_length(_keys);
		for (var i = 0; i < n; ++i) {
			sc_ds_list_delete(keyboard_input_observer_press[_keys[i]], __sid);
		}
	}
	static register_release = function(__sid, __value) {
		if (is_undefined(__value)) {
			exit;
		}
		if (__value == "any") {
			ds_list_add(keyboard_input_observer_any_release, __sid);
			exit;
		}
		var _keys = sc_gui_keyboard_convert_s2v(keyboard_map, __value);
		var n = array_length(_keys);
		for (var i = 0; i < n; ++i) {
			ds_list_add(keyboard_input_observer_release[_keys[i]], __sid);
		}		
	}
	static unregister_release = function(__sid, __value) {
		if (is_undefined(__value)) {
			exit;
		}
		if (__value == "any") {
			sc_ds_list_delete(keyboard_input_observer_any_release, __sid);
			exit;
		}
		var _keys = sc_gui_keyboard_convert_s2v(keyboard_map, __value);
		var n = array_length(_keys);
		for (var i = 0; i < n; ++i) {
			sc_ds_list_delete(keyboard_input_observer_release[_keys[i]], __sid);
		}
	}
}

function sc_gui_keyboard_observe()
{
	// http("") and vm last(-1)
	var _lastkey = keyboard_lastkey;
	keyboard_lastkey = -1;
	if (is_numeric(_lastkey) && _lastkey != -1) {
		// sc_assert(_lastkey <= keyboard_max_value, "keyboard lastkey too large:" + string(_lastkey));
		if (keyboard_input_status[_lastkey]) {
			var _idx = ds_list_find_index(keyboard_input_record, _lastkey);
			ds_list_delete(keyboard_input_record, _idx);
		}

		ds_list_insert(keyboard_input_record, 0, _lastkey);
		keyboard_input_status[_lastkey] = 1;
	}

	var n = ds_list_size(keyboard_input_record);
	var i = 0;
	while (i < n)
	{
		var _key = keyboard_input_record[| i];
		var _press = keyboard_check_pressed(_key);
		var _event;
		var _obs_one, _obs_any;
		if (_press) {
			_obs_one = keyboard_input_observer_press[@ _key];
			_obs_any = keyboard_input_observer_any_press;
			_event = GUI_FUNC_TYPE.OBSERVE_PRESS;
			i++ ;
		} else {
			ds_list_delete(keyboard_input_record, i);
			keyboard_input_status[@ _key] = 0;
			_obs_one = keyboard_input_observer_release[@ _key];
			_obs_any = keyboard_input_observer_any_release;
			_event = GUI_FUNC_TYPE.OBSERVE_RELEASE;
			n--;
		}

		for (var o = 0; o < ds_list_size(_obs_one); ++o) {
			sc_gui_keyboard_event_process(sc_gui_global_node_find(_obs_one[| o]), _event,_key)
		}
		for (var o = 0; o < ds_list_size(_obs_any); ++o) {
			sc_gui_keyboard_event_process(sc_gui_global_node_find(_obs_one[| o]), _event,_key)
		}
	}
}

function sc_gui_keyboard_event_process(__node, __event, __key)
{
	gml_pragma("forceinline");
	if (is_undefined(_node)) {
		exit;
	}
	with (_node) {
		func[@ __event](__key);
	}
}

function sc_gui_keyboard_convert_s2v(__map, __keys)
{
	var _keys = sc_string_split("|", __keys);
	var _vals = [];
	var _val;
	var n = array_length(_keys);
	for (var i = 0; i < n; ++i) {
		if (string_length(_keys[i]) == 1) {
			array_push(_vals, ord(_keys[i]));
			continue;
		}
		_val = ds_map_find_value(__map, _keys[i]);
		if (!is_undefined(_val)) {
			array_push(_vals, _val);
		}
	}
	return _vals;
}

function sc_gui_keyboard_map_setting(__map)
{
	__map[? "vk_left"] = vk_left;
	__map[? "vk_right"] = vk_right;
	__map[? "vk_up"] = vk_up;
	__map[? "vk_down"] = vk_down;
	__map[? "vk_enter"] = vk_enter;
	__map[? "vk_escape"] = vk_escape;
	__map[? "vk_space"] = vk_space;
	__map[? "vk_shift"] = vk_shift;
	__map[? "vk_control"] = vk_control;
	__map[? "vk_alt"] = vk_alt;
	__map[? "vk_backspace"] = vk_backspace;
	__map[? "vk_tab"] = vk_tab;
	__map[? "vk_home"] = vk_home;
	__map[? "vk_end"] = vk_end;
	__map[? "vk_delete"] = vk_delete;
	__map[? "vk_insert"] = vk_insert;
	__map[? "vk_pageup"] = vk_pageup;
	__map[? "vk_pagedown"] = vk_pagedown;
	__map[? "vk_pause"] = vk_pause;
	__map[? "vk_printscreen"] = vk_printscreen;
	__map[? "vk_f1"] = vk_f1;
	__map[? "vk_f2"] = vk_f2;
	__map[? "vk_f3"] = vk_f3;
	__map[? "vk_f4"] = vk_f4;
	__map[? "vk_f5"] = vk_f5;
	__map[? "vk_f6"] = vk_f6;
	__map[? "vk_f7"] = vk_f7;
	__map[? "vk_f8"] = vk_f8;
	__map[? "vk_f9"] = vk_f9;
	__map[? "vk_f10"] = vk_f10;
	__map[? "vk_f11"] = vk_f11;
	__map[? "vk_f12"] = vk_f12;
	__map[? "vk_numpad0"] = vk_numpad0;
	__map[? "vk_numpad1"] = vk_numpad1;
	__map[? "vk_numpad2"] = vk_numpad2;
	__map[? "vk_numpad3"] = vk_numpad3;
	__map[? "vk_numpad4"] = vk_numpad4;
	__map[? "vk_numpad5"] = vk_numpad5;
	__map[? "vk_numpad6"] = vk_numpad6;
	__map[? "vk_numpad7"] = vk_numpad7;
	__map[? "vk_numpad8"] = vk_numpad8;
	__map[? "vk_numpad9"] = vk_numpad9;
	__map[? "vk_multiply"] = vk_multiply;
	__map[? "vk_divide"] = vk_divide;
	__map[? "vk_add"] = vk_add;
	__map[? "vk_subtract"] = vk_subtract;
	__map[? "vk_decimal"] = vk_decimal;
}

