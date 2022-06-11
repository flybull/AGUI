gui_node = sc_gui_root({ 
	x: x, y: y, 
	w : 64, h : 64, padding: 8,
	block_direct: GUI_FLEX_DIRECT.COL,
	flag_scale : GUI_AXIS_TYPE.BOTH, 
	flag_scroll : GUI_AXIS_TYPE.NONE,
	flag_wrap : true},
	 function() {
		 sc_gui_node({w : 16, h : 16, padding: 2, flag_scale : GUI_AXIS_TYPE.BOTH/*, flag_stretch : true*/});
		 sc_gui_node({w : 16, h : 16, padding: 2, flag_scale : GUI_AXIS_TYPE.BOTH});
		 sc_gui_node({w : 16, h : 16, padding: 2, flag_scale : GUI_AXIS_TYPE.BOTH});
		 sc_gui_node({w : 16, h : 16, padding: 2, flag_scale : GUI_AXIS_TYPE.BOTH});
		 sc_gui_node({w : 32, h : 32, ashape : {type:"sprite", spr: s_heart}, padding: 2, flag_scale : GUI_AXIS_TYPE.BOTH});
		//sc_gui_container({w : 128, h : 64, spr : Sprite5, flex_algin : "start", flex_justify : "start"},  function() {
		//	sc_gui_sprite({spr : s_drag6});
		//	sc_gui_sprite({spr : s_drag8});
	}
);

