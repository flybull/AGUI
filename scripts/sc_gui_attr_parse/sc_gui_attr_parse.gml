/// @function:		sc_gui_config_attr_parse_construct() 
/// @description:	Gui config_func attribute parse construct.
function sc_gui_config_attr_parse_construct() {
	gml_pragma("global", "sc_gui_config_attr_parse_construct()");
	var _class = { cid : GUI_CLASS.DEFAULT, inherit : GUI_CLASS.DEFAULT};
	sc_gui_global_preload_set_factor(
		global.gui_preload.factor_attr_parse,
		_class,
		function(__class)   { return ds_map_create(); },
		function(__obj)		{ ds_map_destroy(__obj); },
		sc_gui_config_attr_parse_clone,
		sc_gui_config_attr_parse_syn_default,
	);
}

/// @function:		sc_gui_config_attr_parse_build() 
/// @description:	Gui config_func attribute parse build.
function sc_gui_config_attr_parse_build()
{
	if (!is_undefined(global.gui.config_attr_parse)) {
		exit;
	}
	global.gui.config_attr_parse = sc_gui_global_config_construct(
					global.gui_preload.factor_attr_parse);
	sc_gui_global_config_build(global.gui_preload.factor_attr_parse);
}

/// @function:		sc_gui_global_attr_parse_destroy() 
/// @description:	Gui config_func attribute parse destroy.
function sc_gui_global_attr_parse_destroy()
{
	if (is_undefined(global.gui.config_attr_parse)) {
		exit;
	}
	sc_gui_global_config_destroy(
		global.gui.config_attr_parse, 
		global.gui_preload.factor_attr_parse);
	global.gui.config_attr_parse= undefined;
}

/// @function:		sc_gui_config_attr_parse_clone(__self) 
/// @description:	Gui config_func attribute parse clone.
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}
function sc_gui_config_attr_parse_clone(__self)
{
	var _classid = __self.cid;
	var _inherit = __self.inherit;
	var _parse = ds_map_create();
	if (sc_gui_is_fast_classid(_inherit)) {
		ds_map_copy(_parse, global.gui.config_attr_parse[@ _inherit]);
	} else {
		ds_map_copy(_parse, global.gui.config_attr_parse[@ GUI_CLASS.MAX][? _inherit]);
	}
	global.gui.config_attr_parse[@ GUI_CLASS.MAX][? _classid] = _parse;
	return _parse;
}

/// @function:		sc_gui_config_attr_parse_syn_default(__self) 
/// @description:	Gui config_func node parse syn attribute default value.
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}  (array or value)
function sc_gui_config_attr_parse_syn_default(__self)
{
	sc_gui_config_set_attr_parse_private(__self)
	sc_gui_config_attr_parse_set(__self, "cid", sc_base_empty_call);
	sc_gui_config_set_attr_parse_xy(__self);
	sc_gui_config_set_attr_parse_margin(__self);
	sc_gui_config_set_attr_parse_padding(__self);
	sc_gui_config_set_attr_parse_flex(__self);
	sc_gui_config_set_attr_parse_block(__self);
	sc_gui_config_set_attr_parse_shape(__self);
	sc_gui_config_set_attr_parse_flag(__self);
	sc_gui_config_set_attr_parse_func(__self);
	sc_gui_config_set_attr_parse_decorate(__self);
	sc_gui_config_set_attr_parse_animation(__self);
	sc_gui_config_set_attr_parse_observer(__self);
}

/// @function:		sc_gui_config_attr_parse_set(__self, __name, __function) 
/// @description:	Gui config_func node set attribute (for get attr method).
/// @param:         {__selfs} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS} (array or value)
/// @param:			{__name} {string}  real name
/// @param:			{__function} function or scriptid
function sc_gui_config_attr_parse_set(__self, __name, __function)
{
	gml_pragma("forceinline");
	if (is_array(__self)) {
		for (var i = 0; i < array_length(__self); i++) {
			sc_gui_config_set_attr_parse_mult(__self[i], __name, __function);
		}
	} else {
		sc_gui_config_set_attr_parse_mult(__self, __name, __function);
	}
}

