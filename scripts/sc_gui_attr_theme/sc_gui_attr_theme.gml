enum GUI_THEME_TYPE {
	BACKDROP,
	BORDER,
	CURSOR,
	SPRITE,
	SCROLLBAR_BG,
	SCROLLBAR_BT,
	SCROLLBAR_BR,
	INDICAT,
	TEXT,
}

enum GUI_THEME {
	BACKDROP_COLOR_NORM,
	BACKDROP_COLOR_FOCUS,
	BACKDROP_COLOR_HOVER,
	BACKDROP_COLOR_PRESS,

	BORDER_COLOR_NORM,
	BORDER_COLOR_FOCUS,
	BORDER_COLOR_HOVER,
	BORDER_COLOR_PRESS,

	CURSOR_COLOR_NORM,
	CURSOR_COLOR_FOCUS,
	CURSOR_COLOR_HOVER,
	CURSOR_COLOR_PRESS,
	
	SPRITE_COLOR_NORM,
	SPRITE_COLOR_FOCUS,
	SPRITE_COLOR_HOVER,
	SPRITE_COLOR_PRESS,

	SCROLLBAR_BG_COLOR_NORM,
	SCROLLBAR_BG_COLOR_FOCUS,
	SCROLLBAR_BG_COLOR_HOVER,
	SCROLLBAR_BG_COLOR_PRESS,
	
	SCROLLBAR_BT_COLOR_NORM,
	SCROLLBAR_BT_COLOR_FOCUS,
	SCROLLBAR_BT_COLOR_HOVER,
	SCROLLBAR_BT_COLOR_PRESS,
	
	SCROLLBAR_BR_COLOR_NORM,
	SCROLLBAR_BR_COLOR_FOCUS,
	SCROLLBAR_BR_COLOR_HOVER,
	SCROLLBAR_BR_COLOR_PRESS,

	INDICAT_COLOR_PASS,
	INDICAT_COLOR_BAN,
	INDICAT_COLOR_WARN,
	INDICAT_COLOR_WAIT,

	TEXT_COLOR_NORM,
	TEXT_COLOR_FOCUS,
	TEXT_COLOR_HOVER,
	TEXT_COLOR_PRESS,

	TEXT_FONT,
	MAX,
}

/// @function:		sc_gui_config_attr_theme_construct() 
/// @description:	Gui config_func attribute theme construct.
function sc_gui_config_attr_theme_construct()
{
	gml_pragma("global", "sc_gui_config_attr_theme_construct()");
	var _class = { cid : GUI_CLASS.DEFAULT, inherit : GUI_CLASS.DEFAULT};
	sc_gui_global_preload_set_factor(
		global.gui_preload.factor_attr_theme,
		_class,
		function(__class)   { return array_create(GUI_THEME.MAX, undefined);},
		function(__obj)		{ array_delete(__obj, 0, GUI_THEME.MAX); },
		sc_gui_config_attr_theme_clone,
		sc_gui_config_attr_theme_syn_default,
	);
}

/// @function:		sc_gui_config_attr_theme_build() 
/// @description:	Gui config_func attribute theme build.
function sc_gui_config_attr_theme_build()
{
	if (!is_undefined(global.gui.config_attr_theme)) {
		exit;
	}
	global.gui.config_attr_theme = sc_gui_global_config_construct(
		global.gui_preload.factor_attr_theme);
	sc_gui_global_config_build(global.gui_preload.factor_attr_theme);
}

/// @function:		sc_gui_global_attr_theme_destroy() 
/// @description:	Gui config_func attribute theme destroy.
function sc_gui_global_attr_theme_destroy()
{
	if (is_undefined(global.gui.config_attr_theme)) {
		exit;
	}
	sc_gui_global_config_destroy(global.gui.config_attr_theme, 
		global.gui_preload.factor_attr_theme);
	global.gui.config_attr_theme = undefined;
}

