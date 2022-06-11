/// @function		sc_gui_node_uri_router(__uri)
/// @description	Router to a gui node.
function sc_gui_node_uri_router(__uri)
{
	if (is_undefined(__uri)) {
		return undefined;
	}
	var _props = sc_string_split("/", __uri);
	var _num = array_length(_props);
	var _obj = self;
	
	for (var i = 0; i < _num && !is_undefined(_obj); ++i) {
		switch (_props[i]) {
		case "self":
			break;
		case "origin":
		case "parent":
		case "scrollbar":
		case "shape":
			_obj = variable_struct_get(_obj, _props[i]);
			break;
		case "childs":
		case "decorate":
			if (i + 2 >= _num) {
				sc_assert(false, "must than 2");
				return undefined;
			}
			i += 2;
			with (_obj) {	
				switch(_props[i - 1]) {
				case "sid":
					_obj = sc_gui_global_node_find(int64(_props[i]));
					break;
				case "cid":
				case "prvid":
				case "pubid":
				case "markid":
					_obj = sc_ds_list_find(_props[i - 2], function(__args) {
						var _value = variable_struct_get(self, __args[0]);
						if (_value == __args[1] || _value == int64(__args[1])) {
							return true;
						}
						return false;
					}, [_props[i - 1], _props[i]]);
					break;
				case "idx":
					_obj = variable_struct_get(_obj, _props[i - 2]);
					_obj = ds_list_find_value(_obj, int64(_props[i]));
					break;
				default:
					// error
					exit;
				}
			}
			break;
		case "friends":
			if (i + 1 >= _num) {
				sc_assert(false, "must than 1");
				return undefined;
			}
			i += 1;
			_obj = _obj.friends[? _props[i]];
			break;
		case "sid":
			if (i + 1 >= _num) {
				sc_assert(false, "must than 1");
				return undefined;
			}
			i += 1;
			_obj = sc_gui_global_node_find(int64(_props[i]));
			break;
		default:
			_obj = variable_struct_get(_obj, _props[i]);
			break;
		}
	}
	return _obj;
}