/// @function:		sc_gui_config_set_attr_parse_mult(__self, __names, __function) 
/// @description:	Gui config_func node set attribute (for get attr method).
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS} 
/// @param:			{__names} {string}  real names
/// @param:			{__function} function or scriptid
function sc_gui_config_set_attr_parse_mult(__self, __names, __function)
{
	if (is_array(__names)) {
		for (var i = 0; i < array_length(__names); i++) {
			sc_gui_config_set_attr_parse_once(__self, __names[i], __function);
		}
	} else {
		sc_gui_config_set_attr_parse_once(__self, __names, __function);
	}
}

/// @function:		sc_gui_config_set_attr_parse_once(__self, __name, __function) 
/// @description:	Gui config_func node set attribute (once) (for get attr method).
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}
/// @param:			{__name} string
/// @param:			{__function} function or scriptid
function sc_gui_config_set_attr_parse_once(__self, __name, __function)
{
	//if (ds_map_exists(global.gui.config_attr_parse, __name)) {
	//	throw("[sc_gui_config_set_attr] conflict!! __name:" + string(__name));
	//}
	var _parse = sc_gui_global_config_get(global.gui.config_attr_parse, 
				global.gui_preload.factor_attr_parse, __self);
	_parse[? __name] = method(undefined, __function);
}

/// @function:		sc_gui_config_attr_parse_get(__self, __name) 
/// @description:	Gui config_func node get attribute parse.
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}
/// @param:			{__name} { string} real name or other name
function sc_gui_config_attr_parse_get(__self, __name)
{
	gml_pragma("forceinline");

	// For perform, don't use method and script_execute ...	
	// Don't check is undefined for performance. 
	// If code crashes, check the code by yourself.
	// WARN: string seem copy op
	var _parse = sc_gui_global_config_get(
		global.gui.config_attr_parse, undefined, __self);
	// is_undefined(_realname) ? _realname: _value.names
	return _parse[? __name];
}

/// @function:		sc_gui_config_set_attr_parse_private(__self) 
/// @description:	Gui config_func node set attribute of private parse.
///					(Features to be developed)
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}  (array or value)
function sc_gui_config_set_attr_parse_private(__self)
{
	sc_gui_config_attr_parse_set(__self, "private", function(__attr, __name, __realname, __self) {
		throw("[sc_gui_config_set_attr_parse_private] this is private attr(see sc_gui_node_constructor), Don't set it! name:" + __name);
	});
}

/// @function:		sc_gui_config_set_attr_parse_xy(__self) 
/// @description:	Gui config_func node set attribute of relative-xy parse.
///					(Features to be developed)
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}  (array or value)
function sc_gui_config_set_attr_parse_xy(__self)
{
	sc_gui_config_attr_parse_set(__self, "x", function(__attr, __name, __realname, __self) {
		block_x = variable_struct_get(__attr, __name);
	});
	sc_gui_config_attr_parse_set(__self, "y", function(__attr, __name, __realname, __self) {
		block_y = variable_struct_get(__attr, __name);
	});
}

