gui_node = sc_gui_root({ x: x, y: y, spr : Sprite56}, function() {
	sc_gui_container({spr : Sprite5},  function() {
		sc_gui_container({spr : Sprite5},  function() {
			sc_gui_container({spr : Sprite5},  function() {
				sc_gui_node({spr : s_drag});
				sc_gui_node({spr : s_button});
			});
			sc_gui_container({spr : Sprite5, direct : GUI_FLEX_DIRECT.COL},  function() {
				sc_gui_node({spr : s_drag});
				sc_gui_node({spr : s_button});
			});
		});
	});
	
	//sc_gui_container({spr : Sprite5},  function() {
	//	sc_gui_container({spr : Sprite5},  function() {
	//		sc_gui_container({spr : Sprite5},  function() {
	//			sc_gui_node({spr : s_drag});
	//			sc_gui_node({spr : s_button});
	//		});
	//	});
	//	sc_gui_container({spr : Sprite5, direct : GUI_FLEX_DIRECT.COL},  function() {
	//		sc_gui_node({spr : s_drag});
	//		sc_gui_node({spr : s_button});
	//	});
	//});
	sc_gui_container({spr : Sprite5, direct : GUI_FLEX_DIRECT.COL},  function() {
		sc_gui_container({spr : Sprite5},  function() {
			sc_gui_node({spr : s_drag6});
			sc_gui_node({spr : s_button});
		});
		sc_gui_container({spr : Sprite5},  function() {
			sc_gui_node({spr : s_drag6});
			sc_gui_node({spr : s_button});
		});
		sc_gui_container({spr : Sprite5},  function() {
			sc_gui_node({spr : s_drag6, direct : GUI_FLEX_DIRECT.COL});
			sc_gui_node({spr : s_drag6});
			sc_gui_node({spr : s_button, direct : GUI_FLEX_DIRECT.COL});
			sc_gui_node({spr : s_drag6, direct : GUI_FLEX_DIRECT.COL});
		});
	});
});
