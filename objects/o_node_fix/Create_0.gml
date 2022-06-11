gui_node = sc_gui_root({ x: x, y: y, w : 64, h: 64 , flag_scroll : GUI_AXIS_TYPE.BOTH, padding : 16}, function() {
	sc_gui_node({ w : 128, h: 128, span_w : 8, span_h : 8});
	sc_gui_sprite({spr: s_drag, text: {str : "7"}});
	
	sc_gui_container({ w : 64, h: 64, flag_scroll : GUI_AXIS_TYPE.BOTH, direct : GUI_FLEX_DIRECT.ROW,
			padding : 16, span_w : 2, span_h : 2,
			flex_algin : GUI_FLEX_ALIGN.START, flex_justify : GUI_FLEX_JUSTIFY.START}, function() {
		sc_gui_sprite({spr: s_drag, flag_crlf : true, text : { str: "A1"}, w : 32, h: 32});
		sc_gui_sprite({spr: s_drag8, flag_crlf : true, text : { str : "A2"} , flag_scroll : GUI_AXIS_TYPE.BOTH, w : 128, h: 64});
		sc_gui_sprite({spr: s_drag6, flag_crlf : true, text : { str : "A3"}, flag_scroll : GUI_AXIS_TYPE.BOTH, w : 128, h: 64, flag_stretch : true});
		sc_gui_node({ w : 48, h: 48, flag_crlf : true, flag_scroll : GUI_AXIS_TYPE.BOTH, direct : GUI_FLEX_DIRECT.ROW,
			padding : 16, span_w : 2, span_h : 2,
			flex_algin : GUI_FLEX_ALIGN.START, flex_justify : GUI_FLEX_JUSTIFY.START}, function() {
			sc_gui_node({flag_crlf : true, text : { str: "B1"}, w : 64, h: 64, flex_justify : GUI_FLEX_JUSTIFY.CENTER} , function() {
				sc_gui_node({ w : 48, h: 48, flag_scroll : GUI_AXIS_TYPE.BOTH, direct : GUI_FLEX_DIRECT.ROW, 
					padding : 4, span_w : 2, span_h : 2,
					flex_justify : GUI_FLEX_JUSTIFY.CENTER}, function () {
					sc_gui_sprite({spr: s_drag8, flag_crlf : true, text : { str :"C1"} , flag_scroll : GUI_AXIS_TYPE.BOTH, w : 16, h: 16});
				}); 
			});
			sc_gui_sprite({spr: s_drag8, flag_crlf : true, text : { str : "B2"} , flag_scroll : GUI_AXIS_TYPE.BOTH, w : 128, h: 64});
			sc_gui_sprite({spr: s_drag6, flag_crlf : true, text : { str : "B3"}, flag_scroll : GUI_AXIS_TYPE.BOTH, w : 128, h: 64, flag_stretch : true});
		});
		sc_gui_sprite({spr: s_drag, flag_crlf : true, text :  { str :"A4"}, w : 128, h: 32});
	});
	
	sc_gui_container({ w : 128, h: 128, direct : GUI_FLEX_DIRECT.ROW,
			padding : 16, span_w : 8, span_h : 8, flag_scroll : GUI_AXIS_TYPE.BOTH,
			flex_algin : GUI_FLEX_ALIGN.CENTER, flex_justify : GUI_FLEX_JUSTIFY.START}, function() {
		sc_gui_sprite({w : 256, h: 256, spr: s_drag8, flag_crlf : true, text : { str: "B1"}});
		sc_gui_sprite({spr: s_drag, flag_crlf : false, text : { str: "B2"}});
		sc_gui_sprite({ spr: s_drag6, flag_crlf : true, text : { str: "B3"}});
	});
	
	sc_gui_container({ w : 256, h: 256, direct : GUI_FLEX_DIRECT.ROW,
			padding : 4, span_w : 8, span_h : 8,
			flex_algin : GUI_FLEX_ALIGN.CENTER, flex_justify : GUI_FLEX_JUSTIFY.START}, function() {
		sc_gui_sprite({spr: s_drag6, flag_crlf : false, text : { str: "C1"}});
		sc_gui_sprite({spr:  s_drag8, flag_crlf : true, text : { str : "C2"}});
	});
	sc_gui_container({  w : 128, h: 128, direct : GUI_FLEX_DIRECT.ROW,
		padding : 4, span_w : 2, span_h : 2,
		flex_algin : GUI_FLEX_ALIGN.END, flex_justify : GUI_FLEX_JUSTIFY.CENTER}, function() {
		sc_gui_sprite({spr: s_drag6});
		sc_gui_sprite({spr: s_drag8});
		sc_gui_text({str : "hel\nlo\nsdfa\nasdfaf", text_sep :26});
	});
	
	sc_gui_container({ padding : 4, span_w : 8, span_h : 8}, function() {
		sc_gui_sprite({spr: s_drag, flag_crlf : false});
		sc_gui_sprite({spr: s_drag8, flag_crlf : false});
		sc_gui_sprite({spr: s_drag6, flag_crlf : true});
		
		sc_gui_sprite({spr:  s_drag8, flag_crlf : false});
		sc_gui_sprite({spr:  s_drag, flag_crlf : false});
		sc_gui_sprite({spr:  s_drag6, flag_crlf : true});
		
		sc_gui_sprite({spr:  s_drag6, flag_crlf : false});
		sc_gui_sprite({spr:  s_drag8, flag_crlf : true});
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
