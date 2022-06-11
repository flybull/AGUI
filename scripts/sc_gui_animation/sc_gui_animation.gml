enum GUI_ANIMATION_PROP
{
	PATH,               // formula-return: [x,y]
	SIZE,               // formula-return: [left_w, top_h, w, h]
	SCALE,              // formula-return: [scale_x, scale_y]
	ROTATE,             // formula-return: [rotate, origin_offset_x, origin_offset_y]
	COLOR,              // formula-return: color
	ALPHA,              // formula-return: alpha
	SKEW,
	MAX,
}

/// @function		sc_gui_animation_construct()
/// @description	constructor gui animation config in global
function sc_gui_animation_construct()
{
	gml_pragma("global", "sc_gui_animation_construct()");
	var _class = { cid : GUI_CLASS.ANIMATION, inherit : GUI_CLASS.ANIMATION};

	sc_gui_global_set_class_construct(
		_class.cid, "animation",
		sc_gui_animation_class_construct,
		undefined
	);
	
	sc_gui_global_preload_set_factor(
		global.gui_preload.factor_attr_parse,
		_class,
		function(__class)   { return ds_map_create(); },
		function(__obj)		{ ds_map_destroy(__obj); },
		sc_gui_config_attr_parse_clone,
		sc_gui_config_attr_parse_syn_animation,
	);
	sc_gui_global_preload_set_factor(
		global.gui_preload.factor_attr_alias,
		_class,
		function(__class)   { return ds_map_create(); },
		function(__obj)		{ ds_map_destroy(__obj); },
		sc_gui_config_attr_alias_clone,
		sc_gui_config_attr_alias_animation,
	);
	sc_gui_global_preload_set_factor(
		global.gui_preload.factor_attr_value,
		_class,
		function(__class)   { return new sc_gui_animation();},
		function(__obj)		{ __obj.release(); delete __obj; },
		function(__class)   {}
	);
}

function sc_gui_animation_class_construct() {
	show_debug_message("[global][sc_gui_animation_class_construct] constructor!");
}

/// @function		sc_gui_config_attr_parse_syn_animation()
/// @description	constructor gui animation config in global
function sc_gui_config_attr_parse_syn_animation()
{
	var _class = {cid : GUI_CLASS.ANIMATION, inherit : GUI_CLASS.ANIMATION};
	sc_gui_config_attr_parse_set(_class, ["hover", "hold", "press", "focus", "any"], function(__attr, __name, __realname, __self) {
		var _values = variable_struct_get(__attr, __name);
		var _exclude = variable_struct_get(_values, "exclude");
		_exclude = is_undefined(_exclude) ? false : _exclude;
		var _status = GUI_STATUS.NONE;
		switch (__name) {
		case "hover": _status = GUI_STATUS.HOVER; break;
		case "hold": _status = GUI_STATUS.HOLD; break;
		case "press": _status = GUI_STATUS.PRESS; break;
		case "focus": _status = GUI_STATUS.FOCUS; break;
		case "any": 
			_status = GUI_STATUS.HOVER | GUI_STATUS.HOLD |
					GUI_STATUS.PRESS |GUI_STATUS.FOCUS; 
			break;
		}
		trigger = _exclude ? (trigger & (~_status)) : (trigger | _status);
		sc_gui_config_syn_add_other_attr_value(self, _values);
	});
	sc_gui_config_attr_parse_set(_class, ["path", "size", "scale", "rotate", "color", "alpha"], function(__attr, __name, __realname, __self) {
		var _values = variable_struct_get(__attr, __name);
		var _idx;
		switch (__name) {
		case "path": _idx = GUI_ANIMATION_PROP.PATH; break;
		case "size": _idx = GUI_ANIMATION_PROP.SIZE; break;
		case "scale": _idx = GUI_ANIMATION_PROP.SCALE; break;
		case "rotate": _idx = GUI_ANIMATION_PROP.ROTATE; break;
		case "color": _idx = GUI_ANIMATION_PROP.COLOR; break;
		case "alpha": _idx = GUI_ANIMATION_PROP.ALPHA; break;
		case "skew":  _idx = GUI_ANIMATION_PROP.SKEW; break;
		default: exit;
		}
		if (is_undefined(attrs[@ _idx]))  {
			attrs[@ _idx] = new sc_gui_animation_prop();
		}
		sc_gui_config_syn_other_attr_value(attrs[@ _idx], _values);
	});
}

