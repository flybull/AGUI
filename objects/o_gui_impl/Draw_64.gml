var _node;

var n = array_length(stack_focus);
for (var i = 0; i < n; ++i) {
	with (stack_focus[i]) {
		sc_gui_global_queue_idempotent_mark();
		origin.status_skip = true;
		origin.status_draw = true; //focus node需要持续绘制，表示处于激活
	}
}
_node = sc_gui_global_node_find(hover_origin_id);
if (!is_undefined(_node)) {
	with (_node) {
		sc_gui_global_queue_idempotent_mark();
		origin.status_skip = true;		
	}
}
_node = sc_gui_global_node_find(hold_node_id);
if (!is_undefined(_node)) {
	with (_node.origin) {
		sc_gui_global_queue_idempotent_mark();
		origin.status_skip = true;		
	}
}
sc_ds_list_foreach(list_node, function() {
	if (!status_skip) {
		if (flag_visable) {
			func[GUI_FUNC_TYPE.ON_DRAW]();
		}
	} else {
		status_skip = false;
	}
});

sc_gui_global_queue_idempotent_unmark(function() {
	if (flag_visable) {
		func[GUI_FUNC_TYPE.ON_DRAW]();
	}
});


#region "DEBUG"
sc_gui_debug_draw_hover();
#endregion

