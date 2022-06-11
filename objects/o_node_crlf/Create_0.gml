gui_node = sc_gui_root({ x: x, y: y, w : 64, h: 64, padding : 16}, function() {
	sc_gui_container({ padding : 4, span_w : 8, span_h : 8}, function() {
		sc_gui_sprite({spr: s_drag, flag_crlf : false});
		sc_gui_sprite({spr: s_drag8, flag_crlf : false});
		sc_gui_sprite({spr: s_drag6, flag_crlf : true});
		
		sc_gui_sprite({spr: s_drag8, flag_crlf : false});
		sc_gui_sprite({spr: s_drag, flag_crlf : false});
		sc_gui_sprite({spr: s_drag6, flag_crlf : true});
		
		sc_gui_sprite({spr: s_drag6, flag_crlf : false});
		sc_gui_sprite({spr: s_drag8, flag_crlf : true});
	});
	sc_gui_container({ direct : GUI_FLEX_DIRECT.COL, padding : 4, span_w : 8, span_h : 8}, function() {
		sc_gui_sprite({spr: s_drag, flag_crlf : false});
		sc_gui_sprite({spr: s_drag6, flag_crlf : false});
		sc_gui_sprite({spr: s_drag, flag_crlf : false});
	});
	sc_gui_container({ padding : 4, span_w : 8, span_h : 8}, function() {
		sc_gui_sprite({spr: s_drag, flag_crlf : false});
		sc_gui_sprite({spr: s_drag6, flag_crlf : false});
		sc_gui_sprite({spr: s_drag, flag_crlf : false});
	});
});
