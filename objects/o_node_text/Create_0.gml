gui_node = sc_gui_root({ x: x, y: y, w : 256, h: 256, padding : 32, span_w : 16, span_h : 16}, function() {
		sc_gui_node({ padding:8, text : { str : "abcdssssss",
			text_angle : 0,
			flex_algin : GUI_FLEX_ALIGN.END, flex_justify : GUI_FLEX_JUSTIFY.END}});
		sc_gui_node({ padding:8, text : { str : "abcdssssss",
			text_angle : 45,
			flex_algin : GUI_FLEX_ALIGN.CENTER, flex_justify : GUI_FLEX_JUSTIFY.CENTER}});
		sc_gui_node({ text : { str : "abcd",
			text_angle : 90,
			flex_algin : GUI_FLEX_ALIGN.START, flex_justify : GUI_FLEX_JUSTIFY.START}});
		sc_gui_node({ text : { str : "abcd",
			text_angle : 135,
			flex_algin : GUI_FLEX_ALIGN.START, flex_justify : GUI_FLEX_JUSTIFY.START}});
		sc_gui_node({ text : { str : "abcd",
			text_angle : 180,
			flex_algin : GUI_FLEX_ALIGN.START, flex_justify : GUI_FLEX_JUSTIFY.START}});
		sc_gui_node({ text : { str : "abcd",
			text_angle : 225,
			flex_algin : GUI_FLEX_ALIGN.START, flex_justify : GUI_FLEX_JUSTIFY.START}});
		sc_gui_node({ text : { str : "abcd",
			text_angle : 270,
			flex_algin : GUI_FLEX_ALIGN.START, flex_justify : GUI_FLEX_JUSTIFY.START}});
		sc_gui_node({ text : { str : "abcd",
			text_angle : 315,
			flex_algin : GUI_FLEX_ALIGN.START, flex_justify : GUI_FLEX_JUSTIFY.START}});
});
