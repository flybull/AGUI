#region "hover event"
var _status_skip = { flag : false };
_status_skip.flag = sc_gui_node_event_is_lock();
if (_status_skip.flag) {
	var _node = sc_gui_global_node_find(hover_origin_id);
	with (_node) {
		sc_gui_node_check();
	}
} else {
	var n = array_length(stack_focus);
	for (var i = n - 1; i >= 0; --i) {
		with (stack_focus[i]) {
			sc_gui_global_queue_idempotent_mark();
		}
	}
	sc_gui_global_queue_idempotent_unmark(function(_status_skip) {
		if (!_status_skip.flag) {
			_status_skip.flag = sc_gui_node_check();
		}
	}, _status_skip);

	sc_ds_list_foreach(list_node, function(_status_skip) {
		if (!_status_skip.flag) {
			_status_skip.flag = sc_gui_node_check();
		}
	}, _status_skip);
}
#endregion

// someone node has been hovered
if (!sc_gui_node_event_is_hold()) {
	sc_gui_node_event_input();
}

keyboard_impl.observe();

var n = array_length(stack_focus) - 1;
if (n >= 0) {
	with (stack_focus[n]) {
		func[@ GUI_FUNC_TYPE.ON_INPUT]();
	}
}

