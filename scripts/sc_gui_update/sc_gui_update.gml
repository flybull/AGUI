function sc_gui_node_event_update_api()
{
	sc_gui_node_event_update_by_uri(undefined, undefined, undefined, undefined);
	sc_gui_node_event_update_by_args(undefined);
	sc_gui_node_event_update_size(0,0,0,0);
	
	sc_gui_update_prepare();
	sc_gui_update_execute();
}

function sc_gui_node_event_update_by_uri(__src_uri, __src_prop, __dst_uri, __dst_prop)
{
	gml_pragma("forceinline");
	sc_gui_global_event_xmit({sid: sid, type : GUI_EVENT.UPDATE, 
			src_uri: __src_uri, src_prop : __src_prop, 
			dst_uri : __dst_uri, dst_prop : __dst_prop,
			args: undefined});
}

function sc_gui_node_event_update_by_args(__agrs, __dst_uri = undefined)
{
	gml_pragma("forceinline");
	sc_gui_global_event_xmit({sid: sid, type : GUI_EVENT.UPDATE, 
			src_uri : undefined, src_prop : undefined, 
			dst_uri : __dst_uri, dst_prop : undefined,
			args: __agrs});
}

function sc_gui_node_event_update_size(__width, __height, _pl, _pt)
{
	gml_pragma("forceinline");
	sc_gui_global_event_xmit({sid: sid, type : GUI_EVENT.UPDATE, 
			src_uri : undefined, src_prop : undefined, 
			dst_uri : undefined, dst_prop : undefined,
			args: {
				w : __width, h : __height, 
				padding_left : _pl,
				padding_top : _pt,
			}
	});
}

function sc_gui_node_event_update(__ev)
{
	if (is_undefined(__ev.args)) {
		var _src_node = sc_gui_node_uri_router(__ev.src_uri);
		var _dst_node = sc_gui_node_uri_router(__ev.dst_uri);
		var _attr = {};

		variable_struct_set(_attr, __ev.dst_prop,
			variable_struct_get(_src_node, __ev.src_prop));

		with (_dst_node) {
			sc_gui_update_prepare(_attr);
			sc_gui_global_queue_idempotent_mark();
		}
	} else {
		var _dst_node;
		if (is_undefined(__ev.dst_uri)) {
			_dst_node = self;
		} else {
			_dst_node = sc_gui_node_uri_router(__ev.dst_uri);
		}
		with (_dst_node) {
			sc_gui_update_prepare(__ev.args);
			sc_gui_global_queue_idempotent_mark();
		}
	}
}

/// @function		sc_gui_update_prepare(__attr)
/// @description	Prepare node update(reset and set attr)
function sc_gui_update_prepare(__attr = undefined)
{
	if (status_update) {
		if (!is_undefined(__attr)) {
			sc_gui_update_prepare_self(__attr);
		}
		exit;
	}
	sc_ds_list_foreach(childs, sc_gui_update_relative_childs);
	sc_gui_update_prepare_self(__attr);

	if (is_undefined(parent)) {
		exit;
	}
	with (parent) {
		sc_gui_update_prepare();
	}
}

/// @function		sc_gui_update_relative_childs()
/// @description	Update_relative_childs(flag_strech ...)
function sc_gui_update_relative_childs(__attr = undefined)
{
	if (flag_stretch || parent.flag_wrap) {
		sc_gui_update_prepare_self(__attr);
		sc_ds_list_foreach(childs, sc_gui_update_relative_childs);
	}
}

/// @function		sc_gui_update_prepare_self(__attr)
/// @description	Prepare node update(reset and set attr)
function sc_gui_update_prepare_self(__attr = undefined)
{
	sc_gui_node_reset();
	func[GUI_FUNC_TYPE.ON_INIT_BEGIN](__attr);
	status_update = true;
}

/// @function		sc_gui_update_execute()
/// @description	Execute node update(calculate size\postion\layout)
function sc_gui_update_execute() {
	if (!status_update) {
		exit;
	}
	var n = ds_list_size(childs);
	for (var i = 0; i < n; ++i) {
		with(childs[| i]) {
			sc_gui_update_execute();
		}
	}
	var n = ds_list_size(decorate);
	for (var i = 0; i < n; ++i) {
		with(decorate[| i]) {
			sc_gui_update_execute();
		}
	}
	func[GUI_FUNC_TYPE.ON_INIT_END]();
	func[GUI_FUNC_TYPE.ON_UPDATE]();
	if (!is_undefined(parent)) {
		if ((!is_undefined(view_width_last) && view_width_last != view_width) ||
			(!is_undefined(view_height_last) && view_height_last != view_height)) {
			with (parent) {
				sc_ds_list_foreach(childs, function() {
					status_stub = true;
				});
			}
		}
	}
	
	status_update = false;
}