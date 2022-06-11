function sc_graphs_bezier_draw(__points, __color, __width, __delta = 0.05)
{
	var _pointl = undefined
	var _calc;
	if (!is_array(__points)) {
		exit;
	}
	switch (array_length(__points)) {
	case 0:
		exit;
	case 1:
		draw_point_color(__points[0][0], __points[1][0], __color);
		exit;
	case 2:
		draw_line_width_color(__points[0][0], __points[1][0], __points[1][0], __points[1][1], __width, __color, __color);
		exit;
	case 3:
		_calc = sc_graphs_calc_bezier_cubic;
		break;
	case 4:
		_calc = sc_graphs_calc_bezier_quad;
		break;
	default:
		_calc = sc_graphs_calc_bezier_n;
		break;
	}
	
	for (var __t = 0; __t <= 1; __t += __delta) {
		var _point = _calc(__points, __t) ;
		if (is_undefined(_pointl)) {
			_pointl = _point;
		} else {
			draw_line_width_color(_pointl[0], _pointl[1], _point[0], _point[1], __width, __color, __color);
			_pointl = _point;
		}
	}
}

function sc_graphs_calc_bezier_cubic(__points, __t)
{
	gml_pragma("forceinline");
    var u = 1.0 - __t;
    var w1 = u * u;
	var w2 = 2 * u * __t;
    var w3 = __t * __t;
    return [
		w1 * __points[0][0] + w2 * __points[1][0] + w3 * __points[2][0],
		w1 * __points[0][1] + w2 * __points[1][1] + w3 * __points[2][1]
	];
}

function sc_graphs_calc_bezier_quad(__points, __t)
{
	gml_pragma("forceinline");
    var u = 1.0 - __t;
    var w1 = u * u * u;
    var w2 = 3 * u * u * __t;
    var w3 = 3 * u * __t * __t;
    var w4 = __t * __t * __t;
    return [
		w1 * __points[0][0] + w2 * __points[1][0] + w3 * __points[2][0] + w4 * __points[3][0],
		w1 * __points[0][1] + w2 * __points[1][1] + w3 * __points[2][1] + w4 * __points[3][1]
	];
}

function sc_graphs_calc_bezier_n(__points, _t)
{
	gml_pragma("forceinline");
	var n = array_length(__points);
	if (n == 1) {
		return __points[0];
	}
	var _vec = [];
	for (var i = 0; i + 1 < n; ++i) {
		array_push(_vec, [
			__points[i][0] + _t * (__points[i + 1][0] - __points[i][0]),
			__points[i][1] + _t * (__points[i + 1][1] - __points[i][1])
		]);
	}
	return sc_graphs_calc_bezier_n(_vec, _t);
}

//function sc_graphs_calc_bezier_quad_gpu(__points, __color, __t)
//{
	//var x0 = __points[0][0];
	//var y0 = __points[0][1];
	//var x1 = __points[1][0];
	//var y1 = __points[1][1];
	//var x2 = __points[2][0];
	//var y2 = __points[2][1];
	//var x3 = __points[3][0];
	//var y3 = __points[3][1];
	//draw_circle(x0, y0, 4, false);
	//draw_circle(x1, y1, 4, false);
	//draw_circle(x2, y2, 4, false);
	//draw_circle(x3, y3, 4, false);

	//draw_line(x0, y0, x1, y1);
	//draw_line(x1, y1, x2, y2);
	//draw_line(x2, y2, x3, y3);

	//draw_primitive_begin(pr_linestrip);

	//var _count = floor(1 / __t);
	//var _t = 0;
	//repeat(_count)
	//{
	//    var _inv_t = 1 - _t;
	//    draw_vertex_colour(
	//		_inv_t*_inv_t*_inv_t*x0 + 3.0*_inv_t*_inv_t*_t*x1 + 3.0*_inv_t*_t*_t*x2 + _t*_t*_t*x3,
	//        _inv_t*_inv_t*_inv_t*y0 + 3.0*_inv_t*_inv_t*_t*y1 + 3.0*_inv_t*_t*_t*y2 + _t*_t*_t*y3,
	//		__color, 1);
	//    _t += 1/(_count-1);
	//}

	
	//draw_primitive_end();
//}


 
