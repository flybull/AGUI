function sc_gui_node_event_insert_by_uri(__dst_uri, __src_uri, __pos = undefined)
{
	gml_pragma("forceinline");
	sc_gui_global_event_xmit({type : GUI_EVENT.INSERT, by : "uri",
		dst_uri : __dst_uri, src_uri : __src_uri, pos : __pos});
}

function sc_gui_node_event_insert_by_args(__dst_uri, __agrs, __pos = undefined)
{
	gml_pragma("forceinline");
	sc_gui_global_event_xmit({type : GUI_EVENT.INSERT, by : "arg",
		dst_uri : __dst_uri, args : __agrs, pos : __pos});
}

function sc_gui_node_event_insert_by_obj(__dst_node, __src_node, __pos = undefined)
{
	gml_pragma("forceinline");
	sc_gui_node_event_insert_by_uri(
		is_undefined(__dst_node) ? undefined : "/sid/" + string(__dst_node.sid),
		"/sid/" + string(__src_node.sid), __pos);
}

function sc_gui_node_event_insert(__ev)
{
	var _dst = sc_gui_node_uri_router(__ev.dst_uri);
	switch (__ev.by) {
	case "uri":
		var _src = sc_gui_node_uri_router(__ev.src_uri);
		// friend don't need insert to node. 
		if (is_undefined(_src)) {
			exit;
		}
		if (is_undefined(_dst)) {
			sc_gui_node_event_insert_n2r(_src, __ev.pos)
			exit;
		}
		with (_dst) {
			if (is_undefined(_src.parent)) {
				sc_gui_node_event_insert_r2n(_src, __ev.pos)
			} else {
				sc_gui_node_event_move_o2n(_src, __ev.pos);
			}
		}
		break;
	case "arg":
		if (is_undefined(_dst)) {
			exit;
		}
	
		with (_dst) {
			var _src = sc_gui_node_event_create(__ev.args, GUI_NODE_TYPE.NODE);
			with (_src) {
				sc_gui_update_prepare();
				sc_gui_global_queue_idempotent_mark();
			}
		}
		break;
	}
	
}

function sc_gui_node_event_insert_n2r(__src, __pos)
{
	// root don't need to process.
	if (is_undefined(__src.parent)) {
		exit;
	}
	// 1. notify old family update
	with (__src.parent) {
		sc_gui_list_delete(childs, __src);
		sc_gui_grid2_unmark_complex(__src);
		sc_gui_update_prepare();
		sc_gui_global_queue_idempotent_mark();
	}
	// 2. move old family to new family
	if (is_undefined(__pos)) {
		sc_gui_list_add(global.gui.list_node, __src);
	} else {
		sc_gui_list_insert(global.gui.list_node, __src, __pos);
	}
	__src.origin = __src;
	__src.parent = undefined;
	// 3. notify new family update(don't update self)
	//with (__src) {
	//	sc_gui_affiliation_update_origin(origin);
	//	sc_gui_update_prepare();
	//	sc_gui_global_queue_idempotent_mark();
	//}
}

function sc_gui_node_event_insert_r2n(__src, __pos)
{
	if (!is_undefined(__src.list_pos)) {
		sc_gui_list_delete(global.gui.list_node, __src);
	}
	if (is_undefined(__pos)) {
		sc_gui_list_add(childs, __src);
	} else {
		sc_gui_list_insert(childs, __src, __pos);
	}
	__src.origin = origin;
	__src.parent = self;

	with (__src) {
		sc_gui_affiliation_update_origin(origin);
		sc_gui_update_prepare();
		sc_gui_global_queue_idempotent_mark();
	}
}

function sc_gui_node_event_move_o2n(__src, __pos)
{
	// 1. notify old family update
	with (__src.parent) {
		sc_gui_list_delete(childs, __src);
		sc_gui_grid2_unmark_complex(__src);
		sc_gui_update_prepare();
		sc_gui_global_queue_idempotent_mark();
	}
	// 2. move old family to new family
	if (is_undefined(__pos)) {
		sc_gui_list_add(childs, __src);
	} else {
		sc_gui_list_insert(childs, __src, __pos);
	}
	__src.origin = origin;
	__src.parent = self;
	// 3. notify new family update
	with (__src) {
		sc_gui_affiliation_update_origin(origin);
		sc_gui_update_prepare();
		sc_gui_global_queue_idempotent_mark();
	}
}


