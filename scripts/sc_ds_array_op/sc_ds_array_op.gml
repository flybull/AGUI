/// @function:		sc_ds_array_foreach(__array, __function_doing, [eventArgs=undefined])
/// @description:	foreach array
/// @param:         {ds_array} array 
/// @param:			{function/numeric} function or script_id
/// @param:         {Realm}  The  arguments(struct\array\...) function(args = [i, undefined]);
function sc_ds_array_foreach(__array, __function_doing, __function_args = undefined) {
	gml_pragma("forceinline");
	var n = array_length(__array);
	for (var i = 0; i < n; ++i) {
		var _value = __array[@ i];
		if (is_undefined(_value)) {
			continue;
		}
		with(_value) {
			sc_base_safe_call(__function_doing, [i, __function_args]);
		}
	}
}

/// @function:		sc_ds_array_foreach_be(__array, __begin, __end, __function_doing, [eventArgs=undefined])
/// @description:	foreach array begin to end
/// @param:         {ds_array} array 
/// @param:			{function/numeric} function or script_id
/// @param:         {Realm}  The  arguments(struct\array\...) function(args = [i, undefined]);
function sc_ds_array_foreach_be(__array, __begin, __end, __function_doing, __function_args = undefined) {
	gml_pragma("forceinline");
	var n = array_length(__array);
	n = __end < n ? __end : n;
	for (var i = __begin > 0 ? __begin : 0; i < n; ++i) {
		var _value = __array[@ i];
		if (is_undefined(_value)) {
			continue;
		}
		with(_value) {
			sc_base_safe_call(__function_doing, [i, __function_args]);
		}
	}
}




