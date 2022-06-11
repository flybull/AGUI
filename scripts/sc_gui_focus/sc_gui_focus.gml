/// @function		sc_gui_node_focus_api()
/// @description	Don't use it. only a declaration.
function sc_gui_node_focus_api()
{
	sc_gui_node_insert_focus();
	sc_gui_node_remove_focus();
}

/// @function		sc_gui_node_insert_focus()
/// @description	Insert node into gobal focus statck.
function sc_gui_node_insert_focus()
{
	var _stack_focus = global.gui.stack_focus;
	var n = array_length(_stack_focus);
	var _node = n == 0 ? undefined : _stack_focus[n - 1];
	while (!is_undefined(_node)) {
		if (_node == self) {
			exit;
		}
		var _fid = origin.fid;
		var _friend = is_undefined(_fid) ? undefined : _node.friends[? _fid];
		// 如果属于同一链路上则不失去焦点
		if ((!is_undefined(_friend) && _friend == origin) || parent == _node) {
			array_push(_stack_focus, self);
			status_focus = true;
			origin.status_draw = true;
			func[GUI_FUNC_TYPE.ON_FOCUS]();
			exit;
		}
		with (array_pop(_stack_focus)) {
			var n = array_length(_stack_focus);
			_node = n == 0 ? undefined : _stack_focus[n - 1];
			status_focus = false;
			origin.status_draw = true;
			func[GUI_FUNC_TYPE.ON_BLUR]();
		}
	}
	if (is_undefined(_node)) {
		array_push(_stack_focus, self);
		status_focus = true;
		origin.status_draw = true;
		func[GUI_FUNC_TYPE.ON_FOCUS]();
	}
}

/// @function		sc_gui_node_remove_focus()
/// @description	remove all node from gobal focus statck.
function sc_gui_node_remove_focus()
{
	gml_pragma("forceinline");
	var _stack_focus = global.gui.stack_focus;
	for (var _node = array_pop(_stack_focus);
		!is_undefined(_node);
		_node = array_pop(_stack_focus)) {
		with (_node) {
			status_focus = false;
			origin.status_draw = true;
			func[GUI_FUNC_TYPE.ON_BLUR]();
		}
	}
}
