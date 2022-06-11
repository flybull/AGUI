enum GUI_FLEX_DIRECT {
	NONE,
	ROW,
	COL,
	// REVERSE
	RROW,
	RCOL,
	// GRID
	GRID,
	INHERT,
}

enum GUI_FLEX_ALIGN {
	START,
	END,
	CENTER,
	STRETCH,
}

enum GUI_FLEX_JUSTIFY {
	START,
	END,
	CENTER,
	STRETCH,
}

enum GUI_SHAPE_TYPE {
	NONE,
	RECT,
	ROUNDRECT,
	CIRCLE,
	ELLIPSE,
	TRIANGLE,
	MAX,
}
enum GUI_TEXT_ALIGN {
	START,
	END,
	CENTER,
}

enum GUI_FUNC_TYPE {
	CHECK_HOVER,
	CHECK_HOVER_SCALE,
	CHECK_HOVER_SCROLL,
	CHECK_HOVER_CHILDS,
	
	CHECK_PRESS,
	CHECK_RELEASE,
	
	OBSERVE_PRESS,
	OBSERVE_RELEASE,

	ON_HOVER,
	ON_AWAY,
	ON_FOCUS,
	ON_BLUR,

	ON_WHEEL_UP,
	ON_WHEEL_DOWN,
	ON_PRESS,
	ON_HOLD,
	ON_RELEASE,
	ON_INPUT,

	ON_MOVE,
	ON_SCROLL,
	ON_SCALE,
	ON_DRAG,
	
	ON_INIT_BEGIN,
	ON_INIT_END,
	ON_INIT_READY,
	ON_DESTORY,
	
	ON_UPDATE,
	ON_STEP,
	
	ON_DRAW,
	DRAW_BORDER,
	DRAW_BACKGROUND,
	DRAW_GRIDS,
	DRAW_FORWARD,
	DRAW_BACKWARD,
	DRAW_CURSOR,
	DRAW_CHILDS,
	DRAW_DECORATE,
	
	
	DATA_GET,
	DATA_SET,
	DATA_PUT,
	MAX,
}

enum GUI_FOCUS_TYPE {
	NONE,
	HOVER,
	PRESS,
}

enum GUI_VALUE_TYPE {
	PIXEL,
	PERCENT,
}

/// @function:		sc_gui_config_attr_value_construct() 
/// @description:	Gui config_func attribute value construct.
function sc_gui_config_attr_value_construct()
{
	gml_pragma("global", "sc_gui_config_attr_value_construct()");
	var _class = { cid : GUI_CLASS.DEFAULT, inherit : GUI_CLASS.DEFAULT};
	sc_gui_global_preload_set_factor(
		global.gui_preload.factor_attr_value,
		_class,
		function(__class)   { return new sc_gui_config_attr_value(__class.cid) },
		function(__obj)		{ delete __obj; },
		sc_gui_config_attr_value_clone,
	);
}

/// @function:		sc_gui_config_attr_value_build() 
/// @description:	Gui config_func attribute value build.
function sc_gui_config_attr_value_build()
{
	if (!is_undefined(global.gui.config_attr_value)) {
		exit;
	}
	global.gui.config_attr_value = sc_gui_global_config_construct(
		global.gui_preload.factor_attr_value);
	sc_gui_global_config_build(global.gui_preload.factor_attr_value);
}


/// @function:		sc_gui_global_attr_value_destroy() 
/// @description:	Gui config_func attribute value destroy.
function sc_gui_global_attr_value_destroy()
{
	if (is_undefined(global.gui.config_attr_value)) {
		exit;
	}
	sc_gui_global_config_destroy(
		global.gui.config_attr_value, 
		global.gui_preload.factor_attr_value);
	global.gui.config_attr_value= undefined;
	//sc_gui_global_config_destroy(global.gui.config_attr_value, function(__obj) {
	//	delete __obj;
	//});
}
/// @function:		sc_gui_config_attr_value_clone(__self) 
/// @description:	Gui config_func attribute value clone.
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}
function sc_gui_config_attr_value_clone(__self)
{
	gml_pragma("forceinline");
	var _classid = __self.cid;
	var _inherit = __self.inherit;
	var _value;
	if (sc_gui_is_fast_classid(_inherit)) {
		if (_inherit == GUI_CLASS.DEFAULT) {
			_value = new sc_gui_config_attr_value(_classid);
		} else {
			_value = new sc_gui_config_attr_value0(_classid, _inherit);
		}
	}
	global.gui.config_attr_value[@ GUI_CLASS.MAX][? _classid] = _value;
	return _value;
}

