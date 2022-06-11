gui_node = sc_gui_root({ x: x, y: y}, function() {
		sc_gui_goods_shelf({grc : "4 * 4", gsz: "32 * 32", span_w : 4, span_h : 4, padding : 8, block_direct : GUI_FLEX_DIRECT.ROW});
		sc_gui_goods_shelf({grc : "4 * 4", gsz: "32 * 32", span_w : 4, span_h : 4, padding : 8, block_direct : GUI_FLEX_DIRECT.RROW, flag_crlf : true});
});

