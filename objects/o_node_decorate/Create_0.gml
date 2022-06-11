gui_node = sc_gui_root({ x: x, y: y, 
	w : 128, h : 32,
	ashape : { type : "rect" },
	sprite : { spr : s_drag6 , direct : "rrow"},
	texts :[
		{ param : { val : 100, val1 : "yuan" } },
		{ param : { money : 100, unit : "yuan" },
		  pattern : "I have $money $unit.", color : c_red,
		  direct : "rcol" }
	],
	sprite1 : { spr : s_drag },
});
