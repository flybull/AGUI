global.gui_preload = {
	factor_class_map : ds_map_create(),
	factor_class_constructor : array_create(GUI_CLASS.MAX, undefined),
	factor_class_construct : array_create(GUI_CLASS.MAX, undefined),
	factor_attr_theme : array_create(GUI_CLASS.MAX, undefined),
	factor_attr_parse : array_create(GUI_CLASS.MAX, undefined),
	factor_attr_alias : array_create(GUI_CLASS.MAX, undefined),
	factor_attr_value : array_create(GUI_CLASS.MAX, undefined),
}

function sc_gui_config_class_templete(
	__classid, __inherit,
	__function_create,
	__function_destroy, 
	__function_clone = undefined,
	__function_build = undefined) constructor
{
	cid = __classid;
	inherit = __inherit;
	create = method(undefined, __function_create);
	destroy = method(undefined, __function_destroy);
	clone = method(undefined, __function_clone);
	build = is_undefined(__function_build) ? undefined : method(undefined, __function_build);
}

function sc_gui_global_preload_set_factor(
	__factor, __class,
	__function_create, 
	__function_destroy,
	__function_clone = undefined,
	__function_init = undefined)
{
	gml_pragma("forceinline");
	if (sc_gui_is_fast_classid(__class.cid)) {
		__factor[@ __class.cid] = new sc_gui_config_class_templete(
				__class.cid, __class.inherit,
				__function_create, __function_destroy,
				__function_clone, __function_init);
	}
}

function sc_gui_global_set_class_construct(
	__classid, __class_name, 
	__function_construct, __function_constructor)
{
	gml_pragma("forceinline");
	global.gui_preload.factor_class_map[? __class_name] = __classid;
	global.gui_preload.factor_class_construct[@ __classid] = 
		method(undefined, __function_construct);
	global.gui_preload.factor_class_constructor[@ __classid] = 
		is_undefined(__function_constructor) ? undefined : method(undefined, __function_constructor);
}

function sc_gui_global_find_classid(__classname)
{
	gml_pragma("forceinline");
	var _classid = global.gui_preload.factor_class_map[? __classname];
	return sc_gui_is_fast_classid(_classid) ? _classid : __classname;
}

function sc_gui_global_find_create_method(_classid)
{
	gml_pragma("forceinline");
	return !sc_gui_is_fast_classid(_classid) ? undefined :
		global.gui_preload.factor_class_constructor[_classid];
}

function sc_gui_global_load_construct()
{
	gml_pragma("forceinline");
	var _contsruct = global.gui_preload.factor_class_construct;
	for (var classid = 0; classid < GUI_CLASS.MAX; ++classid) {
		if (!is_undefined(_contsruct[classid])) {
			_contsruct[classid]();
		}
	}
}

/// @function:		sc_gui_global_config_construct(__func_new) 
/// @description:	Get node func from global Gui config construct
/// @param:         {__factor} global.gui_preload.?
function sc_gui_global_config_construct(__factor)
{
	var __config = array_create(GUI_CLASS.MAX + 1, undefined);
	for (var __classid = 0; __classid < GUI_CLASS.MAX; ++__classid) {
		if (is_undefined(__factor[__classid])) {
			__config[@ __classid] = __factor[GUI_CLASS.DEFAULT].create({cid : __classid, inherit : GUI_CLASS.DEFAULT});
		} else {
			__config[@ __classid] = __factor[__classid].create({cid : __classid, inherit : GUI_CLASS.DEFAULT});
		}
	}
	__config[@ GUI_CLASS.MAX] = ds_map_create();
	return __config;
}

/// @function:		sc_gui_global_config_destroy(__config, __factor)
/// @description:	Get node func from global Gui config destroy
/// @param:         {__config} config_attr_parse/config_attr_alias/config_attr_value/config_attr_theme
/// @param:         {__factor} global.gui_preload.?
function sc_gui_global_config_destroy(__config, __factor)
{
	for (var __classid = 0; __classid < GUI_CLASS.MAX; ++__classid) {
		if (is_undefined(__factor[__classid])) {
			__factor[GUI_CLASS.DEFAULT].destroy(__config[@ __classid]);
		} else {
			__factor[__classid].destroy(__config[@ __classid]);
		}
		__config[@ __classid] = undefined;
	}
	var size = ds_map_size(__config[@ GUI_CLASS.MAX]);
	var key = ds_map_find_first(__config[@ GUI_CLASS.MAX]);
	for (var i = 0; i < size; i++) {
		__factor[GUI_CLASS.DEFAULT].destroy(__config[@ __classid][? key]);
	    key = ds_map_find_next(__config[@ GUI_CLASS.MAX], key);
 	}
	ds_map_destroy(__config[@ GUI_CLASS.MAX]);
	array_delete(__config, 0, GUI_CLASS.MAX + 1);
}
	

/// @function:		sc_gui_global_config_get(__config, __factor, __self) 
/// @description:	Get node func from global Gui config
/// @param:			{__config} glboal value config_attr_parse\config_attr_alias\config_attr_value
/// @param:         {__factor} 
/// @param:         {__self} {struct : {cid : GUI_CLASS, inherit: GUI_CLASS}
function sc_gui_global_config_get(__config, __factor, __self)
{
	gml_pragma("forceinline");
	var _value;
	var _classid = __self.cid;
	var _fast_flag = sc_gui_is_fast_classid(_classid);
	
	if (_fast_flag) {
		_value = __config[@ _classid];
	} else {
		_value = ds_map_find_value(__config[@ GUI_CLASS.MAX], _classid);
	}
	if (is_undefined(_value)) {
		// Fix it: sc_gui_config_attr_value_get sc_gui_config_attr_parse_get
		// Inheritance is not yet implemented
		if (is_undefined(__factor)) {
			return __config[GUI_CLASS.DEFAULT];
		} else if (!_fast_flag || is_undefined(__factor[_classid])) {
			return __factor[GUI_CLASS.DEFAULT].clone(__self);
		} else {
			return __factor[_classid].clone(__self);
		}
	}

	return _value;
}

/// @function:		sc_gui_global_config_build(__factor) 
/// @description:	Get node func from global Gui config buildup
/// @param:         {__factor} global.gui_preload.?
function sc_gui_global_config_build(__factor)
{
	for (var __classid = 0; __classid < GUI_CLASS.MAX; ++__classid) {
		var _class = __factor[__classid];
		if (!is_undefined(_class)) {
			if (!is_undefined(_class.build)) {
				_class.build(_class);
			}
		} else if (!is_undefined(__factor[GUI_CLASS.DEFAULT].build)) {
			__factor[GUI_CLASS.DEFAULT].build({cid : __classid, inherit: GUI_CLASS.DEFAULT});
		}
	}
}