/// @function		sc_gui_config_attr_alias_animation()
/// @description	constructor gui animation config in global
function sc_gui_config_attr_alias_animation()
{
	var _class = {cid : GUI_CLASS.ANIMATION, inherit : GUI_CLASS.ANIMATION};
	sc_gui_config_attr_alias_set(_class, ["pos","path"], "path");
	sc_gui_config_attr_alias_set(_class, ["size","px"], "size");
	sc_gui_config_attr_alias_set(_class, "scale", "scale");	
	sc_gui_config_attr_alias_set(_class, ["rotate", "rot"], "rotate");
	sc_gui_config_attr_alias_set(_class, ["color", "col"], "color");
	sc_gui_config_attr_alias_set(_class, "alpha", "alpha");	
}

/// @function		sc_gui_animation_prop_construct()
/// @description	constructor gui animation config in global
function sc_gui_animation_prop_construct()
{
	gml_pragma("global", "sc_gui_animation_prop_construct()");
	var _class = { cid : GUI_CLASS.ANIMATION_PROP, inherit : GUI_CLASS.ANIMATION_PROP};

	sc_gui_global_set_class_construct(
		_class.cid, "animation_prop",
		sc_gui_animation_prop_class_construct,
		undefined
	);
	
	sc_gui_global_preload_set_factor(
		global.gui_preload.factor_attr_parse,
		_class,
		function(__class)   { return ds_map_create(); },
		function(__obj)		{ ds_map_destroy(__obj); },
		sc_gui_config_attr_parse_clone,
		sc_gui_config_attr_parse_syn_animation_prop,
	);
	sc_gui_global_preload_set_factor(
		global.gui_preload.factor_attr_alias,
		_class,
		function(__class)   { return ds_map_create(); },
		function(__obj)		{ ds_map_destroy(__obj); },
		sc_gui_config_attr_alias_clone,
		sc_gui_config_attr_alias_animation_prop,
	);
	sc_gui_global_preload_set_factor(
		global.gui_preload.factor_attr_value,
		_class,
		function(__class)   { return new sc_gui_animation_prop();},
		function(__obj)		{ delete __obj; },
		function(__class)   {}
	);
}


function sc_gui_animation_prop_class_construct() {
	show_debug_message("[global][sc_gui_animation_prop_class_construct] constructor!");
}

/// @function		sc_gui_config_attr_parse_syn_animation_prop()
/// @description	constructor gui animation_prop config in global
function sc_gui_config_attr_parse_syn_animation_prop()
{
	var _class = {cid : GUI_CLASS.ANIMATION_PROP, inherit : GUI_CLASS.ANIMATION_PROP};
	sc_gui_config_set_attr_parse_struct(_class, 
		["oid", "delay", "times", "duration", "loops"]);
	sc_gui_config_attr_parse_set(_class, "formula",function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		formula = method(undefined, _func);
	});
}

/// @function		sc_gui_config_attr_alias_animation_prop()
/// @description	constructor gui animation_prop config in global
function sc_gui_config_attr_alias_animation_prop()
{
	var _class = {cid : GUI_CLASS.ANIMATION_PROP, inherit : GUI_CLASS.ANIMATION_PROP};
	sc_gui_config_attr_alias_set(_class, ["oid", "id"], "oid");
	sc_gui_config_attr_alias_set(_class, ["delay","defer"], "delay");
	sc_gui_config_attr_alias_set(_class, "times", "times");
	sc_gui_config_attr_alias_set(_class, ["duration","period",], "duration");
	sc_gui_config_attr_alias_set(_class, ["loops","loop"] , "loops");
	sc_gui_config_attr_alias_set(_class, ["formula", "func"], "formula");
}