/// @function:		sc_gui_config_set_attr_parse_margin(__self) 
/// @description:	Gui config_func node set attribute of margin parse.
///					(Features to be developed)
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}  (array or value)
function sc_gui_config_set_attr_parse_margin(__self)
{
	sc_gui_config_attr_parse_set(__self, "margin", function(__attr, __name, __realname, __self) {
		var _val = variable_struct_get(__attr, __name);
		if (is_array(_val)) {
			switch(array_length(_val)) {
			default:
			case 4: 
				margin_right = _val[3];
			case 3:
				margin_bottom = _val[2];
			case 2:
				margin_left = _val[1];
			case 1:
				margin_top = _val[0];
				break;
			case 0:
				margin_top = 0;
				margin_bottom = 0;
				margin_left = 0;
				margin_right = 0;
				break;			
			}
		} else if (is_numeric(_val)) {
			margin_top = _val;
			margin_bottom = _val;
			margin_left = _val;
			margin_right = _val;
		}
	});
	sc_gui_config_attr_parse_set(__self, "mt", function(__attr, __name, __realname, __self) {
		margin_top = variable_struct_get(__attr, __name);
	});
	sc_gui_config_attr_parse_set(__self, "mb", function(__attr, __name, __realname, __self) {
		margin_bottom = variable_struct_get(__attr, __name);
	});
	sc_gui_config_attr_parse_set(__self, "ml", function(__attr, __name, __realname, __self) {
		margin_left = variable_struct_get(__attr, __name);
	});
	sc_gui_config_attr_parse_set(__self, "mr", function(__attr, __name, __realname, __self) {
		margin_right = variable_struct_get(__attr, __name);
	});	
}

/// @function:		sc_gui_config_set_attr_parse_padding(__self) 
/// @description:	Gui config_func node set attribute of padding parse.
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}  (array or value)
function sc_gui_config_set_attr_parse_padding(__self)
{
	sc_gui_config_attr_parse_set(__self, "padding", function(__attr, __name, __realname, __self) {
		var _val = variable_struct_get(__attr, __name);
		if (is_array(_val)) {
			switch(array_length(_val)) {
			default:
			case 4: 
				padding_right = _val[3];
			case 3:
				padding_bottom = _val[2];
			case 2:
				padding_left = _val[1];
			case 1:
				padding_top = _val[0];
				break;
			case 0:
				padding_top = 0;
				padding_bottom = 0;
				padding_left = 0;
				padding_right = 0;
				break;			
			}
		} else if (is_numeric(_val)) {
			padding_top = _val;
			padding_bottom = _val;
			padding_left = _val;
			padding_right = _val;
		}
	});
	sc_gui_config_attr_parse_set(__self, "pt", function(__attr, __name, __realname, __self) {
		padding_top = variable_struct_get(__attr, __name);
	});
	sc_gui_config_attr_parse_set(__self, "pb", function(__attr, __name, __realname, __self) {
		padding_bottom = variable_struct_get(__attr, __name);
	});
	sc_gui_config_attr_parse_set(__self, "pl", function(__attr, __name, __realname, __self) {
		padding_left = variable_struct_get(__attr, __name);
	});
	sc_gui_config_attr_parse_set(__self, "pr", function(__attr, __name, __realname, __self) {
		padding_right = variable_struct_get(__attr, __name);
	});
}

/// @function:		sc_gui_config_set_attr_parse_flex(__self) 
/// @description:	Gui config_func node set attribute of flex parse.
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}  (array or value)
function sc_gui_config_set_attr_parse_flex(__self)
{
	sc_gui_config_attr_parse_set(__self, "flex_algin", function(__attr, __name, __realname, __self) {
		var _algin = variable_struct_get(__attr, __name);
		if (!is_string(_algin)) {
			flex_algin = _algin;
			exit
		}
		switch (_algin) {
		case "start": flex_algin = GUI_FLEX_ALIGN.START; break;
		case "center": flex_algin = GUI_FLEX_ALIGN.CENTER; break;
		case "end": flex_algin = GUI_FLEX_ALIGN.END; break;
		default: throw("[sc_gui_config_set_attr_parse_flex] flex_algin undefined :" + _algin); break;
		}
	});
	sc_gui_config_attr_parse_set(__self, "flex_justify", function(__attr, __name, __realname, __self) {
		var _justify = variable_struct_get(__attr, __name);
		if (!is_string(_justify)) {
			flex_justify = _justify;
			exit
		}
		switch (_justify) {
		case "start": flex_justify = GUI_FLEX_JUSTIFY.START; break;
		case "center": flex_justify = GUI_FLEX_JUSTIFY.CENTER; break;
		case "end": flex_justify = GUI_FLEX_JUSTIFY.END; break;
		default: throw("[sc_gui_config_set_attr_parse_flex] flex_justify undefined :" + _justify);; break;
		}
	});
}

