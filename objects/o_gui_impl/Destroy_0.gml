var n = ds_list_size(list_node);
for (var i = 0; i < n; ++i) {
	with(list_node[| i]) {
		func[GUI_FUNC_TYPE.ON_DESTORY]();
	}
	delete list_node[| i];
}
ds_list_clear(list_node);
ds_list_destroy(list_node);

sc_gui_global_destroy();

delete scheme;

keyboard_impl.destroy();
delete keyboard_impl;

array_delete(qmark_idempotent_node, 0, array_length(qmark_idempotent_node));
ds_queue_clear(queue_idempotent_node);
ds_queue_destroy(queue_idempotent_node);

ds_queue_clear(queue_curd_event);
ds_queue_destroy(queue_curd_event);


array_delete(pool_used_node, 0, array_length(pool_used_node));
array_delete(pool_default_node, 0, array_length(pool_default_node));
ds_stack_destroy(stack_idle_sn);

array_delete(stack_focus, 0, array_length(stack_focus));