/// @function:		sc_gui_config_syn_attr_value(__self_attr) 
/// @description:	Gui config_func node sync attribute from config_attr_value.
/// @param:         {__self_attr} {struct} sc_gui_config_attr_value
function sc_gui_config_syn_attr_value(__self_attr)
{
	with (__self_attr) {
		var _value = sc_gui_config_attr_value_get(self);
		var _names = variable_struct_get_names(_value);
		for (var i = 0; i < array_length(_names); ++i) {
			var _realname = sc_gui_config_attr_alias_get(self, _names[i]);
			var _parse = sc_gui_config_attr_parse_get(self, 
				is_undefined(_realname) ? _names[i] : _realname);
			if (!is_undefined(_parse)) {
				_parse(_value, _names[i], _realname, self);
			} else { // inhert?
				variable_struct_set(self, _names[i], variable_struct_get(_value, _names[i]));
			}
			//sc_assert(is_method(_parse), "[sc_gui_config_syn_attr_value] not found function or attr! cid:" + string(cid) + ",name:" + _names[i]);
		}
	}
}

/// @function:		sc_gui_config_syn_other_attr_value(__self_attr, __attr) 
/// @description:	Gui config_func node sync attribute from other attr_val.
/// @param:         {__self_attr} {struct} sc_gui_config_attr_value
/// @param:         {__attr}      {struct} set attribute value
function sc_gui_config_syn_other_attr_value(__self_attr, __attr)
{
	with (__self_attr) {
		sc_base_m2s_call(function(__attr) {
			if (is_undefined(__attr)) {
				exit;
			}
			var _names = variable_struct_get_names(__attr);
			for (var i = 0; i < array_length(_names); i++) {
				variable_struct_set(self, _names[i], 
					variable_struct_get(__attr,  _names[i]));
			}
		}, __attr);
	}
}

/// @function:		sc_gui_config_syn_add_other_attr_value(__self_attr, __attr) 
/// @description:	Gui config_func node sync attribute from other attr_val.
/// @param:         {__self_attr} {struct} sc_gui_config_attr_value
/// @param:         {__attr}      {struct} set attribute value
function sc_gui_config_syn_add_other_attr_value(__self_attr, __attr)
{
	with (__self_attr) {
		sc_base_m2s_call(function(__attr) {
			if (is_undefined(__attr)) {
				exit;
			}
			var _names = variable_struct_get_names(__attr);
			for (var i = 0; i < array_length(_names); ++i) {
				var _realname = sc_gui_config_attr_alias_get(self, _names[i]);
				var _parse = sc_gui_config_attr_parse_get(self,
					is_undefined(_realname) ?_names[i] : _realname);
				if (!is_undefined(_parse)) {
					_parse(__attr, _names[i], _realname, self);
				} else {
					variable_struct_set(self, 
						(is_undefined(_realname) ?_names[i] : _realname), 
						variable_struct_get(__attr,  _names[i]));
				}
			}
		}, __attr);
	}
}

/// @function:		sc_gui_config_attr_value_set(__self, __attr) 
/// @description:	Gui config_func node set attribute value.
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}
/// @param:         {__attr}     {struct} attribute value
function sc_gui_config_attr_value_set(__self, __attr)
{
	gml_pragma("forceinline");
	sc_assert(is_struct(__attr), "[sc_gui_config_attr_value_set] attr type error!");
	var _value = sc_gui_global_config_get(global.gui.config_attr_value, 
		global.gui_preload.factor_attr_value, __self);
	sc_gui_config_syn_add_other_attr_value(_value, __attr);
}

