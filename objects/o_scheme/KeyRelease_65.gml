stamp = current_time

global.gui.scheme.register(self, timeout, 1, function(__self) {
	with (__self) {
		show_debug_message("current_time:" + string(current_time - stamp) + "ms"
			+ ",timeout=" + string(timeout));
		stamp = current_time
	}
});
timeout += 10;