function sc_gui_animation() constructor
{
	cid = GUI_CLASS.ANIMATION;
	inherit = GUI_CLASS.ANIMATION;
	trigger = GUI_STATUS.NONE;
	attrs = array_create(GUI_ANIMATION_PROP.MAX, undefined);

	static draw = function(__view_surface, __status_bits, __x, __y, 
		__w, __h, __xscale, __yscale, __roate, __color, __alpha) {
		var _attrs = attrs;
		var _attr;
		var _size_offset_left = 0;
		var _size_offset_top = 0;

		var _rotate_offset_x = 0;
		var _rotate_offset_y = 0;

		sc_gui_animation_step([
			[__x, __y], 
			[0, 0, __w, __h], 
			[__xscale, __yscale], 
			[__roate, 0, 0], 
			__color, 
			__alpha,
			0,
			trigger & __status_bits
		]);
		
		_attr = sc_gui_animation_get_values(_attrs, GUI_ANIMATION_PROP.PATH);
		if (!is_undefined(_attr)) {
			__x = _attr.run_values[0];
			__y = _attr.run_values[1];
		}
		_attr = sc_gui_animation_get_values(_attrs, GUI_ANIMATION_PROP.SIZE);
		if (!is_undefined(_attr)) {
			_size_offset_left = max(0, _attr.run_values[0]);
			_size_offset_top = max(0, _attr.run_values[1]);
			__w = min(__w, _attr.run_values[2] - _size_offset_left);
			__h = min(__h, _attr.run_values[3] - _size_offset_top);
			
			__x += _size_offset_left;
			__y += _size_offset_top;
		}
		_attr = sc_gui_animation_get_values(_attrs, GUI_ANIMATION_PROP.SCALE);
		if (!is_undefined(_attr)) {
			__xscale = _attr.run_values[0];
			__yscale = _attr.run_values[1];
		}
		_attr = sc_gui_animation_get_values(_attrs, GUI_ANIMATION_PROP.ROTATE);
		if (!is_undefined(_attr)) {
			__roate = _attr.run_values[0];
			_rotate_offset_x = _attr.run_values[1];
			_rotate_offset_y = _attr.run_values[2];
					
			if (__roate != 0) {
				var _off = sc_gui_rotate(__roate, _rotate_offset_x, _rotate_offset_y);
				__x -= _off[0];
				__y += _off[1];
			}
		}
		_attr = sc_gui_animation_get_values(_attrs, GUI_ANIMATION_PROP.COLOR);
		if (!is_undefined(_attr)) {
			__color = _attr.run_values;
		}
		_attr = sc_gui_animation_get_values(_attrs, GUI_ANIMATION_PROP.ALPHA);
		if (!is_undefined(_attr)) {
			__alpha = _attr.run_values;
		}

		draw_surface_general(__view_surface, _size_offset_left, _size_offset_top,
			__w, __h, __x, __y,
			__xscale, __yscale, __roate,
			__color, __color, __color, __color,
			__alpha
		);
	}
	static release = function() {
		if (!is_undefined(attrs)) {
			array_delete(attrs, 0, GUI_ANIMATION_PROP.MAX);
			attrs = undefined;
		}
	}
	static refresh = function() {
		sc_ds_array_foreach(attrs, function(__args) {
			refresh();
		});
		run_done = false;
	}
}

