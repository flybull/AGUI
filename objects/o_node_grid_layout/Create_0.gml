gui_node = sc_gui_root({ x: x, y: y,/* w : 512, h : 512,
	spec_row : 16, spec_col: 8, span_w :8 , span_h : 8, padding : 8,
	block_direct : GUI_FLEX_DIRECT.GRID*/}, function() {
	sc_gui_container({ w : 512, h : 512,
	spec_row : 16, spec_col: 8, span_w :0 , span_h : 0, padding : 0,
	block_direct : GUI_FLEX_DIRECT.GRID}, function() {
		sc_gui_drag({text : {str : "1"}, w :32, h : 32});
		sc_gui_drag({text : {str : "2"}, w :32, h : 64});
		sc_gui_drag({text : {str : "3"}, w :64, h : 32});
	
		sc_gui_drag({text : {str : "4"}, w :32, h : 32});
		sc_gui_drag({text : {str : "5"}, w :32, h : 64});
		sc_gui_drag({text : {str : "6"}, w :64, h : 32});
	
		sc_gui_drag({text : {str : "7"}, w :32, h : 32});
		sc_gui_drag({text : {str : "8"}, w :32, h : 64});
		sc_gui_drag({text : {str : "9"}, w :64, h : 32});
	
		sc_gui_drag({text : {str : "10"}, w :32, h : 32});
		//sc_gui_drag({spr: s_drag, w :32, h : 32});
		//sc_gui_drag({spr: s_drag, w :32, h : 32});
		//sc_gui_drag({spr: s_drag, w :32, h : 32});
		//sc_gui_drag({spr: s_drag, w :32, h : 32});
		//sc_gui_drag({spr: s_drag, w :32, h : 32});
		sc_gui_drag({text : {str : "11"}, w :24, h : 33});
		sc_gui_drag({text : {str : "12"}, w :33, h : 24});
		sc_gui_drag({text : {str : "13"}, w :68, h : 127});
		sc_gui_drag({text : {str : "14"}, w :68, h : 127});
		sc_gui_drag({text : {str : "15"}, w :68, h : 127});
		//sc_gui_sprite({spr: s_drag, w :68, h : 127});
		//sc_gui_sprite({spr: s_drag, w :32, h : 32});
		//sc_gui_sprite({spr: s_drag, w :32, h : 32});
		//sc_gui_sprite({spr: s_drag, w :32, h : 32});
		//sc_gui_sprite({spr: s_drag, w :24, h : 33});
	});
});

