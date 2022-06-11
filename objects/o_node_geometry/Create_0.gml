gui_node = sc_gui_root({ x: x, y: y, w : 16, h : 16, padding: 8, span_w:16}, function() {
		sc_gui_triangle({w : 16, h : 16, padding: 2, orient: GUI_TRIANLE_ORIENT.LEFT});
		sc_gui_triangle({w : 16, h : 16, padding: 2, orient: GUI_TRIANLE_ORIENT.RIGHT});
		sc_gui_triangle({w : 16, h : 16, padding: 2, orient: GUI_TRIANLE_ORIENT.UP});
		sc_gui_triangle({w : 16, h : 16, padding: 2, orient: GUI_TRIANLE_ORIENT.UPLEFT});
		sc_gui_triangle({w : 16, h : 16, padding: 2, orient: GUI_TRIANLE_ORIENT.UPRIGHT});
		sc_gui_triangle({w : 16, h : 16, padding: 2, orient: GUI_TRIANLE_ORIENT.DOWN});
		sc_gui_triangle({w : 16, h : 16, padding: 2, orient: GUI_TRIANLE_ORIENT.DOWNLEFT});
		sc_gui_triangle({w : 16, h : 16, padding: 2, orient: GUI_TRIANLE_ORIENT.DOWNRIGHT});
		sc_gui_node({ashape: undefined,
			 triangle : {
			    w : 16, h : 16, padding: 2, 
				orient: GUI_TRIANLE_ORIENT.LEFT, 
				direct: GUI_FLEX_DIRECT.NONE,
				margin_type: GUI_VALUE_TYPE.PERCENT,
				margin_left: 1,
			}
		});
		sc_gui_node({ashape: undefined,
			 rect : {
			    w : 16, h : 16, padding: 8, 
				direct: GUI_FLEX_DIRECT.NONE,
				margin_type: GUI_VALUE_TYPE.PERCENT,
				margin_left: 1,
			}
		});
		sc_gui_node({ ashape: undefined,
			 roundrect : {				
			    w : 16, h : 16, padding: 8, 
				direct: GUI_FLEX_DIRECT.NONE,
				margin_type: GUI_VALUE_TYPE.PERCENT,
				margin_left: 1,
			}
		});
		sc_gui_node({ ashape: undefined,
			 circle : {
			    w : 16, h : 16, padding: 8, 
				direct: GUI_FLEX_DIRECT.NONE,
				margin_type: GUI_VALUE_TYPE.PERCENT,
				margin_left: 1,
			}
		});
		sc_gui_triangle({ashape:{type:"rect"},w:16,h:16, padding: 8});
		sc_gui_rect({ashape:{type:"rect"}, w:16,h:16, padding: 8});
		sc_gui_roundrect({ashape:{type:"rect"}, w:16,h:16, padding: 8, flag_crlf: false});
		sc_gui_circle({ashape:{type:"rect"},w:16,h:16, padding: 8, flag_crlf: true});

		sc_gui_triangle({ashape:{type:"roundrect"},w:16,h:16, padding: 8});
		sc_gui_rect({ashape:{type:"roundrect"}, w:16,h:16, padding: 8});
		sc_gui_roundrect({ashape:{type:"roundrect"}, w:16,h:16, padding: 8, flag_crlf: false});
		sc_gui_circle({ashape:{type:"roundrect"},w:16,h:16, padding: 8, flag_crlf: true});
		
		sc_gui_triangle({ashape:{type:"circle"},w:16,h:16, padding: 8});
		sc_gui_rect({ashape:{type:"circle"}, w:16,h:16, padding: 8});
		sc_gui_roundrect({ashape:{type:"circle"}, w:16,h:16, padding: 8, flag_crlf: false});
		sc_gui_circle({ashape:{type:"circle"},w:16,h:16, padding: 8, flag_crlf: true});
		
		sc_gui_triangle({w:16,h:16, padding: 8});
		sc_gui_rect({w:16,h:16, padding: 8});
		sc_gui_roundrect({w:16,h:16, padding: 8});
		sc_gui_circle({w:16,h:16, padding: 8});
});

