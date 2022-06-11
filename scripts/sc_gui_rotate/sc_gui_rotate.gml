function sc_gui_rotate(__rotate, __offset_x, __offset_y)
{
	gml_pragma("forceinline");
	var _x = 0;
	var _y = 0;
	var _x0 = _x + __offset_x;
	var _y0 = _y + __offset_y
	
	// 坐标系变化
	// [1  0 -x0] [cos()   sin()  0 ] [1  0  x0]  [ x]
	// [0  1  y0] [sin()  -cos()  0 ] [0  1  y0]  [ y]
	// [0  0   1] [  0      0     1 ] [0  0   1]  [ 1]	
	var _r0 = [
		_x + _x0,
		_y + _y0,
	];
	var _r1 = [
		dcos(__rotate) * _r0[0] + dsin(__rotate) * _r0[1], 
		dsin(__rotate) * _r0[0] - dcos(__rotate) * _r0[1], 
	];
	var _r2 = [
		_r1[0] - _x0, 
		_r1[1] + _y0,
	];
	return _r2;
}

function sc_gui_rotate_to_origin(__point, __rotate, __offset_x = 0, __offset_y = 0)
{
	gml_pragma("forceinline");
	if (__rotate != 0) {
		var _angle = point_direction(__offset_x, __offset_y, __point[0], __point[1]);
		var _length = point_distance(__offset_x, __offset_y, __point[0], __point[1]);
		__point[@ 0] = _length * dcos(_angle + __rotate);
		__point[@ 1] = _length * -dsin(_angle + __rotate);
	}
}

function sc_gui_rotate_to_transfer(__point, __rotate, __offset_x = 0, __offset_y = 0)
{
	gml_pragma("forceinline");
	if (__rotate != 0) {
		var _angle = point_direction(__offset_x, __offset_y, __point[0], __point[1]);
		var _length = point_distance(__offset_x, __offset_y, __point[0], __point[1]);
		__point[@ 0] = _length * dcos(_angle - __rotate);
		__point[@ 1] = _length * -dsin(_angle - __rotate);
	}
}

function sc_gui_rotate_rect_wh(__angle, __width, __height)
{
	gml_pragma("forceinline");
	var _cos = dcos(__angle);
	var _sin = dsin(__angle);
	var _wc = __width * _cos;
	var _ws = __width * _sin;
	var _hc = -__height * _cos;
	var _hs = -__height * _sin;
	var _maxw = max(0, _wc, _wc - _hs, -_hs);
	var _maxh = max(0, _hc, _ws + _hc, _ws);
	var _minw = min(0, _wc, _wc - _hs, -_hs);
	var _minh = min(0, _hc, _ws + _hc, _ws);
	
	// Calc is No problem, But the rotation matrix is not accurate enough.
	//width, height, shift_x, shift_y,
	return [ceil(_maxw - _minw), ceil(_maxh - _minh), ceil(-_minw), floor(_maxh)];
}