/// @function:		sc_gui_config_set_attr_parse_block(__self) 
/// @description:	Gui config_func node set attribute of block parse.
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}  (array or value)
function sc_gui_config_set_attr_parse_block(__self)
{
	sc_gui_config_attr_parse_set(__self, "bd", function(__attr, __name, __realname, __self) {
		var _direct = variable_struct_get(__attr, __name);
		if (!is_string(_direct)) {
			block_direct = _direct;
			exit;
		}
		switch (_direct) {
		case "row": block_direct = GUI_FLEX_DIRECT.ROW; break;
		case "col": block_direct = GUI_FLEX_DIRECT.COL; break;
		case "rrow": block_direct = GUI_FLEX_DIRECT.RROW; break;
		case "rcol": block_direct = GUI_FLEX_DIRECT.RCOL; break;
		default: throw("[sc_gui_config_set_attr_parse_block] block_direct undefined :" + _direct); break;
		}
	});
	sc_gui_config_attr_parse_set(__self, "w", function(__attr, __name, __realname, __self) {
		spec_width = variable_struct_get(__attr, __name);
	});
	sc_gui_config_attr_parse_set(__self, "h", function(__attr, __name, __realname, __self) {
		spec_height = variable_struct_get(__attr, __name);
	});
	sc_gui_config_attr_parse_set(__self, "max_w", function(__attr, __name, __realname, __self) {
		max_width = variable_struct_get(__attr, __name);
	});
	sc_gui_config_attr_parse_set(__self, "max_h", function(__attr, __name, __realname, __self) {
		max_height = variable_struct_get(__attr, __name);
	});
}

/// @function:		sc_gui_config_set_attr_parse_shape(__self) 
/// @description:	Gui config_func node set attribute of shape parse.
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}  (array or value)
function sc_gui_config_set_attr_parse_shape(__self)
{
	sc_gui_config_attr_parse_set(__self, "attr_shape", function(__attr, __name, __realname, __self) {
		var _shape = variable_struct_get(__attr, __name);
		if (!variable_struct_exists(self, "___mark")) {
			variable_struct_set(self, is_undefined(__realname) ? __name : __realname, _shape);
			exit;
		}
		if (is_undefined(_shape)) {
			if (!is_undefined(shape)) {
				delete shape;
				shape = undefined;
			}
			exit;
		}
		sc_assert(is_struct(_shape), "[sc_gui_config_set_attr_parse_decorate] shape attr type error! type:" + typeof(_shape));

		if (variable_struct_exists(_shape, "type")) {
			if (!is_undefined(shape)) {
				delete shape;
				shape = undefined;
			}
			switch(_shape.type) {
			case "rect":
				shape = new sc_gui_shape_rect(_shape);
				break;
			case "roundrect":
				shape = new sc_gui_shape_roundrect(_shape);
				break;
			case "circle":
				shape = new sc_gui_shape_circle(_shape);
				break;	
			case "sprite":
				shape = new sc_gui_shape_sprite(_shape);
				break;
			}
		} else {
			if (!is_undefined(shape)) {
				sc_gui_config_syn_add_other_attr_value(shape, _shape);
			}
		}
	});
}

/// @function:		sc_gui_config_set_attr_parse_flag(__self) 
/// @description:	Gui config_func node set attribute of flag parse.
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}  (array or value)
function sc_gui_config_set_attr_parse_flag(__self)
{
	sc_gui_config_set_attr_parse_struct(__self, "flag_crlf");
}

