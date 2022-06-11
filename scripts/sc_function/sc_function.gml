#macro sc_assert_debug sc_assert

/// @function:		sc_assert(__condv, __info)
/// @description:	assert check
/// @param:			{__condv} bool
/// @param:         {__info} string
function sc_assert(__condv, __info="err") {
	gml_pragma("forceinline");
	if (!__condv) {
		throw(__info);
	}
}


/// @function:		sc_base_safe_call(__func, __args)
/// @description:	safe call function or script
/// @param:			{__func} function or script id
/// @param:         {__args} The arguments(struct\array\...)
function sc_base_safe_call(__func, __args = undefined) {
	gml_pragma("forceinline");

	if (is_method(__func)) {
		method(undefined, __func)(__args);
	} else if (is_numeric(__func)){
		script_execute(__func, __args);
	} else {
		sc_assert(false, "[sc_gui_foreach] type:" + typeof(__func)+ ", need method or script_id(numeric) type");
	}
}

/// @function:		sc_base_safe_call_r(__func, __args)
/// @description:	safe call function or script and return
/// @param:			{__func} function or script id
/// @param:         {__args} The arguments(struct\array\...)
function sc_base_safe_call_r(__func, __args = undefined) {
	gml_pragma("forceinline");

	if (is_method(__func)) {
		return method(undefined, __func)(__args);
	} else if (is_numeric(__func)){ 
		return script_execute(__func, __args);
	} else {
		sc_assert(false, "[sc_gui_foreach] type:" + typeof(__func) + ", need method or script_id(numeric) type");
	}
}

/// @function:		sc_base_m2s_call(__func, __param)
/// @description:	mulity to once param call function
/// @param:			{__func} function or script id
/// @param:         {__param}  The  arguments(struct\array\...)
function sc_base_m2s_call(__func, __param) {
	gml_pragma("forceinline");
	if (is_array(__param)) {
		for (var i = 0; i < array_length(__param); ++i) {
			sc_base_safe_call(__func, __param[i]);
		}
	} else {
		sc_base_safe_call(__func, __param);
	}
}

/// @function:		sc_base_empty_call()
/// @description:	empty script call
function sc_base_empty_call() {
	gml_pragma("forceinline");
}

