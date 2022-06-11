gui_node = sc_gui_root({ x: x, y: y,  w: 64, h : 64, text :{ str : "hover-rotate"},
	animation: { hover : { rotate: {
		delay:1, times:1, duration:100,
		formula: function() {
			return [run_values_last[0] + 3.6, 32, 32];
		}
	}}},
});
