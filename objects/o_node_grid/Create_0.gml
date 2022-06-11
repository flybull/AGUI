gui_node = sc_gui_root({ x: x, y: y}, function() {
	sc_gui_tab_menu({w : 166, h : 166, block_direct : GUI_FLEX_DIRECT.COL }, function() {
		sc_gui_tab_elem({str : "PACKET1"}, function() {
			sc_gui_grid({grc : "4 * 4", gsz: "32 * 32", span_w : 4, span_h : 4, padding : 8, block_direct : GUI_FLEX_DIRECT.ROW});
		});
		sc_gui_tab_elem({str : "PACKET2"}, function() {
			sc_gui_grid({grc : "4 * 4", gsz: "32 * 32", span_w : 4, span_h : 4, padding : 8, block_direct : GUI_FLEX_DIRECT.RROW, flag_crlf : true});
		});
		sc_gui_tab_elem({str : "PACKET3"}, function() {
			sc_gui_grid({grc : "4 * 4", gsz: "32 * 32", span_w : 4, span_h : 4, padding : 8, block_direct : GUI_FLEX_DIRECT.COL});
		});
		sc_gui_tab_elem({str : "PACKET4"}, function() {
			sc_gui_grid({grc : "4 * 4", gsz: "32 * 32", span_w : 4, span_h : 4, padding : 8, block_direct : GUI_FLEX_DIRECT.RCOL, flag_crlf : true});
		});
		sc_gui_tab_elem({str : "PACKET5"}, function() {
			sc_gui_grid({grc : "4 * 4", gsz: "32 * 32", span_w : 4, span_h : 4, padding : 8, block_direct : GUI_FLEX_DIRECT.RCOL, flag_crlf : true});
		});
		sc_gui_tab_elem({str : "PACKET6"}, function() {
			sc_gui_grid({grc : "4 * 4", gsz: "32 * 32", span_w : 4, span_h : 4, padding : 8, block_direct : GUI_FLEX_DIRECT.RCOL, flag_crlf : true});
		});
		sc_gui_tab_elem({str : "PACKET7"}, function() {
			sc_gui_grid({grc : "4 * 4", gsz: "32 * 32", span_w : 4, span_h : 4, padding : 8, block_direct : GUI_FLEX_DIRECT.RCOL, flag_crlf : true});
		});
		sc_gui_tab_elem({str : "PACKET8"}, function() {
			sc_gui_grid({grc : "4 * 4", gsz: "32 * 32", span_w : 4, span_h : 4, padding : 8, block_direct : GUI_FLEX_DIRECT.RCOL, flag_crlf : true});
		});
	});
});

