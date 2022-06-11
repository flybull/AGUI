
gui_node = sc_gui_root({ x: x, y: y, padding: 8}, function() {
	sc_gui_container({w : 128, h : 128, spr : Sprite5, direct:"row"},  function() {
		sc_gui_sprite({spr : s_drag});
		sc_gui_sprite({spr : s_drag6});
	});
	sc_gui_container({w : 128, h : 128, spr : Sprite5, direct:"rrow"},  function() {
		sc_gui_sprite({spr : s_drag});
		sc_gui_sprite({spr : s_drag6});
	});
	sc_gui_container({w : 128, h : 128, spr : Sprite5, direct:"col"},  function() {
		sc_gui_sprite({spr : s_drag});
		sc_gui_sprite({spr : s_drag6});
	});
	sc_gui_container({w : 128, h : 128, spr : Sprite5, direct:"rcol"},  function() {
		sc_gui_sprite({spr : s_drag});
		sc_gui_sprite({spr : s_drag6});
	});
});
