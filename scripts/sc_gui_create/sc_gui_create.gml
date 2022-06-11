// component
//		[root]     origin = self, parent = undef,
//		[node]     origin = root, parent = parent,
//		[friend]   origin = undef, parent = undef, Both node must description fid .
//		[orphan]   origin = root, parent = self, 
//		[decorate] origin = root, parent = parent, description by attr property. a node
// Note:
//		[x, y] only use in root/friends
//		[cid attr childs friends] reserve property.
//		[__agrs] _tempelete : 
//      [attr] margin left/top should be similar to x/y.(no root)
// {
//	  cid:"default",
//    attr:{ w: 32, h:32, x: 0, y: 0 },
//    childs : [
//        {cid:"default", inherit:"defalut", attr:{ w: 32, h:32 }, childs : [...]},
//        {cid:"default", inherit:"defalut", attr:{ w: 32, h:32 }},
//        {cid:"default", attr:{ w: 32, h:32 }},
//    ],
//    friends : [
//	      {cid:"default", attr:{ w: 32, h:32, x: 0, y:0, fid: 1}},
//    ],
// }

function sc_gui_node_event_create_by_args(__agrs)
{
	gml_pragma("forceinline");
	sc_gui_global_event_xmit({ type : GUI_EVENT.CREATE, args: __agrs });
}

function sc_gui_node_event_create(__args, __type = GUI_NODE_TYPE.ROOT)
{
	if (is_undefined(__args)) {
		return undefined;
	}
	var _cid = variable_struct_get(__args, "cid");
	if (is_undefined(_cid)) {
		return undefined;
	}
	var _classid = sc_gui_global_find_classid(_cid);
	var _inherit = variable_struct_get(__args, "inherit");
	if (is_undefined(_inherit)) {
		_inherit = GUI_CLASS.DEFAULT;
	}
	if (__type == GUI_NODE_TYPE.ROOT) {
		return sc_gui_root(variable_struct_get(__args, "attr"), function(__args) {
			sc_gui_node_subcreate(__args);
		}, __args, _classid, _inherit);
	}
	var _method = sc_gui_global_find_create_method(_classid);
	if (!is_undefined(_method)) {
		return _method(variable_struct_get(__args, "attr"), function(__args) {
			sc_gui_node_subcreate(__args);
		}, __args);
	}

	switch (__type) {
	case GUI_NODE_TYPE.NODE:
		return sc_gui_node(variable_struct_get(__args, "attr"), function(__args) {
			sc_gui_node_subcreate(__args);
		}, __args, _classid, _inherit);
	case GUI_NODE_TYPE.FRIEND:
		return sc_gui_friend(variable_struct_get(__args, "attr"), function(__args) {
			sc_gui_node_subcreate(__args);
		}, __args, _classid, _inherit);
	case GUI_NODE_TYPE.ORPHAN:
		return sc_gui_orphan(variable_struct_get(__args, "attr"), function(__args) {
			sc_gui_node_subcreate(__args);
		}, __args, _classid, _inherit);
	}
	return undefined;
}

function sc_gui_node_subcreate(__args)
{
	sc_base_m2s_call(function(__param) {
		sc_gui_node_event_create(__param, GUI_NODE_TYPE.NODE);
	}, variable_struct_get(__args, "childs"));
	sc_base_m2s_call(function(__param) {
		sc_gui_node_event_create(__param, GUI_NODE_TYPE.FRIEND);
	}, variable_struct_get(__args, "friends"));
	sc_base_m2s_call(function(__param) {
		sc_gui_node_event_create(__param, GUI_NODE_TYPE.ORPHAN);
	}, variable_struct_get(__args, "orphans"));
}


