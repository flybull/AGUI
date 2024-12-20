/// @function:		sc_string_split(__substr, __string)
/// @description:	split string by split substr
/// @param:			{__string} substr
/// @param:         {__string} string

//function sc_string_split_old(__substr, __string)
//{
//	var _len = string_byte_length(__string);
//	var _spos, _epos = 0;
//	var _str = [];
//	var _num = 0;
//	var _first = true;
//	for (_spos = string_pos_ext(__substr, __string, _epos); _spos != 0; _spos = _epos) {
//		_epos = string_pos_ext(__substr, __string, _spos);
//		if (_first) {
//			_first = false;
//			if (_spos - 1 != 0) {
//				_str[@ _num] = string_copy(__string, 0, _spos - 1);
//				_num ++;
//			}
//		}
//		if (_epos != 0) {
//			_str[@ _num] = string_copy(__string, _spos + 1, _epos - _spos - 1);
//		} else {
//			_str[@ _num] = string_copy(__string, _spos + 1, _len - _spos);
//		}
//		_num ++;
//	}
//	return _str;
//}

/// @function:		sc_string_split(__substr, __string)
/// @description:	split string by split substr
/// @param:			{__string} substr
/// @param:         {__string} string
function sc_string_split(__substr, __string)
{
	var _len = string_byte_length(__string);
	var _spos, _epos = 0;
	var _str = [];
	var _num = 0;
	var _first = true;
	for (_spos = string_pos_ext(__substr, __string, _epos); _spos != 0; _spos = _epos) {
		_epos = string_pos_ext(__substr, __string, _spos + 1);
		if (_first) {
			_first = false;
			if (_spos - 1 != 0) {
				_str[@ _num] = string_copy(__string, 0, _spos - 1);
				_num ++;
			}
		}
		if (_epos != 0) {
			_str[@ _num] = string_copy(__string, _spos + 1, _epos - _spos - 1);
		} else {
			_str[@ _num] = string_copy(__string, _spos + 1, _len - _spos);
		}
		_num ++;
	}
	return _str;
}