/// @function:		sc_gui_config_set_attr_parse_func(__self) 
/// @description:	Gui config_func node set attribute of function parse.
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}  (array or value)
function sc_gui_config_set_attr_parse_func(__self)
{
	sc_gui_config_attr_parse_set(__self, "func", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		sc_assert(is_array(_func), "[sc_gui_config_set_attr_parse_flag] attr type error! type:" + typeof(_func));
		var _len = array_length(_func);
		sc_assert(GUI_FUNC_TYPE.MAX == _len, "[sc_gui_config_set_attr_parse_flag] len error! len:"+ string(_len));
		if (!variable_struct_exists(self, "func")) {
			variable_struct_set(self, "func", array_create(_len));
		}
		
		array_copy(func, 0, _func, 0, _len);
	});
	sc_gui_config_attr_parse_set(__self, "func_check_hover", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.CHECK_HOVER] = method(undefined, _func);
	});
	sc_gui_config_attr_parse_set(__self, "func_check_hover_scale", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.CHECK_HOVER_SCALE] = method(undefined, _func);
	});
	sc_gui_config_attr_parse_set(__self, "func_check_hover_scroll", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.CHECK_HOVER_SCROLL] = method(undefined, _func);
	});
	sc_gui_config_attr_parse_set(__self, "func_check_hover_childs", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.CHECK_HOVER_CHILDS] = method(undefined, _func);
	});
	sc_gui_config_attr_parse_set(__self, "func_check_press", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.CHECK_PRESS] = method(undefined, _func);
	});
	sc_gui_config_attr_parse_set(__self, "func_check_release", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.CHECK_RELEASE] = method(undefined, _func);
	});

	sc_gui_config_attr_parse_set(__self, "func_on_hover", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.ON_HOVER] = method(undefined, _func);
	});
	sc_gui_config_attr_parse_set(__self, "func_on_away", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.ON_AWAY] = method(undefined, _func);
	});
	sc_gui_config_attr_parse_set(__self, "func_on_focus", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.ON_FOCUS] = method(undefined, _func);
	});
	sc_gui_config_attr_parse_set(__self, "func_on_blur", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.ON_BLUR] = method(undefined, _func);
	});
	sc_gui_config_attr_parse_set(__self, "func_on_press", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.ON_PRESS] = method(undefined, _func);
	});
	sc_gui_config_attr_parse_set(__self, "func_on_hold", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.ON_HOLD] = method(undefined, _func);
	});
	sc_gui_config_attr_parse_set(__self, "func_on_release", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.ON_RELEASE] = method(undefined, _func);
	});
	sc_gui_config_attr_parse_set(__self, "func_on_input", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.ON_INPUT] = method(undefined, _func);
	});

	sc_gui_config_attr_parse_set(__self, "func_on_move", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.ON_MOVE] = method(undefined, _func);
	});
	sc_gui_config_attr_parse_set(__self, "func_on_scroll", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.ON_SCROLL] = method(undefined, _func);
	});
	sc_gui_config_attr_parse_set(__self, "func_on_scale", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.ON_SCALE] = method(undefined, _func);
	});
	sc_gui_config_attr_parse_set(__self, "func_on_drag", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.ON_DRAG] = method(undefined, _func);
	});
	
	sc_gui_config_attr_parse_set(__self, "func_on_begin", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.ON_INIT_BEGIN] = method(undefined, _func);
	});
	sc_gui_config_attr_parse_set(__self, "func_on_end", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.ON_INIT_END] = method(undefined, _func);
	});
	sc_gui_config_attr_parse_set(__self, "func_on_ready", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.ON_INIT_READY] = method(undefined, _func);
	});
	sc_gui_config_attr_parse_set(__self, "func_on_destroy", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.ON_DESTORY] = method(undefined, _func);
	});

	sc_gui_config_attr_parse_set(__self, "func_on_update", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.ON_UPDATE] = method(undefined, _func);
	});
	sc_gui_config_attr_parse_set(__self, "func_on_step", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.ON_STEP] = method(undefined, _func);
	});
	sc_gui_config_attr_parse_set(__self, "func_on_draw", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.ON_DRAW] = method(undefined, _func);
	});
	sc_gui_config_attr_parse_set(__self, "func_draw_backward", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.DRAW_BACKWARD] = method(undefined, _func);
	});
	sc_gui_config_attr_parse_set(__self, "func_draw_forward", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.DRAW_FORWARD] = method(undefined, _func);
	});
	sc_gui_config_attr_parse_set(__self, "func_draw_border", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.DRAW_BORDER] = method(undefined, _func);
	});
	sc_gui_config_attr_parse_set(__self, "func_draw_background", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.DRAW_BACKGROUND] = method(undefined, _func);
	});
	sc_gui_config_attr_parse_set(__self, "func_draw_grids", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.DRAW_GRIDS] = method(undefined, _func);
	});
	sc_gui_config_attr_parse_set(__self, "func_draw_childs", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.DRAW_CHILDS] = method(undefined, _func);
	},);
	sc_gui_config_attr_parse_set(__self, "func_draw_decorate", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.DRAW_DECORATE] = method(undefined, _func);
	});
	sc_gui_config_attr_parse_set(__self, "func_data_get", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.DATA_GET] = method(undefined, _func);
	});
	sc_gui_config_attr_parse_set(__self, "func_data_set", function(__attr, __name, __realname, __self) {
		var _func = variable_struct_get(__attr, __name);
		func[@ GUI_FUNC_TYPE.DATA_SET] = method(undefined, _func);
	});
}

