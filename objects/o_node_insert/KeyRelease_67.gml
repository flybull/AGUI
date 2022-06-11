var _size = ds_list_size(gui_node.childs[| 0].childs);
if (_size > 1) {
	var _node = gui_node.childs[| 0].childs[| (_size - 1)];
	sc_gui_node_event_delete_by_obj(_node);
}
