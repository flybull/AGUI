sc_gui_config_set_attr_parse_once({
		cid : GUI_CLASS.DEFAULT, 
		inherit : GUI_CLASS.DEFAULT
	}, "empty", function(__attr, __name, __realname, __self) {
		variable_struct_get(__attr, __name)
}, "test");

var bstamp;
var estamp;

bstamp = current_time;
var n = 10000;
for (var i = 0; i < 10000; i++) {
	sc_gui_config_get_attr_parse({
		cid : GUI_CLASS.DEFAULT, 
		inherit : GUI_CLASS.DEFAULT
	}, "cid")({ empty : 1 }, "empty");
}
estamp = current_time;
show_debug_message("use:" + string(n * 1000 / (bstamp - estamp)) + "/s.");


bstamp = current_time;
for (var i = 0; i < 10000; i++) {
	sc_gui_config_get_attr_parse({
		cid : GUI_CLASS.DEFAULT, 
		inherit : GUI_CLASS.DEFAULT
	}, "empty")({ empty : 1 }, "empty");
}
estamp = current_time;
show_debug_message("use:" + string(n * 1000 / (bstamp - estamp)) + "/s.");

bstamp = current_time;
for (var i = 0; i < 10000; i++) {
	variable_struct_get({ empty : 1 }, "empty");
}
estamp = current_time;
show_debug_message("use:" + string(n * 1000 / (bstamp - estamp)) + "/s.");



xxx = "hellow";

xxxx = ptr(xxx);
xxx += "xx";
//xxx = string_set_byte_at(xxx, 2, 97);
function setxxx(str) {
	str = "xxx";
}
show_debug_message(string(xxxx) + "|" + xxx + "|" );

setxxx(xxx);
show_debug_message(xxx);