/// @function:		sc_gui_config_set_attr_parse_struct(__self, __names) 
/// @description:	Gui config_func node set attribute of struct value parse.
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}  (array or value)
/// @param:         {__names}    {string or array string} attribute name
function sc_gui_config_set_attr_parse_struct(__self, __names)
{
	if (is_array(__names)) {
		for (var i = 0; i < array_length(__names); ++i) {
			sc_gui_config_attr_parse_set(__self, __names[i], function(__attr, __name, __realname, __self) {
				variable_struct_set(self, is_undefined(__realname) ? __name : __realname, variable_struct_get(__attr, __name));
			});
		}
	} else {
		sc_gui_config_attr_parse_set(__self, __names, function(__attr, __name, __realname, __self) {
			variable_struct_set(self, is_undefined(__realname) ? __name : __realname, variable_struct_get(__attr, __name));
		});
	}
}


/// @function:		sc_gui_config_set_attr_parse_decorate_template(__self, __name, __function) 
/// @description:	Gui config_func node set attribute of decorate's template parse.
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}  (array or value)
/// @param:         {__name} string
/// @param:         {__function}
function sc_gui_config_set_attr_parse_decorate_template(__self, __name, __function)
{
	// Because gml don't support regex, No way I'm stupid 
	sc_gui_config_attr_parse_set(__self, 
		[__name + "s", __name + "s1",  __name + "s2",  __name + "s3",  __name + "s4"], 
		__function
	);
	sc_gui_config_attr_parse_set(__self, 
		[__name, __name + "1",  __name + "2",  __name + "3",  __name + "4"], 
		__function
	);	
}

function sc_gui_config_set_attr_parse_decorate_template_parse(__self, __attr, __name, __realname, __classid)
{
	var _attrs = variable_struct_get(__attr, __name);
	if (!variable_struct_exists(self, "___mark")) {
		variable_struct_set(self, is_undefined(__realname) ? __name : __realname, _attrs);
		exit;
	}
	if (is_array(_attrs)) {
		for (var i = 0; i < array_length(_attrs); ++i) {
			var _attr = _attrs[i];
			sc_assert(is_struct(_attr), "[sc_gui_config_set_attr_parse_decorate_template_parse] " + __name + " some attr type error! type:" + typeof(_attr));
			sc_gui_decorate([{___mark : __name + string(i)}, _attr], , ,__classid);
		}
	} else if (is_struct(_attrs)) {
		sc_gui_decorate([{___mark : __name}, _attrs], , ,__classid);
	} else {
		sc_assert(false, "[sc_gui_config_set_attr_parse_decorate_template_parse] " + __name + " attr type error! type:" + typeof(_attrs));
	}
}
	
