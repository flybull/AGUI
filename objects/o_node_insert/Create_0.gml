gui_node = sc_gui_root({ x: x, y: y, span_w: 8, span_h: 8}, function() {
	sc_gui_container({w : 128, h : 128, spr : Sprite5, direct:"row"},  function() {
		sc_gui_sprite({spr : s_drag});
		sc_gui_sprite({spr : s_drag6});
	});
});