/// @function:		sc_gui_config_attr_theme_syn_default(__self) 
/// @description:	Gui config_func theme construct set default value.
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}
function sc_gui_config_attr_theme_syn_default(__self)
{
	sc_gui_config_attr_theme_set(__self, GUI_THEME.BACKDROP_COLOR_NORM,  c_white );
	sc_gui_config_attr_theme_set(__self, GUI_THEME.BACKDROP_COLOR_FOCUS, c_white );
	sc_gui_config_attr_theme_set(__self, GUI_THEME.BACKDROP_COLOR_HOVER, c_gray  );
	sc_gui_config_attr_theme_set(__self, GUI_THEME.BACKDROP_COLOR_PRESS, c_dkgray);
	sc_gui_config_attr_theme_set(__self, GUI_THEME.BORDER_COLOR_NORM   , c_blue  );
	sc_gui_config_attr_theme_set(__self, GUI_THEME.BORDER_COLOR_FOCUS  , c_green );
	sc_gui_config_attr_theme_set(__self, GUI_THEME.BORDER_COLOR_HOVER  , c_orange);
	sc_gui_config_attr_theme_set(__self, GUI_THEME.BORDER_COLOR_PRESS  , c_red   );
	sc_gui_config_attr_theme_set(__self, GUI_THEME.CURSOR_COLOR_NORM   , c_black );
	sc_gui_config_attr_theme_set(__self, GUI_THEME.CURSOR_COLOR_FOCUS  , c_black );
	sc_gui_config_attr_theme_set(__self, GUI_THEME.CURSOR_COLOR_HOVER  , c_black );
	sc_gui_config_attr_theme_set(__self, GUI_THEME.CURSOR_COLOR_PRESS  , c_black );
	sc_gui_config_attr_theme_set(__self, GUI_THEME.SPRITE_COLOR_NORM   , c_white );
	sc_gui_config_attr_theme_set(__self, GUI_THEME.SPRITE_COLOR_FOCUS  , c_orange);
	sc_gui_config_attr_theme_set(__self, GUI_THEME.SPRITE_COLOR_HOVER  , $eeeeee );
	sc_gui_config_attr_theme_set(__self, GUI_THEME.SPRITE_COLOR_PRESS  , $cccccc );

	
	sc_gui_config_attr_theme_set(__self, GUI_THEME.SCROLLBAR_BG_COLOR_NORM   , c_dkgray);
	sc_gui_config_attr_theme_set(__self, GUI_THEME.SCROLLBAR_BG_COLOR_FOCUS  , c_dkgray);
	sc_gui_config_attr_theme_set(__self, GUI_THEME.SCROLLBAR_BG_COLOR_HOVER  , c_dkgray);
	sc_gui_config_attr_theme_set(__self, GUI_THEME.SCROLLBAR_BG_COLOR_PRESS  , c_dkgray);
	
	sc_gui_config_attr_theme_set(__self, GUI_THEME.SCROLLBAR_BT_COLOR_NORM   , c_silver );
	sc_gui_config_attr_theme_set(__self, GUI_THEME.SCROLLBAR_BT_COLOR_FOCUS  , c_silver   );
	sc_gui_config_attr_theme_set(__self, GUI_THEME.SCROLLBAR_BT_COLOR_HOVER  , $eeeeee);
	sc_gui_config_attr_theme_set(__self, GUI_THEME.SCROLLBAR_BT_COLOR_PRESS  , $cccccc  );
	
	sc_gui_config_attr_theme_set(__self, GUI_THEME.SCROLLBAR_BR_COLOR_NORM   , c_black);
	sc_gui_config_attr_theme_set(__self, GUI_THEME.SCROLLBAR_BR_COLOR_FOCUS  , c_black);
	sc_gui_config_attr_theme_set(__self, GUI_THEME.SCROLLBAR_BR_COLOR_HOVER  , c_black );
	sc_gui_config_attr_theme_set(__self, GUI_THEME.SCROLLBAR_BR_COLOR_PRESS  , c_black );
	
	sc_gui_config_attr_theme_set(__self, GUI_THEME.INDICAT_COLOR_PASS  , c_green );
	sc_gui_config_attr_theme_set(__self, GUI_THEME.INDICAT_COLOR_BAN   , c_red   );
	sc_gui_config_attr_theme_set(__self, GUI_THEME.INDICAT_COLOR_WARN  , c_orange);
	sc_gui_config_attr_theme_set(__self, GUI_THEME.INDICAT_COLOR_WAIT  , c_blue  );
	
	sc_gui_config_attr_theme_set(__self, GUI_THEME.TEXT_COLOR_FOCUS    , c_black );
	sc_gui_config_attr_theme_set(__self, GUI_THEME.TEXT_COLOR_NORM     , c_black );
	sc_gui_config_attr_theme_set(__self, GUI_THEME.TEXT_COLOR_HOVER    , c_black );
	sc_gui_config_attr_theme_set(__self, GUI_THEME.TEXT_COLOR_PRESS    , c_black );
	sc_gui_config_attr_theme_set(__self, GUI_THEME.TEXT_FONT           , Font1   );
}

