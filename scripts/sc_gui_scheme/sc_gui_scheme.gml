#macro sc_gui_scheme_wheel_scale  21609 // 360000

function sc_gui_scheme_wheel() constructor {
	var _nums = sc_gui_scheme_wheel_scale; // 60 minute 60 second 100 millisecond
	wheel  = array_create(_nums, undefined);
	events = ds_queue_create();
	for (var i = 0; i < 100; ++i) {
		var _ev = new sc_gui_scheme_event();
		ds_queue_enqueue(events, _ev);
	}
	sn_num = 100;
	sns = array_create(sn_num, undefined);
	sni = array_create(sn_num, undefined);
	last_zone = 0;
	precision = game_get_speed(gamespeed_microseconds) / 1000;

	static register = function(__oid, __delay_ms, __times, __function) {
		var _ev = ds_queue_dequeue(events);
		if (is_undefined(_ev)) {
			_ev = new sc_gui_scheme_event();
			if (_ev.sn >= sn_num) {
				sn_num += array_length(sni);
				array_resize(sns, sn_num);
				array_copy(sns, sn_num, sni, 0, array_length(sni));
			}
		}
		sc_gui_scheme_init(_ev, __oid, __delay_ms, __times, __function, precision);
		sc_gui_scheme_register(_ev);

		return _ev.sn;
	}
	static unregister = function(__oid, __sn) {
		if (__sn >= sn_num) {
			exit;
		}
		var _zone = sns[__sn][0];
		var _index = sns[__sn][1];
		var _list = wheel[_zone];
		if (is_undefined(_list)) {
			exit;
		}
		if (_index < ds_list_size(_list)) {
			var _ev = _list[| _index];
			if (_ev.sn = __sn && _ev.oid == __oid) {
				ds_list_delete(_list, _index);
				sns[@ __sn] = undefined;
				ds_queue_enqueue(events, _ev);
			}
		}
	}
	static scanner = function() {
		var _zone = floor(((current_time + 0) / precision) % sc_gui_scheme_wheel_scale);
		//estamp = current_time;
		//show_debug_message("use:" + string((estamp - bstamp)) + "ms." + "_zone:" + string(_zone));
		//bstamp = estamp;

		if (last_zone < _zone) {
			for (var _lzone = last_zone; _lzone < _zone; ++_lzone) {
			 	sc_gui_scheme_scan_one(_lzone);
			}
		} else {
			sc_gui_scheme_scan_one(_zone);
		}
		last_zone = _zone;
	}
}

function sc_gui_scheme_scan_one(__zone)
{
	var _list = wheel[__zone];
	if (is_undefined(_list)) {
		exit;
	}
	var n = ds_list_size(_list);
	var i = 0;
	while (i < n) {
		var _ev = _list[| i];

		if (_ev.timeround) {
			_ev.timeround -= 1;
			++i;
			continue;
		}
				
		_ev.callback(_ev.oid);
			
		if (sc_gui_scheme_reuse(_ev, precision)) {
			ds_list_delete(_list, i);
			sns[@ _ev.sn] = undefined;
			sc_gui_scheme_register(_ev);
			++i;
		} else {
			unregister(_ev.oid, _ev.sn);
			n = ds_list_size(_list);
		}
	}	
}

function sc_gui_scheme_event() constructor {
	static _sequenced = 0;
	sn = _sequenced++;
	oid = undefined;
	delay_ms = 0; 
	times = 0;
	timeround = -1;
	zone = -1;
	callback = undefined;
}

function sc_gui_scheme_init(__ev, __oid, __delay_ms, __times, __function, __precision)
{
	with (__ev) {
		var _time = (current_time + __delay_ms) / __precision;
		oid = __oid;
		delay_ms = __delay_ms; 
		times = __times;
		timeround =  floor(_time / sc_gui_scheme_wheel_scale);
		zone = floor(_time % sc_gui_scheme_wheel_scale);
		callback = method(undefined, __function);
	}

}

function sc_gui_scheme_reuse(__ev, __precision)
{
	__ev.times -= 1;
	if (__ev.times >= 1) {
		with (__ev) {
			var _time = floor((current_time + delay_ms) / __precision);
			timeround =  floor(_time / sc_gui_scheme_wheel_scale);
			zone = floor(_time % sc_gui_scheme_wheel_scale);
		}
		return true;
	}
	return false;
}

function sc_gui_scheme_register(__ev)
{
	gml_pragma("forceinline");
	var _zone = __ev.zone;
	var _list = wheel[_zone];
	if (is_undefined(_list)) {
		_list = ds_list_create();
		 wheel[@ _zone] = _list;
	}
	var _index = ds_list_size(_list);
	ds_list_add(_list, __ev);
	sns[@ __ev.sn] = [_zone, _index];
}

