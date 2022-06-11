gui_node = sc_gui_root({ x: x, y: y, w: 512, span_h : 32, flex_justify : GUI_FLEX_JUSTIFY.CENTER}, function() {
	sc_gui_node({ w: 64, h : 64, text :{ str : "hover-path"},
		animation: { hover : { path: {
			delay:1, times:1, duration:100,
			formula: function() {
				return [run_values_last[0] + 5, run_values_last[1]];
			}
		}}},
		flag_crlf : true,
	});
	sc_gui_node({ w: 64, h : 64, text :{ str : "press-path"},
		animation: { press : { path: {
			delay:60, times:2, duration:100,
			formula: function() {
				return [run_values_last[0] + 5, run_values_last[1]];
			}
		}}},
		flag_crlf : true,
	});
	sc_gui_node({ w: 64, h : 64,  text :{ str : "hover-scale"},
		animation: { hover : { scale: {
			delay:1, times:1, duration:200,
			formula: function() {
				return [run_values_last[0] + 0.01, run_values_last[1]];
			}
		}}},
		flag_crlf : true,
	});
	// bug
	sc_gui_node({ w: 64, h : 64, rotate:0, text :{ str : "hover-size"},
		animation: { hover : { size: {
			delay:1, times:1, duration:100,
			formula: function() {
				return [
					run_values_last[0] + 2, 
					run_values_last[1] + 1, 
					run_values_last[2] - 2, 
					run_values_last[3] - 1
				];
			}
		}}},
		flag_crlf : true,
	});
	sc_gui_node({ w: 64, h : 64, text :{ str : "hover-rotate"},
		animation: { hover : { rotate: {
			delay:1, times:1, duration:100,
			formula: function() {
				return [run_values_last[0] + 3.6, 0, 0];
			}
		}}},
		flag_crlf : true,
	});
	sc_gui_node({ w: 64, h : 64, text :{ str : "press-color"},
		animation: { press : { color: {
			delay:1, times:1, duration:10000,
			formula: function() {
				return run_values_last + 255;
			}
		}}},
		flag_crlf : true,
	});
	sc_gui_node({ w: 64, h : 64, text :{ str : "hover-alpha"},
		animation: { hover : { alpha: {
			delay:1, times:1, duration:100,
			formula: function() {
				return run_values_last - 0.01;
			}
		}}},
		flag_crlf : true,
	});
});
