sc_gui_root({ x: x, y: y, ashape : { type : "sprite", spr: Sprite5}, 
	w : 128, h : 128, padding: 8, span_w : 2, span_h : 2, flag_scroll : GUI_AXIS_TYPE.BOTH}, function() {
	sc_gui_node({w : 128, h: 128, rotate:45},  function() {
		sc_gui_drag({drag_uri:"/sid/" + string(sid)});
		//sc_gui_drag({drag_uri:"/parent/"});
		sc_gui_slider({ w: 128, h: 32, padding: 16});
		sc_gui_slider({ w: 32, h: 128, padding: 16, slider_asix : GUI_AXIS_TYPE.VERTICAL});
		sc_gui_drag({ w: 32, h: 32, flag_stretch : false});
		sc_gui_selector({text: {str :"Number"}}, function() {
			sc_gui_selector_elem({text: {str : "1"}});
			sc_gui_selector_elem({ashape : { type : "sprite", spr: s_drag}, text: {str : "2"}});
			sc_gui_selector_elem({ashape : { type : "sprite", spr: s_drag}, text: {str : "3"}});
			sc_gui_selector_elem({ashape : { type : "sprite", spr: s_drag}, text: {str : "4"}});
			sc_gui_selector_elem({ashape : { type : "sprite", spr: s_drag}, text: {str : "5"}});
			sc_gui_selector_elem({ashape : { type : "sprite", spr: s_drag}, text: {str : "6"}});
			sc_gui_selector_elem({ashape : { type : "sprite", spr: s_drag}, text: {str : "7"}});
		});
	});
});



