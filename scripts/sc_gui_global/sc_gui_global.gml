function sc_gui_global_construct()
{
	sc_gui_eliminate_warn();
	sc_gui_config_attr_parse_build();
	sc_gui_config_attr_alias_build();
	sc_gui_config_attr_value_build();
	sc_gui_config_attr_theme_build();
	
	sc_gui_global_load_construct();
}

function sc_gui_global_destroy()
{
	sc_gui_global_attr_parse_destroy();
	sc_gui_global_attr_alias_destroy();
	sc_gui_global_attr_value_destroy();
	sc_gui_global_attr_theme_destroy();
}


function sc_gui_global_node_obtain(__cid, __inherit, __origin = undefined, __parent = undefined)
{
	var _used_pool = global.gui.pool_used_node;
	var _sn = ds_stack_pop(global.gui.stack_idle_sn);
	if (is_undefined(_sn)) {
		_sn = global.gui.last_node_sn++;
	}
	var _node = new sc_gui_node_constructor(_sn, __cid, __inherit, __origin, __parent);
	if (_node.sid >= array_length(_used_pool)) {
		var _idempotent_mark = global.gui.qmark_idempotent_node;
		var _default_pool = global.gui.pool_default_node;
		var _used_pool_len = array_length(_used_pool);
		var _default_pool_len = array_length(_default_pool);
		var _mark_len = array_length(_idempotent_mark);

		array_resize(_used_pool, _used_pool_len + _default_pool_len);
		array_copy(_used_pool, _used_pool_len, _default_pool, 0, _default_pool_len);
		array_resize(_idempotent_mark, _mark_len + _default_pool_len);
		array_copy(_idempotent_mark, _mark_len, _default_pool, 0, _default_pool_len);
	}

	_used_pool[@ _node.sid] = _node;
	return _node;
}

function sc_gui_global_node_release()
{
	gml_pragma("forceinline");
	var _used_pool = global.gui.pool_used_node;
	
	_used_pool[@ sid] = undefined;
	ds_stack_push(global.gui.stack_idle_sn, sid);
}

function sc_gui_global_node_find(__sid)
{
	gml_pragma("forceinline");
	if (is_undefined(__sid)) {
		return undefined;
	}
	var _used_pool = global.gui.pool_used_node;	
	return _used_pool[@ __sid];
}

function sc_gui_global_queue_idempotent_mark()
{
	gml_pragma("forceinline");
	var _mark = global.gui.qmark_idempotent_node;
	var _queue = global.gui.queue_idempotent_node;
	with (origin) {
		var _sid = sid;
		if (is_undefined(_mark[_sid])) {
			_mark[@ _sid] = _sid;
			ds_queue_enqueue(_queue, self);
		}
	}
}

function sc_gui_global_queue_idempotent_unmark(__function, __func_agrs = undefined)
{
	gml_pragma("forceinline");
	var _mark = global.gui.qmark_idempotent_node;
	var _queue = global.gui.queue_idempotent_node;
	for (var _origin = ds_queue_dequeue(_queue); 
		!is_undefined(_origin);
		_origin = ds_queue_dequeue(_queue)) {
		_mark[@ _origin.sid] = undefined;
		with (_origin) {
			sc_base_safe_call(__function, __func_agrs);
		}
	}
}

function sc_gui_global_event_xmit(__ev)
{
	gml_pragma("forceinline");
	var _event = global.gui.queue_curd_event;
	ds_queue_enqueue(_event, __ev);
}
