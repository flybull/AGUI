gui_node = sc_gui_root({ x: x, y: y, padding: 8}, function() {
	sc_gui_scheckbox(["flex-algin: start", "flex-algin: center", "flex-algin: end"]);
	sc_gui_scheckbox(["flex-justify: start", "flex-justify: center", "flex-justify: end"]);
	sc_gui_scheckbox(["flex-direct: row", "flex-direct: rrow", "flex-direct: col", "flex-direct: rcol"]);
	//sc_gui_node({spr : s_drag8, flag_stretch : true});
	//sc_gui_selector();
	//sc_gui_node({bh:256, spr : s_drag8, flag_stretch : true});
});

