stamp = current_time
timeout = 1;
time = get_timer();
global.gui.scheme.register(self, 1000, 2, function(__self) {
	with (__self) {
		show_debug_message("current_time:" + string(current_time - stamp) + "ms");
		stamp = current_time;
	}
});