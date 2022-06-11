global.gui = self;

#region "select node"
hover_origin_id = undefined;
hover_node_id = undefined;
hold_node_id = undefined;
list_node = ds_list_create();
stack_focus = array_create(0);
#endregion

#region "record node"
pool_used_node = array_create(0);
pool_default_node = array_create(8, undefined);
stack_idle_sn = ds_stack_create();
last_node_sn = 0;
#endregion

#region "curd event"
queue_curd_event = ds_queue_create();
#endregion

#region "for idempotent operator"
qmark_idempotent_node = array_create(0); // for 查询.
queue_idempotent_node = ds_queue_create();
#endregion

#region "scheme wheel"
scheme = new sc_gui_scheme_wheel();
#endregion

#region "device"
device_x = 0;
device_y = 0;
device_slot = 0;
keyboard_impl = new sc_gui_keyboard_impl();
#endregion

#region "ui attr"
config_attr_parse = undefined;
config_attr_alias = undefined;
config_attr_value = undefined;
config_attr_theme = undefined;
#endregion

sc_gui_global_construct();

		
