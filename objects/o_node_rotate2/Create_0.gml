gui_node = sc_gui_root({ x: x, y: y}, function() {
	//sc_gui_container({w : 128, h: 128},  function() {
	//	sc_gui_container({w : 128, h: 128},  function() {
	//		sc_gui_container({w : 64, h: 64},  function() {
	//			sc_gui_sprite({w : 32, h: 32, spr : s_drag});
	//			sc_gui_sprite({w : 32, h: 32, spr : s_button});
	//		});
			sc_gui_node({w : 32, h: 32, rotate : 45, direct : GUI_FLEX_DIRECT.COL},  function() {
				sc_gui_node({w : 32, h: 32, rotate : 45, sprite:{w : 32, h: 32, spr : s_drag}});
				sc_gui_node({w : 32, h: 32, rotate : -45, sprite:{w : 32, h: 32, spr : s_button}});
			});
	//		sc_gui_node({w : 64, h: 64, rotate : 30, direct : GUI_FLEX_DIRECT.COL},  function() {
	//			sc_gui_sprite({w : 32, h: 32, spr : s_drag});
	//			sc_gui_sprite({w : 32, h: 32, spr : s_button});
	//		});
	//		sc_gui_node({w : 64, h: 64, rotate : 135, direct : GUI_FLEX_DIRECT.COL},  function() {
	//			sc_gui_sprite({w : 32, h: 32, spr : s_drag});
	//			sc_gui_sprite({w : 32, h: 32, spr : s_button});
	//		});
	//		sc_gui_node({w : 64, h: 64, rotate : -45, direct : GUI_FLEX_DIRECT.COL},  function() {
	//			sc_gui_sprite({w : 32, h: 32, rotate : 45, sprite:{ spr : s_drag}});
	//			sc_gui_sprite({w : 32, h: 32, spr : s_button});
	//		});
	//	});
	//});
});
