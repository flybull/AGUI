sc_gui_root({ x: x, y: y, padding: 8, w: 32, h:32}, function() {
	sc_gui_container({w:128, h : 64, padding: 8, block_direct : GUI_FLEX_DIRECT.NONE}, function() {
		sc_gui_node({ w: 64, h:32 , spr : s_drag, margin_top : 0.5, margin_left : 0.5});
	});
	sc_gui_container({w: 128, h : 32, padding: 8, block_direct : GUI_FLEX_DIRECT.NONE}, function() {
		sc_gui_node({ w: 64, h:32 , spr : s_drag, margin_bottom : 0.5, margin_right : 0.5});
	});
	sc_gui_container({w:128, h : 64, padding: 8, block_direct : GUI_FLEX_DIRECT.NONE}, function() {
		sc_gui_node({ w: 64, h:32 , spr : s_drag,
			margin_top : 0.3, margin_left : 0.3,
			anchor_width : 0, anchor_height : 0});
	});
	sc_gui_container({w: 128, h : 32, padding: 8, block_direct : GUI_FLEX_DIRECT.NONE}, function() {
		sc_gui_node({ w: 64, h:32 , spr : s_drag, 
			margin_bottom : 0.3, margin_right : 0.3,
			anchor_width : 1});
	});
	
	sc_gui_container({w:128, h : 64, padding: 8, block_direct : GUI_FLEX_DIRECT.NONE}, function() {
		sc_gui_node({ w: 64, h:32 , spr : s_drag, 
			margin_top : 0.5, margin_left : 0.5, margin_type : GUI_VALUE_TYPE.PERCENT,
			anchor_width : 0.5, anchor_height : 0.5});
	});
	sc_gui_container({w: 128, h : 32, padding: 8, block_direct : GUI_FLEX_DIRECT.NONE}, function() {
		sc_gui_node({ w: 64, h:32 , spr : s_drag, 
			margin_bottom : 0.5, margin_right : 0.5, margin_type : GUI_VALUE_TYPE.PERCENT,
			anchor_width : 0.5, anchor_height : 0.5});
	});

	sc_gui_container({w:128, h : 64, padding: 8, block_direct : GUI_FLEX_DIRECT.NONE}, function() {
		sc_gui_node({ w: 64, h:32 , spr : s_drag, margin_type : GUI_VALUE_TYPE.PERCENT,
			margin_top : 0.3, margin_left : 0.3,
			anchor_width : 0, anchor_height : 0});
	});
	sc_gui_container({w: 128, h : 32, padding: 8, block_direct : GUI_FLEX_DIRECT.NONE}, function() {
		sc_gui_node({ w: 64, h:32 , spr : s_drag, margin_type : GUI_VALUE_TYPE.PERCENT, 
			margin_bottom : 0.3, margin_right : 0.3,
			anchor_width : 1});
	});
	
	sc_gui_container({w: 128, h : 32, padding: 8, span_w : 2, block_direct : GUI_FLEX_DIRECT.ROW,
		flex_algin : GUI_FLEX_ALIGN.CENTER, flex_algin : GUI_FLEX_JUSTIFY.CENTER}, function() {
		sc_gui_text({text_pattern : "hello world! hi world! yoyo"});
		sc_gui_sprite({sprite_id : s_drag});
		sc_gui_sprite({sprite_id : s_button});
		sc_gui_sprite({sprite_id : s_drag6});
	});
});