/// @function:		sc_gui_config_attr_theme_clone(__self) 
/// @description:	Gui config_func attribute theme clone.
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}
function sc_gui_config_attr_theme_clone(__self)
{
	gml_pragma("forceinline");
	var _classid = __self.cid;
	var _inherit = __self.inherit;
	var _theme = array_create(GUI_THEME.MAX, undefined);
	if (sc_gui_is_fast_classid(_inherit)) {
		array_copy(_theme, 0, global.gui.config_attr_theme[@ GUI_CLASS.DEFAULT], 0, GUI_THEME.MAX);
	} else {
		array_copy(_theme, 0, global.gui.config_attr_theme[@ GUI_CLASS.MAX][? _inherit], 0, GUI_THEME.MAX);
	}
	global.gui.config_attr_theme[@ GUI_CLASS.MAX][? _classid] = _theme;
	return _theme;
}

/// @function:		sc_gui_config_attr_theme_set(__self, __type, __value) 
/// @description:	Gui config_func set theme.
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}
/// @param:         {__type}   {GUI_THEME}
/// @param:         {__value}  any
function sc_gui_config_attr_theme_set(__self, __type, __value)
{
	var _theme = sc_gui_global_config_get(global.gui.config_attr_theme, 
			global.gui_preload.factor_attr_theme, __self);

	_theme[@ __type] = __value;
}

/// @function:		sc_gui_config_attr_theme_get(__self, __type) 
/// @description:	Gui config_func theme get.
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}
/// @param:         {__type}   {GUI_THEME}
function sc_gui_config_attr_theme_get(__self, __type)
{
	gml_pragma("forceinline");
	var _theme = sc_gui_global_config_get( global.gui.config_attr_theme, 
			global.gui_preload.factor_attr_theme, __self);
	return _theme[@ __type];
}

/// @function:		sc_gui_config_attr_theme_get_by_stat(__self, __type, __stat) 
/// @description:	Gui config_func theme get by status_stat.
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}
/// @param:         {__type}   {GUI_THEME_TYPE}
/// @param:         {__stat}   {status_bits}
function sc_gui_config_attr_theme_get_by_stat(__self, __type, __stat)
{
	gml_pragma("forceinline");
	var _theme = sc_gui_global_config_get(global.gui.config_attr_theme, 
			global.gui_preload.factor_attr_theme, __self);
	var _offet;
	switch (__type) {
	case GUI_THEME_TYPE.BACKDROP:
	case GUI_THEME_TYPE.BORDER:
	case GUI_THEME_TYPE.CURSOR:
	case GUI_THEME_TYPE.SPRITE:
	case GUI_THEME_TYPE.SCROLLBAR_BG:
	case GUI_THEME_TYPE.SCROLLBAR_BT:
	case GUI_THEME_TYPE.SCROLLBAR_BR:
	case GUI_THEME_TYPE.TEXT:
		_offet = __type * 4;
		break;
	default: return undefined;
	}
	if (__stat & GUI_STATUS.PRESS) {
		return _theme[@ _offet + 3];
	} else if (__stat & GUI_STATUS.HOVER) {
		return _theme[@ _offet + 2];
	} else if (__stat & GUI_STATUS.FOCUS) {
		return _theme[@ _offet + 1];
	} else {
		return _theme[@ _offet];
	}
}