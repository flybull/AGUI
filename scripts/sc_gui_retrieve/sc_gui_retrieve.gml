// component
//		[root]     origin = self, parent = undef,
//		[node]     origin = root, parent = parent,
//		[friend]   origin = undef, parent = undef, must description fid.
//		[orphan]   origin = root, parent = self, 
//		[decorate] origin = root, parent = parent, description by attr property. a node
// Note:
//		[x, y] only use in root/friends
//		[cid attr childs friends] reserve property.
//		[__agrs] _tempelete : 
// {
//	  cid:"default",
//    attr:{ w: 32, h:32, x: 0, y:0 },
//    childs : [
//        {cid:"default", inherit:"defalut", attr:{ w: 32, h:32 }, childs : [...]},
//        {cid:"default", inherit:"defalut", attr:{ w: 32, h:32 }},
//        {cid:"default", attr:{ w: 32, h:32 }},
//    ],
//    friends : [
//	      {cid:"default", attr:{ w: 32, h:32, x: 0, y:0, fid: 1}},
//    ],
// }


//function sc_gui_node_event_retrieve(__src_uri, __notify_callback)
//{
//	sc_gui_global_event_xmit({sid: sid, type : GUI_EVENT.RETRIEVE, 
//			src_uri: __src_uri, notify_callback : __notify_callback });
//}

