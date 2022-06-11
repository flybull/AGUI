gui_node = sc_gui_root({ x: x, y: y, spr : Sprite56}, function() {
	//sc_gui_node({spr : Sprite5},  function() {
	//	sc_gui_node({spr : Sprite5},  function() {
	//		sc_gui_node({spr : Sprite5},  function() {
	//			sc_gui_node({spr : s_drag});
	//			sc_gui_node({spr : s_button});
	//		}, GUI_CLASS.CONTAINER);
	//		sc_gui_node({spr : Sprite5, direct : GUI_FLEX_DIRECT.COL},  function() {
	//			sc_gui_node({spr : s_drag});
	//			sc_gui_node({spr : s_button});
	//		}, GUI_CLASS.CONTAINER);
	//	}, GUI_CLASS.CONTAINER);
	//}, GUI_CLASS.CONTAINER);
	//sc_gui_node({spr : Sprite5},  function() {
	//	sc_gui_node({spr : Sprite5},  function() {
	//		sc_gui_node({spr : Sprite5},  function() {
	//			sc_gui_node({spr : s_drag});
	//			sc_gui_node({spr : s_button});
	//		}, GUI_CLASS.CONTAINER);
	//	}, GUI_CLASS.CONTAINER);
	//	sc_gui_node({spr : Sprite5, direct : GUI_FLEX_DIRECT.COL},  function() {
	//		sc_gui_node({spr : s_drag});
	//		sc_gui_node({spr : s_button});
	//	}, GUI_CLASS.CONTAINER);
	//}, GUI_CLASS.CONTAINER);
	sc_gui_container({spr : Sprite5},  function() {
		sc_gui_container({spr : s_64_64, direct : GUI_FLEX_DIRECT.RROW, flex_algin : GUI_FLEX_ALIGN.CENTER},  function() {
			sc_gui_node({spr : s_drag});
			sc_gui_node({spr : s_button});
		});
		sc_gui_container({spr : Sprite5},  function() {
			sc_gui_node({spr : s_drag});
			sc_gui_node({spr : s_button});
			sc_gui_node({spr : s_button});
			sc_gui_node({spr : s_button});
			sc_gui_node({spr : s_button});
		});

		sc_gui_container({spr : Sprite5, direct : GUI_FLEX_DIRECT.COL},  function() {
			sc_gui_container({spr : Sprite5},  function() {
				sc_gui_node({spr : s_drag});
				sc_gui_node({spr : s_button});
				sc_gui_node({spr : s_button});
			});
			sc_gui_container({spr : s_64_64, direct : GUI_FLEX_DIRECT.RCOL},  function() {
				sc_gui_node({spr : s_drag});
				sc_gui_node({spr : s_button});
			});
			sc_gui_container({spr : Sprite5},  function() {
				sc_gui_node({spr : s_drag});
				sc_gui_node({spr : s_button});
				sc_gui_node({spr : s_button});
			});
			sc_gui_container({spr : Sprite5, direct : GUI_FLEX_DIRECT.ROW},  function() {
				sc_gui_container({spr : Sprite5},  function() {
					sc_gui_node({spr : s_drag});
					sc_gui_node({spr : s_button});
				});
				sc_gui_container({spr : Sprite5},  function() {
					sc_gui_node({spr : s_drag});
					sc_gui_node({spr : s_button});
					sc_gui_node({spr : s_button});
				});
				sc_gui_container({spr : Sprite5},  function() {
					sc_gui_node({spr : s_drag});
					sc_gui_node({spr : s_button});
				});
				sc_gui_container({spr : Sprite5},  function() {
					sc_gui_node({spr : s_drag});
					sc_gui_node({spr : s_button});
				});
				sc_gui_container({spr : Sprite5},  function() {
					sc_gui_node({spr : s_drag});
					sc_gui_node({spr : s_button});
					sc_gui_node({spr : s_button});
					sc_gui_node({spr : s_button});
				});
				sc_gui_container({spr : Sprite5, direct : GUI_FLEX_DIRECT.COL},  function() {
					sc_gui_container({spr : Sprite5},  function() {
						sc_gui_node({spr : s_drag});
						sc_gui_node({spr : s_button});
					});
					sc_gui_container({spr : Sprite5},  function() {
						sc_gui_node({spr : s_drag});
						sc_gui_node({spr : s_button});
						sc_gui_node({spr : s_button});
					});
					sc_gui_container({spr : Sprite5},  function() {
						sc_gui_node({spr : s_drag});
						sc_gui_node({spr : s_button});
					});
				});
			});
		});
	});
});