/// @function:		sc_gui_config_set_attr_parse_decorate(__self) 
/// @description:	Gui config_func node set attribute of decorate's text parse.
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}  (array or value)
function sc_gui_config_set_attr_parse_decorate(__self)
{
	sc_gui_config_set_attr_parse_decorate_template(__self, "text", function(__attr, __name, __realname, __self) {
		sc_gui_config_set_attr_parse_decorate_template_parse(__self, __attr, __name, __realname, GUI_CLASS.TEXT);
	});
	sc_gui_config_set_attr_parse_decorate_template(__self, "sprite", function(__attr, __name, __realname, __self) {
		sc_gui_config_set_attr_parse_decorate_template_parse(__self, __attr, __name, __realname, GUI_CLASS.SPRITE);
	});
	sc_gui_config_set_attr_parse_decorate_template(__self, "triangle", function(__attr, __name, __realname, __self) {
		sc_gui_config_set_attr_parse_decorate_template_parse(__self, __attr, __name, __realname, GUI_CLASS.TRIANGLE);
	});
	sc_gui_config_set_attr_parse_decorate_template(__self, "rect", function(__attr, __name, __realname, __self) {
		sc_gui_config_set_attr_parse_decorate_template_parse(__self, __attr, __name, __realname, GUI_CLASS.RECT);
	});
	sc_gui_config_set_attr_parse_decorate_template(__self, "roundrect", function(__attr, __name, __realname, __self) {
		sc_gui_config_set_attr_parse_decorate_template_parse(__self, __attr, __name, __realname, GUI_CLASS.ROUNDRECT);
	});
	sc_gui_config_set_attr_parse_decorate_template(__self, "circle", function(__attr, __name, __realname, __self) {
		sc_gui_config_set_attr_parse_decorate_template_parse(__self, __attr, __name, __realname, GUI_CLASS.CIRCLE);
	});
}

/// @function:		sc_gui_config_set_attr_parse_animation(__self) 
/// @description:	Gui config_func node set attribute of animation's parse.
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}  (array or value)
function sc_gui_config_set_attr_parse_animation(__self)
{
	sc_gui_config_attr_parse_set(__self, "animation", function(__attr, __name, __realname, __self) {
		var _values = variable_struct_get(__attr, __name);
		if (is_undefined(attr_animation)) {
			attr_animation = new sc_gui_animation();
		}
		sc_gui_config_syn_add_other_attr_value(attr_animation, _values);
	});

	
	// {hover : { path : {delay:1, times:1, duration:1, formula: }}
}


/// @function:		sc_gui_config_set_attr_parse_observer(__self, __names) 
/// @description:	Gui config_func node set attribute of observer parse.
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}  (array or value)
function sc_gui_config_set_attr_parse_observer(__self)
{
	sc_gui_config_attr_parse_set(__self, "observer", function(__attr, __name, __realname, __self) {
		var _values = variable_struct_get(__attr, __name);
		// any | someone
		sc_assert(is_string(_values), "must be a struct {press:\"a|b|c\",release:\"any\"}")
		var _press = variable_struct_get(_values, "press");
		var _release = variable_struct_get(_values, "release");
		if (!is_undefined(keyboard_observe)) {
			global.gui.keyboard_impl.unregister_press(sid, variable_struct_get(keyboard_observe, "press"));
			global.gui.keyboard_impl.unregister_release(sid, variable_struct_get(keyboard_observe, "release"));
			keyboard_observe = undefined;
		}
		if (!is_undefined(_press)) {
			global.gui.keyboard_impl.register_press(sid, _press);
		}
		if (!is_undefined(_release)) {
			global.gui.keyboard_impl.register_release(sid, _release);
		}
		keyboard_observe = _values;
	});	
}