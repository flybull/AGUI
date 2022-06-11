// see [device_mouse_check_button]
// window_mouse_get_x();
// window_mouse_get_y();
device_x = device_mouse_x(device_slot);
device_y = device_mouse_y(device_slot);

#region "process node's event(curd)"
// 1.先标记同步数据
for (var _ev = ds_queue_dequeue(queue_curd_event);
	!is_undefined(_ev);
	_ev = ds_queue_dequeue(queue_curd_event)) {
	
	switch(_ev.type) {
	case GUI_EVENT.CREATE:
		sc_gui_node_event_create(_ev.args);
		break;
	case GUI_EVENT.INSERT:
		sc_gui_node_event_insert(_ev);
		break;
	case GUI_EVENT.UPDATE:
		var _node = pool_used_node[_ev.sid];
		with (_node) {
			sc_gui_node_event_update(_ev);
		}
		break;
	case GUI_EVENT.RETRIEVE:
		break;
	case GUI_EVENT.DELETE:
		sc_gui_node_event_delete(_ev);
		break;
	}
}

// 2.更新节点数据
sc_gui_global_queue_idempotent_unmark(function() {
	sc_gui_update_execute();
});
#endregion

scheme.scanner();
