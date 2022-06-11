function sc_gui_affiliation_update_origin(__origin)
{
	gml_pragma("forceinline");
	origin = __origin;
	sc_ds_list_foreach(childs, sc_gui_affiliation_update_origin, __origin);
	sc_ds_list_foreach(decorate, sc_gui_affiliation_update_origin, __origin);
}
			
function sc_gui_affiliation_to_none()
{
	gml_pragma("forceinline");
	sc_gui_list_delete(parent.childs, self);
	sc_gui_grid2_unmark_complex(self);
	parent = undefined;
	//origin = self;
	sc_gui_affiliation_update_origin(self);
	//status_draw = true;
	origin.status_draw = true;
}

function sc_gui_affiliation_to_root()
{
	gml_pragma("forceinline");
	sc_gui_list_delete(parent.childs, self);
	sc_gui_grid2_unmark_complex(self);
	sc_gui_list_add(global.gui.list_node, self);
	parent = undefined;
	//origin = self;
	sc_gui_affiliation_update_origin(self);
	status_draw = true;
	origin.status_draw = true;
}


