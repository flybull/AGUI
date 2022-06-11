gui_node = sc_gui_root({ x: x, y: y, w : 32, h: 32}, function() {
	sc_gui_container({ w : 32, h: 32, direct : GUI_FLEX_DIRECT.COL,
			padding : 8, span_w : 2, span_h : 2,
			flex_algin : GUI_FLEX_ALIGN.START, flex_justify : GUI_FLEX_JUSTIFY.START}, function() {
		sc_gui_node({spr: s_drag, flag_crlf : false, text : "A1"});
		sc_gui_node({spr: s_drag8, flag_crlf : false, text : "A2"});
		sc_gui_node({spr: s_drag6, flag_crlf : true, text : "A3", flag_stretch : true});
	//});
	//sc_gui_container({ w : 256, h: 256, direct : GUI_FLEX_DIRECT.ROW,
	//		padding : 4, span_w : 8, span_h : 8,
	//		flex_algin : GUI_FLEX_ALIGN.CENTER, flex_justify : GUI_FLEX_JUSTIFY.START}, function() {
		sc_gui_node({spr: s_drag8, flag_crlf : false, text : "B1"});
		sc_gui_node({spr: s_drag, flag_crlf : false, text : "B2"});
		sc_gui_node({spr: s_drag6, flag_crlf : true, text : "B3"});
	//});
	//sc_gui_container({ w : 256, h: 256, direct : GUI_FLEX_DIRECT.ROW,
	//		padding : 4, span_w : 8, span_h : 8,
	//		flex_algin : GUI_FLEX_ALIGN.CENTER, flex_justify : GUI_FLEX_JUSTIFY.START}, function() {
		sc_gui_node({spr: s_drag6, flag_crlf : false, text : "C1"});
		sc_gui_node({spr: s_drag8, flag_crlf : true, text : "C2"});
	});
	sc_gui_container({  w : 128, h: 128, direct : GUI_FLEX_DIRECT.ROW,
		padding : 4, span_w : 2, span_h : 2,
		flex_algin : GUI_FLEX_ALIGN.END, flex_justify : GUI_FLEX_JUSTIFY.CENTER}, function() {
		sc_gui_node({spr : s_drag6});
		sc_gui_node({spr : s_drag8});
		sc_gui_textbox({text: "hel\nlo\nsdfa\nasdfaf", text_sep :26})
	});
	//sc_gui_container({ padding : 4, span_w : 8, span_h : 8}, function() {
	//	sc_gui_node({spr:s_drag, flag_crlf : false});
	//	sc_gui_node({spr:s_drag8, flag_crlf : false});
	//	sc_gui_node({spr:s_drag6, flag_crlf : true});
		
	//	sc_gui_node({spr:s_drag8, flag_crlf : false});
	//	sc_gui_node({spr:s_drag, flag_crlf : false});
	//	sc_gui_node({spr:s_drag6, flag_crlf : true});
		
	//	sc_gui_node({spr:s_drag6, flag_crlf : false});
	//	sc_gui_node({spr:s_drag8, flag_crlf : true});
	//});
	//sc_gui_container({ direct : GUI_FLEX_DIRECT.COL, padding : 4, span_w : 8, span_h : 8}, function() {
	//	sc_gui_node({spr:s_drag, flag_crlf : false});
	//	sc_gui_node({spr:s_drag6, flag_crlf : false});
	//	sc_gui_node({spr:s_drag, flag_crlf : false});
	//});
	//sc_gui_container({ padding : 4, span_w : 8, span_h : 8}, function() {
	//	sc_gui_node({spr:s_drag, flag_crlf : false});
	//	sc_gui_node({spr:s_drag6, flag_crlf : false});
	//	sc_gui_node({spr:s_drag, flag_crlf : false});
	//});
});