function sc_gui_animation_prop() constructor
{
	cid = GUI_CLASS.ANIMATION_PROP;
	inherit = GUI_CLASS.ANIMATION_PROP;

	oid = undefined; // object id
	delay = 0;		 // delay time(1 = skip one frame)
	times = 0;		 // cycle times
	duration = 0;	 // How many frames a cycle lasts (repeat)
	rollback = false;  //
	// keypoint = undefined;
	formula = undefined; // function(run_frame) {  calc ..; reutnr xx; };

	run_done = true;
	run_delay = 0;
	run_times = 0;
	run_frame = 0; // current frame。
	run_values = undefined;
	run_values_last = undefined;
	run_history = ds_stack_create();
	// Control trigger of incontinuity status (ex: press only click one)
	run_trigger = GUI_STATUS.NONE;
	static refresh = function() {
		run_delay = delay;
		run_times = times;
		run_frame = 0;
		run_values = undefined;
		run_values_last = undefined;
		run_delay = delay;
		run_done = false;
		run_trigger = GUI_STATUS.NONE;
	}
	static is_continuous = function() {
		return run_trigger & (GUI_STATUS.PRESS | GUI_STATUS.FOCUS)
			? true : false;
	}
}

function sc_gui_animation_step(__params)
{
	sc_ds_array_foreach(attrs, function(__args) {
		if (is_undefined(formula)) {
			exit;
		}
		
		if (run_done) {
			var _params = __args[1];
			var _targger = _params[GUI_ANIMATION_PROP.MAX + 0];
			if (!_targger) {
				exit;
			}
			refresh();
			run_trigger = _targger;
		}
		// running
		if (run_frame < duration) { 
			if (run_delay > 0) {
				run_delay--;
				exit;
			}
			sc_gui_animation_running(__args);
		}
		if (run_frame < duration) {
			exit;
		}
		
		// run rollback
		if (rollback) { 
			run_values = ds_stack_pop(run_history);
			if (!is_undefined(run_values)) {
				exit;
			}
		}
		// run next
		if (run_times == infinity || run_times > 1) { 
			run_delay = delay;
			run_frame = 0;
			if (run_times != infinity) {
				run_times --;
			}
			run_values_last = undefined;
			run_values = undefined;
			if (rollback == false) {
				ds_stack_clear(run_history);
			}
			exit;
		}
		// run done
		if (run_times = 1) { 
			run_delay = delay;
			run_times = 0;
			run_frame = 0;
			run_done = true;
			run_values_last = undefined;
			run_values = undefined;
			run_trigger = GUI_STATUS.NONE;
			if (rollback == false) {
				ds_stack_clear(run_history);
			}
		}
	}, __params);
}

function sc_gui_animation_running(__args)
{
	gml_pragma("forceinline");

	var _idx = __args[0];
	var _params = __args[1];
	var _targger = is_continuous() ? run_trigger : _params[GUI_ANIMATION_PROP.MAX + 0];

	if (!_targger) {
		if (run_frame) {
			run_values = ds_stack_pop(run_history);
			run_frame--;
		}
		exit;
	}
		
	if (is_undefined(run_values_last)) {
		run_values_last = _params[_idx];
	} else {
		run_values_last = run_values;
	}
	ds_stack_push(run_history, run_values_last);
	run_values = sc_base_safe_call_r(formula);
	run_frame++;
}

function sc_gui_animation_get_values(__attrs, __idx)
{
	gml_pragma("forceinline");
	if (!is_undefined(__attrs[__idx]) && !is_undefined(__attrs[__idx].run_values)) {
		return __attrs[@ __idx];
	}
	return undefined;
}

// a -> path/size/scale/rotate/color/alpha/skew -> b
// {event:"hover", delay: 2, times: , duration}
// delay: delay
// times: cycle times
// duration: How many frames a cycle lasts
// path:{}   [ [x,y], [x1,x2] ]
// size:{}   [ [left_w, top_h, w, h] ]
// scale:{}  [ [scale_x, scale_y] ]
// rotate:{} [ [rotate, off_x, off_y] ]
// color:{}  [ [color] ]
// alpha:{}  [ [alpha] ]


//animation（动画）、transition（过渡）、transform（变形）、translate（移动）
// {hover : { path : {delay:1, times:1, duration:1, formula: }}
