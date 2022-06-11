/// @function:		sc_ds_list_foreach_before(__list_name, __function_doing, [eventArgs=undefined])
/// @description:	foreach self and childs
/// @param:         {string} list name
/// @param:			{function/numeric} function or script_id
/// @param:         {Realm}  The  arguments(struct\array\...)
function sc_ds_list_foreach_before(__list_name, __function_doing, __function_args = undefined) {
	sc_base_safe_call(__function_doing, __function_args);
	var _list = variable_struct_get(self, __list_name);
	if (!is_undefined(_list)) {
		var n = ds_list_size(_list);
		for (var i = 0; i < n; ++i) {
			with(_list[| i]) {
				sc_ds_list_foreach_before(__list_name, __function_doing, __function_args);
			}
		}
	}
}

/// @function:		sc_ds_list_foreach_after(__list_name, __function_doing, [eventArgs=undefined])
/// @description:	foreach childs and self 
/// @param:         {string} list name
/// @param:			{function/numeric} function or script_id
/// @param:         {Realm}  The  arguments(struct\array\...)
function sc_ds_list_foreach_after(__list_name, __function_doing, __function_args = undefined) {
	var _list = variable_struct_get(self, __list_name);
	if (!is_undefined(_list)) {
		var n = ds_list_size(_list);
		for (var i = 0; i < n; ++i) {
			with(_list[| i]) {
				sc_ds_list_foreach_after(__list_name, __function_doing, __function_args);
			}
		}
	}
	sc_base_safe_call(__function_doing, __function_args);
}

/// @function:		sc_ds_list_foreach_all(__list_name, __function_doing, [eventArgs=undefined])
/// @description:	foreach list (recursion)
/// @param:         {string} list name
/// @param:			{function/numeric} function or script_id
/// @param:         {Realm}  The  arguments(struct\array\...)
function sc_ds_list_foreach_all(__list_name, __function_doing, __function_args = undefined) {
	var _list = variable_struct_get(self, __list_name);
	if (!is_undefined(_list)) {
		var n = ds_list_size(_list);
		for (var i = 0; i < n; ++i) {
			with(_list[| i]) {
				sc_base_safe_call(__function_doing, __function_args);
				sc_ds_list_foreach_all(__list_name, __function_doing, __function_args);
			}
		}
	}
}

/// @function:		sc_ds_list_foreach(__list, __function_doing, [eventArgs=undefined])
/// @description:	foreach list
/// @param:         {ds_list} list 
/// @param:			{function/numeric} function or script_id
/// @param:         {Realm}  The  arguments(struct\array\...)
function sc_ds_list_foreach(__list, __function_doing, __function_args = undefined) {
	if (!is_undefined(__list)) {
		var n = ds_list_size(__list);
		for (var i = 0; i < n; ++i) {
			with(__list[| i]) {
				sc_base_safe_call(__function_doing, __function_args);
			}
		}
	}
}

/// @function:		sc_ds_list_find(__list_name, __function_doing, [eventArgs=undefined])
/// @description:	foreach list for find a elem by list name
/// @param:         {string} list name
/// @param:			{function/numeric} function or script_id
/// @param:         {Realm}  The  arguments(struct\array\...)
function sc_ds_list_find(__list_name, __function_doing, __function_args = undefined) {
	var _list = variable_struct_get(self, __list_name);
	if (!is_undefined(_list)) {
		var n = ds_list_size(_list);
		for (var i = 0; i < n; ++i) {
			with(_list[| i]) {
				if (sc_base_safe_call_r(__function_doing, __function_args)) {
					return _list[| i];
				}
			}
		}
	}
	return undefined;
}

/// @function:		sc_ds_list_find_direct(__list, __function_doing, [eventArgs=undefined])
/// @description:	foreach list for find a elem by ds_list
/// @param:         {ds_list} ds_list value
/// @param:			{function/numeric} function or script_id
/// @param:         {Realm}  The  arguments(struct\array\...)
function sc_ds_list_find_direct(__list, __function_doing, __function_args = undefined) {
	var _list = __list;
	if (!is_undefined(_list)) {
		var n = ds_list_size(_list);
		for (var i = 0; i < n; ++i) {
			with(_list[| i]) {
				if (sc_base_safe_call_r(__function_doing, __function_args)) {
					return _list[| i];
				}
			}
		}
	}
	return undefined;
}

/// @function:		sc_ds_list_delete(__list, __obj)
/// @description:	delete a elem in list
/// @param:         {ds_list} ds_list value
/// @param:			{any} __obj
function sc_ds_list_delete(__list, __obj)
{
	gml_pragma("forceinline");

	var n = ds_list_size(__list);
	for (var i = 0; i < n; ++i) {
		if (__list[| i] == __obj) {
			ds_list_delete(__list, i);
			exit;
		}
	}
}

