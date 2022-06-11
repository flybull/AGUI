function sc_gui_node_event_delete_by_obj(__node)
{
	gml_pragma("forceinline");
	sc_gui_global_event_xmit({src_uri: "/sid/" + string(__node.sid), type : GUI_EVENT.DELETE});
}

function sc_gui_node_event_delete_by_uri(__src_uri)
{
	gml_pragma("forceinline");
	sc_gui_global_event_xmit({src_uri: __src_uri, type : GUI_EVENT.DELETE});
}

function sc_gui_node_event_delete(__ev)
{
	var _src = sc_gui_node_uri_router(__ev.src_uri);
	if (is_undefined(_src)) {
		exit;
	}
	var _parent = _src.parent;
	if (is_undefined(_parent)) {
		sc_gui_list_delete(global.gui.list_node, _src);
	} else {
		sc_gui_list_delete(_parent.childs, _src);
		sc_gui_grid2_unmark_complex(_src);
		with (_src.origin) {
			sc_ds_list_foreach_before("childs", sc_gui_update_prepare_self);
			sc_gui_global_queue_idempotent_mark();
		}
	}
	with (_src) {
		if (sid == global.gui.hover_node_id) {
			sc_gui_node_set_away();
		}
		func[GUI_FUNC_TYPE.ON_DESTORY]();
		sc_gui_global_node_release();
	}

	delete _src;
}
