function sc_gui_list_ref(__list, __obj)
{
	gml_pragma("forceinline");
	ds_list_add(__list, __obj);
	__obj.refcount++;
}

function sc_gui_list_add(__list, __obj)
{
	gml_pragma("forceinline");
	sc_assert_debug(is_undefined(__obj.list_pos));
	ds_list_add(__list, __obj);
	__obj.refcount++;
	__obj.list_pos = ds_list_size(__list) - 1;
}

function sc_gui_list_insert(__list, __obj, __pos)
{
	gml_pragma("forceinline");
	sc_assert_debug(is_undefined(__obj.list_pos));
	ds_list_insert(__list, __pos, __obj);
	__obj.refcount++;
	var n = ds_list_size(__list);
	for (var i = __pos; i < n; ++i) {
		__list[| i].list_pos = i;
	}
}

function sc_gui_list_delete(__list, __obj)
{
	gml_pragma("forceinline");
	sc_assert_debug(!is_undefined(__obj.list_pos));
	var i = __obj.list_pos;
	var n = ds_list_size(__list);
	if (n <= i || __list[| i].sid != __obj.sid) {
		sc_assert(false, "Can't found!");
		exit;
	}
	ds_list_delete(__list, __obj.list_pos);
	for (n = ds_list_size(__list); i < n; ++i) {
		__list[| i].list_pos = i;
	}
	__obj.list_pos = undefined;
	__obj.refcount--;
}

function sc_gui_list_destroy(__list, __func_destroy)
{
	gml_pragma("forceinline");
	var n = ds_list_size(__list);
	for (var i = 0; i < n; ++i) {
		var _node = __list[| i];
		_node.refcount--;
		if (_node.refcount > 0) {
			continue;
		}
		with (_node) {
			sc_base_safe_call(__func_destroy);
		}
		delete _node;
		__list[| i] = undefined;
	}
	ds_list_clear(__list);
	ds_list_destroy(__list);
}
