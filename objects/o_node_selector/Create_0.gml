gui_node = sc_gui_root({ x: x, y: y, w : 256, h : 64, padding: 8, flag_scroll : GUI_AXIS_TYPE.BOTH}, function() {
	sc_gui_node({w : 512, h : 128, flag_stretch : true});
	sc_gui_node({w : 150, h : 128, flag_stretch : false});
	sc_gui_container({w :128, h : 128, flag_stretch : false, flag_scroll : GUI_AXIS_TYPE.NONE}, function() {
		sc_gui_node({w : 512, h : 128, flag_stretch : true});
		sc_gui_node({w : 150, h : 128, flag_stretch : false});
		sc_gui_selector({ w : 128, padding: 8, flag_stretch : false}, function() {
			sc_gui_selector_elem({text: {str : "Monday"}});
			sc_gui_selector_elem({text: {str : "Tuesday"}});
			sc_gui_selector_elem({text: {str : "Wednesday"}});
			sc_gui_selector_elem({text: {str : "Thursdays"}});
			sc_gui_selector_elem({text: {str : "Friday"}});
			sc_gui_selector_elem({text: {str : "Saturday"}});
			sc_gui_selector_elem({text: {str : "Sunday"}});
			sc_gui_selector({text: {str :"Number"}}, function() {
				sc_gui_selector_elem({text: {str : "1"}});
				sc_gui_selector_elem({ashape : { type : "sprite", spr: s_drag}, text: {str : "2"}});
				sc_gui_selector_elem({ashape : { type : "sprite", spr: s_drag}, text: {str : "3"}});
				sc_gui_selector_elem({ashape : { type : "sprite", spr: s_drag}, text: {str : "4"}});
				sc_gui_selector_elem({ashape : { type : "sprite", spr: s_drag}, text: {str : "5"}});
				sc_gui_selector_elem({ashape : { type : "sprite", spr: s_drag}, text: {str : "6"}});
				sc_gui_selector_elem({ashape : { type : "sprite", spr: s_drag}, text: {str : "7"}});
			});
		});
		sc_gui_node({w : 150, h : 128, flag_stretch : true});
		sc_gui_node({w : 512, h : 128, flag_stretch : true});
	});
	sc_gui_node({w : 150, h : 128, flag_stretch : true});
	sc_gui_node({w : 512, h : 128, flag_stretch : true});
});

