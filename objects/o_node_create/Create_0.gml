// 调用的sc_gui_node而不是sc_gui_tree，,需要修改
sc_gui_node_event_create_by_args({
	x : x, y : y, 
	cid : "default",
	attr : { w : 128, h: 64, padding : 8},
	childs : [{
		cid : "tree", attr : {str : "Time"},
		childs : [
			{cid : "tree_elem",  attr : {str : "Monday"}},
			{cid : "tree_elem",  attr : {str : "Tuesday"}},
			{cid : "tree_elem",  attr : {str : "Wednesday"}},
			{cid : "tree_elem",  attr : {str : "Thursdays"}},
			{cid : "tree_elem",  attr : {str : "Friday"}},
			{cid : "tree_elem",  attr : {str : "Saturday"}},
			{cid : "tree_elem",  attr : {str : "Sunday"}},
			{cid : "tree", attr : {str : "Number"}, childs:[
				{cid : "tree_elem",  attr : {str : "1"}},
				{cid : "tree_elem",  attr : {str : "2"}},
				{cid : "tree_elem",  attr : {str : "3"}},
				{cid : "tree_elem",  attr : {str : "4"}},
				{cid : "tree_elem",  attr : {str : "5"}},
				{cid : "tree_elem",  attr : {str : "6"}},
				{cid : "tree_elem",  attr : {str : "7"}},
				{cid : "tree", attr : {str : "Char"}, childs:[
					{cid : "tree_elem",  attr : {str : "a"}},
					{cid : "tree_elem",  attr : {str : "b"}},
					{cid : "tree_elem",  attr : {str : "c"}},
					{cid : "tree_elem",  attr : {str : "d"}},
					{cid : "tree_elem",  attr : {str : "e"}},
					{cid : "tree_elem",  attr : {str : "f"}},
					{cid : "tree_elem",  attr : {str : "g"}},
				]},
			]},
		],
	}],
});