/// @function:		sc_gui_config_attr_value_get(__self) 
/// @description:	Gui config_func node get attribute value.
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS} (array or value)
function sc_gui_config_attr_value_get(__self)
{
	gml_pragma("forceinline");
	return sc_gui_global_config_get(global.gui.config_attr_value, 
		undefined, __self);
}

/// @function:		sc_gui_config_attr_value0(__classid, __inherit) 
/// @description:	Gui constructor attribute empty value struct.
/// @param:         {__classid} {real or GUI_CLASS} class id
/// @param:         {__inherit} {real or GUI_CLASS} inherit class id
function sc_gui_config_attr_value0(__classid, __inherit) constructor {
	var _value = sc_gui_config_attr_value_get({cid : __inherit, inherit : GUI_CLASS.DEFAULT});
	/*class id*/
	cid = __classid;
	inherit = _value.inherit;
	
	sc_gui_config_syn_other_attr_value(self, _value);
}

/// @function:		sc_gui_config_attr_value(__classid) 
/// @description:	Gui constructor attribute value struct.
/// @param:         {__classid} {real or GUI_CLASS} class id
function sc_gui_config_attr_value(__classid) constructor {
	/*class id*/
	cid = __classid;
	inherit = GUI_CLASS.DEFAULT;
	
	block_x = 0;
	block_y = 0;
	/* specification (是否需要百分比需要考虑)*/
	//spec_type = GUI_VALUE_TYPE.PIXEL;
	spec_row = 1;
	spec_col = 1;
	spec_width = 0;
	spec_height = 0;
	max_width = 0;
	max_height = 0;
	/* anchor < 0 (表示百分比), inner block wh */
	anchor_width = 0;
	anchor_height = 0;
	/* margin (< 0 表示百分比, >= 1表示px) */
	margin_type = GUI_VALUE_TYPE.PIXEL;
	margin_top = 0;
	margin_bottom = 0;
	margin_left = 0; 
	margin_right = 0;
	/* padding */
	padding_top = 0;
	padding_bottom = 0;
	padding_left = 0;
	padding_right = 0;
	/* flex */
	flex_algin = GUI_FLEX_ALIGN.START;
	flex_justify = GUI_FLEX_JUSTIFY.START;
	/* span */
	span_w = 0;
	span_h = 0;
	/* block_direct: Defined next node add direct current node inherit prev node direct */ 
	block_direct = GUI_FLEX_DIRECT.INHERT;
	/* color */
	color = undefined;
	/* rotate */
	rotate = 0;
	/* alpha */
	alpha = 1;
	/* scale */
	scale_x = 1;
	scale_y = 1;
	
	/* attr_shape => shape */
	attr_shape = { type : "rect" };
	attr_scroll = undefined;
	attr_scale = undefined;
	attr_animation = undefined;
	
	// keyboard
	keyboard_observe = undefined;

	/* flag */
	flag_hover_lock = true;             // [true] if is hover or press, will keep hover. (see goods)
	flag_hover_hole = false;            // this node can't hovered but still to check hover.
	flag_stretch = false;               // stretch node width or height to parent's boundray
	flag_crlf = false;                  // carriage return/line feed CRLF
	flag_wrap = false;                  // only support flex type
	flag_cutoff = false;                // cut off delivery event 
	flag_visable = true;                // if it is true, node will check hover and draw
	flag_scroll = GUI_AXIS_TYPE.NONE;   // fix scrollbar
	flag_scale = GUI_AXIS_TYPE.NONE;

	/* store */
	store_data = undefined;

	func = array_create(GUI_FUNC_TYPE.MAX, undefined);
	func[@ GUI_FUNC_TYPE.CHECK_HOVER] = method(undefined, sc_gui_config_default_check_hover);
	func[@ GUI_FUNC_TYPE.CHECK_HOVER_SCALE] = method(undefined, sc_gui_node_check_scalebar);
	func[@ GUI_FUNC_TYPE.CHECK_HOVER_SCROLL] = method(undefined, sc_gui_node_check_scrollbar);
	func[@ GUI_FUNC_TYPE.CHECK_HOVER_CHILDS] = method(undefined, sc_gui_node_check_childs);

	func[@ GUI_FUNC_TYPE.CHECK_PRESS] = method(undefined, sc_gui_config_default_check_press);
	func[@ GUI_FUNC_TYPE.CHECK_RELEASE] = method(undefined, sc_gui_config_default_check_release);
	
	func[@ GUI_FUNC_TYPE.OBSERVE_PRESS] = method(undefined, sc_base_empty_call);
	func[@ GUI_FUNC_TYPE.OBSERVE_RELEASE] = method(undefined, sc_base_empty_call);
	
	func[@ GUI_FUNC_TYPE.ON_HOVER] = method(undefined, sc_base_empty_call);
	func[@ GUI_FUNC_TYPE.ON_AWAY] = method(undefined, sc_base_empty_call);
	func[@ GUI_FUNC_TYPE.ON_FOCUS] = method(undefined, sc_base_empty_call);
	func[@ GUI_FUNC_TYPE.ON_BLUR] = method(undefined, sc_base_empty_call);
	
	func[@ GUI_FUNC_TYPE.ON_WHEEL_UP] = undefined; 
	func[@ GUI_FUNC_TYPE.ON_WHEEL_DOWN] = undefined;
	func[@ GUI_FUNC_TYPE.ON_PRESS] = method(undefined, sc_gui_config_default_on_press);
	func[@ GUI_FUNC_TYPE.ON_HOLD] = method(undefined, sc_base_empty_call);
	func[@ GUI_FUNC_TYPE.ON_RELEASE] = method(undefined, sc_base_empty_call);
	func[@ GUI_FUNC_TYPE.ON_INPUT] = method(undefined, sc_base_empty_call);
	
	func[@ GUI_FUNC_TYPE.ON_MOVE] = method(undefined, sc_base_empty_call);
	func[@ GUI_FUNC_TYPE.ON_SCALE] = method(undefined, sc_base_empty_call);
	func[@ GUI_FUNC_TYPE.ON_SCROLL] = method(undefined, sc_base_empty_call);
	func[@ GUI_FUNC_TYPE.ON_DRAG] = method(undefined, sc_base_empty_call);
	
	func[@ GUI_FUNC_TYPE.ON_INIT_BEGIN] = method(undefined, sc_gui_node_begin);
	func[@ GUI_FUNC_TYPE.ON_INIT_END] = method(undefined, sc_gui_node_end);
	func[@ GUI_FUNC_TYPE.ON_INIT_READY] = method(undefined, sc_base_empty_call);
	func[@ GUI_FUNC_TYPE.ON_DESTORY] = method(undefined, sc_gui_node_destroy);

	func[@ GUI_FUNC_TYPE.ON_UPDATE] = method(undefined, sc_base_empty_call);
	func[@ GUI_FUNC_TYPE.ON_STEP] = method(undefined, sc_base_empty_call);
	
	func[@ GUI_FUNC_TYPE.ON_DRAW] = method(undefined, sc_gui_node_draw);
	func[@ GUI_FUNC_TYPE.DRAW_BACKWARD] = method(undefined, sc_base_empty_call);
	func[@ GUI_FUNC_TYPE.DRAW_FORWARD] = method(undefined, sc_base_empty_call);
	func[@ GUI_FUNC_TYPE.DRAW_GRIDS] = method(undefined, sc_gui_node_draw_gridding);
	func[@ GUI_FUNC_TYPE.DRAW_BORDER] = method(undefined, sc_gui_node_draw_border);
	func[@ GUI_FUNC_TYPE.DRAW_BACKGROUND] = method(undefined, sc_gui_node_draw_backgroud);
	func[@ GUI_FUNC_TYPE.DRAW_DECORATE] = method(undefined, sc_gui_node_draw_decorate);
	func[@ GUI_FUNC_TYPE.DRAW_CHILDS] = method(undefined, sc_gui_node_draw_childs);

	func[@ GUI_FUNC_TYPE.DATA_GET] = method(undefined, function() {return store_data;});
	func[@ GUI_FUNC_TYPE.DATA_SET] = method(undefined, function() { return false; });
}

