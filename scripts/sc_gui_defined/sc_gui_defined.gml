enum GUI_CLASS {
	// BASE NODE
	DEFAULT,
	CONTAINER,
	CLOSE,
	HIDE,
	SCREEN,
	DRAG,
	SCALE,
	SCROLLBAR,
	
	// ANIMATION
	ANIMATION,
	ANIMATION_PROP,

	// SHAPE
	SHAPE_RECT,
	SHAPE_ROUNDRECT,
	SHAPE_SPRITE,
	SHAPE_CIRCLE,

	// DECORATE
	TEXT,
	SPRITE,
	TRIANGLE,
	RECT,
	ROUNDRECT,
	CIRCLE,
	
	// line
	LINE,
	BEZIER,
	
	// WIDGET
	SCHECKBOX,
	MCHECKBOX,
	
	TEXTBOX,

	INPUTBOX,

	SLIDER,
	SLIDER_CELL,
	
	SELECTOR,
	SELECTOR_LIST,
	SELECTOR_ELEM,
	
	TREE,
	TREE_ELEM,
	
	TAB_MENU,
	TAB_ELEM,
	
	WINDOW,
	
	GRID,
	GRID_SLOT,
	
	GOODS,
	GOODS_SLOT,
	GOODS_SHELF,

	MAX,
}

enum GUI_AXIS_TYPE {
	NONE = 0,
	HORIZONTAL = 1,
	VERTICAL = 2,
	BOTH = 3,
}

enum GUI_STATUS {
	NONE = 0,
	FOCUS = 1,
	HOVER = 2, // If status is hover, then it must be press.
	PRESS = 4,
	HOLD  = 8,
}

enum GUI_EVENT {
	CREATE,
	INSERT,
	UPDATE,
	RETRIEVE,
	DELETE,
}

function sc_gui_is_fast_classid(__classid)
{
	gml_pragma("forceinline");
	
	//var _typeof = typeof(__classid);
	// why this type is int64\real\numberic, 
	return (is_numeric(__classid)) && 
		(GUI_CLASS.DEFAULT <= __classid && __classid < GUI_CLASS.MAX);
}

