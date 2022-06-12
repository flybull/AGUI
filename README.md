# AGUI
    A GAMEMAKER GUI
---
# SUPPORT
* button
* drag
* scale
* scrollbar
* checkbox
* grid
* goods
* input
* selector
* slider
* tab
* tree
* windown
* animation
# 1. HOW TO USE
1. `o_gui_impl` place in instances layer
2. `o_gui_impl` adjust create order to top 
3. `o_gui_test` create a object and place in instance layer
---
## 1.1 HOW TO CRATE NODE
```gml
node = sc_gui_root({ x: x, y: 200}, function() {
    sc_gui_text({str:"hello world"});
});
```
---

## 1.2 HOW TO DELETE NODE
```gml
sc_gui_node_event_delete_by_obj(node);
```
---

## 1.3 HOW TO UPDATE NODE
Note: When node affects other node, then need use the method.</br>
See GUI/core/sc_curd/sc_gui_update `sc_gui_node_event_update_by_args` or `sc_gui_node_event_update_by_uri`
```gml
    // update node width
    sc_gui_node_event_update_by_args({w : _width});

    // sync src node text_str(attr) to dst node str(attr)
    // src: self->decorate->(cid == text)          attr: text_str
    // dst: self->parent->decorate->(cid == text)  attr: str
    sc_gui_node_event_update_by_uri(
		"/decorate/cid/" + string(GUI_CLASS.TEXT), "text_str", 
		"/parent/decorate/cid/" + string(GUI_CLASS.TEXT), "str"
    );
```
---

## 1.4 HOW TO SELF-DEFINED NODE
0. defined a component node {name}
1. defined a GUI_CLASS.{TYPE}
2. defined function `sc_gui_{name}_construct`
    * setting `sc_gui_global_set_class_construct`
3. defined function `sc_gui_{name}_config_construct`
    * setting `sc_gui_config_attr_alias_set`
    * setting `sc_gui_config_attr_value_set`
    * setting `sc_gui_config_attr_parse_set`
4. defined `sc_gui_{name}`
5. replace {name},{TYPE} to specific name and type.
6. reference o_example


```gml
function sc_gui_{name}_construct()
{
    gml_pragma("global", "sc_gui_{name}_construct()");
    var _classid = GUI_CLASS.{TYPE};
    sc_gui_global_set_class_construct(
        _classid, "{name}",
        sc_gui_{name}_config_construct,
        sc_gui_{name}
    );
}
function sc_gui_{name}_config_construct()
{
    var _class = {cid : GUI_CLASS.{TYPE}, inherit : GUI_CLASS.DEFAULT };
    // For parse
    sc_gui_config_attr_alias_set(_class, ["debug_one", "debug_aa"], "debug");
    // For default value
    sc_gui_config_attr_value_set(_class, {
        debug : "",
        func_on_press : function () { show_debug_message(debug); }
    });
    // For parse function
    sc_gui_config_attr_parse_set(_class, "debug", function(__attr, __name, __realname, __self) {
        var _val = variable_struct_get(__attr, __name);
        debug = string(_val);
    });
}

function sc_gui_{name}(__attr = undefined, __func_attach = undefined, __func_agrs = undefined)
{
    gml_pragma("forceinline");
    return sc_gui_node(__attr, __func_attach, __func_agrs, GUI_CLASS.{TYPE});
}

// In the object instance (create event)
function object_event_create() {
    // in create
    node = sc_gui_root({x: 200, y: 200}, function() {
        sc_gui_example({w: 64, h: 64, debug_one: "hello world"});
    });
}
// In the object instance (destroy event)
function object_event_destroy() {
    sc_gui_node_event_delete_by_obj(node);
}
```
## 1.5 HOW TO LAYOUT 
See `o_node_direct_flex`
1. SELF-DEFINED(Not Layout)
2. FLEX (default)</br>
    1. parent node constraint child node position(row rrow col rcol)
3. GRID 