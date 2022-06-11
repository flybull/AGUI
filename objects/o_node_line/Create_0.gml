var _node1 = sc_gui_root({ x: x, y: y, w : 32, h : 32, rotate: 45, flex_justify : "center"/*, flag_scroll : GUI_AXIS_TYPE.BOTH*/}, function() {
	sc_gui_drag({uri: "/parent", text : {str: "1" }, w : 128, h : 128});
	sc_gui_node({w:16, h : 16, text : {str: "1A" }});

});

var _node2 = sc_gui_root({ x: x + 100, y: y + 100, w : 32, h : 32, rotate: -45}, function() {
	sc_gui_drag({uri: "/parent", text : {str: "2" }});
});

var _node3 = sc_gui_root({ x: x + 200, y: y + 100, w : 32, h : 32, rotate: -30}, function() {
	sc_gui_drag({uri: "/parent", text : {str: "3" }});
	sc_gui_node({w:32, h : 32, text : {str: "3A" }});
});
var _node4 = sc_gui_root({ x: x + 300, y: y + 100, w : 32, h : 32, rotate: 30}, function() {
	sc_gui_drag({uri: "/parent", text : {str: "3" }});
});
var _node5 = sc_gui_root({ x: x + 400, y: y + 200, w : 32, h : 32, rotate: -90}, function() {
	sc_gui_drag({uri: "/parent", text : {str: "3" }});
});
var _node6 = sc_gui_root({ x: x + 500, y: y + 200, w : 32, h : 32, rotate: 90}, function() {
	sc_gui_drag({uri: "/parent", text : {str: "3" }});
});

sc_gui_bezier({src : "/sid/" + string(_node1.sid), dst : "/sid/" + string(_node2.sid)});
sc_gui_bezier({src : "/sid/" + string(_node1.sid), dst : "/sid/" + string(_node2.sid)});
sc_gui_bezier({src : "/sid/" + string(_node2.sid), dst : "/sid/" + string(_node3.sid)});
sc_gui_bezier({src : "/sid/" + string(_node3.childs[| 1].sid), dst : "/sid/" + string(_node1.childs[| 1].sid)});

sc_gui_bezier({src : "/sid/" + string(_node1.sid), dst : "/sid/" + string(_node2.sid)});
sc_gui_bezier({src : "/sid/" + string(_node1.sid), dst : "/sid/" + string(_node2.sid)});
sc_gui_bezier({src : "/sid/" + string(_node2.sid), dst : "/sid/" + string(_node3.sid)});
sc_gui_bezier({src : "/sid/" + string(_node3.childs[| 1].sid), dst : "/sid/" + string(_node1.childs[| 1].sid)});

sc_gui_bezier({src : "/sid/" + string(_node1.sid), dst : "/sid/" + string(_node2.sid)});
sc_gui_bezier({src : "/sid/" + string(_node1.sid), dst : "/sid/" + string(_node2.sid)});
sc_gui_bezier({src : "/sid/" + string(_node2.sid), dst : "/sid/" + string(_node3.sid)});
sc_gui_bezier({src : "/sid/" + string(_node3.childs[| 1].sid), dst : "/sid/" + string(_node1.childs[| 1].sid)});

sc_gui_line({src : "/sid/" + string(_node4.sid), dst : "/sid/" + string(_node2.sid)});
sc_gui_line({src : "/sid/" + string(_node5.sid), dst : "/sid/" + string(_node3.sid)});
sc_gui_line({src : "/sid/" + string(_node6.sid), dst : "/sid/" + string(_node1.sid)});
