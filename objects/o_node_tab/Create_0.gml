gui_node = sc_gui_root({ x: x, y: y, w : 128, h: 64, padding: 8, flag_scroll : GUI_AXIS_TYPE.NONE}, function() {
	sc_gui_tab_menu({ w : 256, h: 256}, function() {
		sc_gui_tab_elem({str : "Time1"}, function() {
			sc_gui_node({w : 32, h :32, text:{str:"hellosssssssssssssssssssssssssssssssssssssssssss1"}});
		});
		sc_gui_tab_elem({str : "Time2"}, function() {
			sc_gui_node({w : 32, h :32, text:{str:"hellossssssssssssssssssssssssssssssssssssssssssshello2"}});
		});
		sc_gui_tab_elem({str : "Time3"}, function() {
			sc_gui_node({w : 32, h :32, text:{str:"hellossssssssssssssssssssssssssssssssssssssssssshello3"}});
		});
		sc_gui_tab_elem({str : "Time4"}, function() {
			sc_gui_tree({str : "Time"}, function() {
				sc_gui_tree_elem({str : "Monday"});
				sc_gui_tree_elem({str : "Tuesday"});
				sc_gui_tree_elem({str : "Wednesday"});
				sc_gui_tree_elem({str : "Thursdays"});
				sc_gui_tree_elem({str : "Friday"});
				sc_gui_tree_elem({str : "Saturday"});
				sc_gui_tree_elem({str : "Sunday"});
				sc_gui_tree({str :"Number"}, function() {
					sc_gui_tree_elem({str : "1"});
					sc_gui_tree_elem({str : "2"});
					sc_gui_tree_elem({str : "3"});
					sc_gui_tree_elem({str : "4"});
					sc_gui_tree_elem({str : "5"});
					sc_gui_tree_elem({str : "6"});
					sc_gui_tree_elem({str : "7"});
				});
			});
		});
	});
});

