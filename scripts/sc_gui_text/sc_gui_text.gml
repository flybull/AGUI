/// @function		sc_gui_text_construct()
/// @description	constructor gui text config in global
function sc_gui_text_construct()
{
	gml_pragma("global", "sc_gui_text_construct()");
	var _classid = GUI_CLASS.TEXT;
	sc_gui_global_set_class_construct(
		_classid, "text",
		sc_gui_text_class_construct,
		sc_gui_text
	);
}

/// @function		sc_gui_text_class_construct()
/// @description	gui text class construct in global
function sc_gui_text_class_construct() {
	var _class = {cid : GUI_CLASS.TEXT, inherit : GUI_CLASS.DEFAULT};

	sc_gui_config_attr_alias_set(_class, "param", "text_param");
	sc_gui_config_attr_alias_set(_class, ["str", "pattern"], "text_pattern");
	sc_gui_config_attr_alias_set(_class, "sep", "text_sep");
	sc_gui_config_attr_alias_set(_class, "lw", "text_w");
	sc_gui_config_attr_alias_set(_class, "angle", "text_angle");
	sc_gui_config_attr_alias_set(_class, "font", "text_font");
	sc_gui_config_attr_alias_set(_class, "color", "text_col");
	
	sc_gui_config_set_attr_parse_struct(_class,
		["text_param", "text_pattern", "text_sep", 
		"text_w", "text_angle", "text_font", "text_col"],
	);

	sc_gui_config_attr_value_set(_class, {
		// private
		// struct { val:string ...}
		text_str : undefined,
		// public
		// text_value defined by you self 
		text_param : undefined,
		text_pattern : undefined,
		text_sep : -1,
		text_w : -1,
		text_angle : 0,

		attr_shape : undefined,
		flag_hover_hole : true,
		flex_algin : GUI_FLEX_ALIGN.CENTER,
		flex_justify : GUI_FLEX_JUSTIFY.CENTER,
		func_on_end : sc_gui_text_on_end,
		func_on_draw : sc_gui_text_on_draw,
	});
	
	show_debug_message("[global][sc_gui_text_config_construct] constructor!");
}

/// @function		sc_gui_text(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
/// @description	Constructor Gui text node.
/// @param          __attr  {struct} init property
function sc_gui_text(__attr = undefined)
{
	gml_pragma("forceinline");
	return sc_gui_node(__attr, , , GUI_CLASS.TEXT);
}

function sc_gui_text_pattern_calc()
{
	// ex: money: $money0 (money0 is var).
	// text_param = struct { money0:12 unit:"yuan"}
	// text_pattern = "I have $money0 $unit."
	// => "12 yuan"
	// text_param = struct { money0:12 unit:"yuan"}
	// text_pattern = undefined
	// => "12 yuan"	
	// text_param = hello
	// => hello
	var _text_param = text_param;
	var _text_str = text_pattern;
	if (is_undefined(_text_param)) {
		if (is_undefined(_text_str)) {
			return false;
		}
		text_str = _text_str;
		return true;
	}
	if (!is_struct(_text_param)) {
		text_str = is_string(_text_param) ? _text_param : string(_text_param);
		return true;
	}
	var _names = variable_struct_get_names(_text_param);
	var _num = array_length(_names);

	if (is_undefined(_text_str)) {
		_text_str = "";
		for (var i = _num - 1; i >= 0; --i) {
			_text_str += string(variable_struct_get(_text_param, _names[i]));
			if (i != 0) {
				_text_str += " ";
			}
		}
	} else {
		for (var i = 0; i < _num; ++i) {
			var _regex = "$" + _names[i];
			var _value = string(variable_struct_get(_text_param, _names[i]));
			_text_str = string_replace_all(_text_str, _regex, _value);
		}
	}
	text_str = _text_str;
	return true;
}

function sc_gui_text_size_calc()
{
	var _font = draw_get_font();
	draw_set_font(sc_gui_config_attr_theme_get(self, GUI_THEME.TEXT_FONT));
	if (text_angle) {
		var _text_width = string_width_ext(text_str, text_sep, text_w);
		var _text_height = string_height_ext(text_str, text_sep, text_w);
		var _cos = dcos(text_angle);
		var _sin = dsin(text_angle);
		var _wc = _text_width * _cos;
		var _ws = _text_width * _sin;
		var _hc = -_text_height * _cos;
		var _hs = -_text_height * _sin;
		var _maxw = max(0, _wc, _wc - _hs, -_hs);
		var _maxh = max(0, _hc, _ws + _hc, _ws);
		var _minw = min(0, _wc, _wc - _hs, -_hs);
		var _minh = min(0, _hc, _ws + _hc, _ws);
	
		// Calc is No problem, But the rotation matrix is not accurate enough.
		content_width = ceil(_maxw - _minw);
		content_height = ceil(_maxh - _minh);
		shift_x = ceil(-_minw);
		shift_y = floor(_maxh);
	} else {
		content_width = ceil(string_width_ext(text_str, text_sep, text_w));
		content_height = ceil(string_height_ext(text_str, text_sep, text_w));
		shift_x = 0;
		shift_y = 0;	
	}
	draw_set_font(_font);
}

function sc_gui_text_on_end()
{
	if (sc_gui_text_pattern_calc()) {
		sc_gui_text_size_calc();
		sc_gui_node_update_size();
	}
}

/// @function		sc_gui_text_on_draw()
/// @description	Draw Gui node text.
function sc_gui_text_on_draw()
{
	if (flag_visable == false) {
		exit;
	}
	if (is_undefined(text_str)) {
		exit;
	}
	var _font = draw_get_font();
	var _color = draw_get_color();
	var _halign = draw_get_halign();
	var _valign = draw_get_valign();

	draw_set_color(sc_gui_config_attr_theme_get(self, GUI_THEME.TEXT_COLOR_NORM));
	draw_set_font(sc_gui_config_attr_theme_get(self, GUI_THEME.TEXT_FONT));
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	draw_text_ext_transformed(
		block_x, block_y,
		text_str, text_sep, text_w,
		1, 1, text_angle);

	draw_set_font(_font);
	draw_set_color(_color);
	draw_set_halign(_halign);
	draw_set_valign(_valign);
}