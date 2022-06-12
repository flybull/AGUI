# AGUI
    A GAMEMAKER GUI框架 
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

# 1. 如何使用
1. `o_gui_impl` 将o_gui_impl房子放在instance层
2. `o_gui_impl` 将o_gui_impl创建顺序设置到最前
3. `o_gui_test` 创建一个实例, 方式在instance层并实现相应功能
---
## 1.1 如何创建一个节点
```gml
// 与实例在instance中的坐标保持一致
node = sc_gui_root({ x: x, y: y}, function() {
    sc_gui_text({str:"hello world"});
});
```
---

## 1.2 如何删除一个节点
```gml
// 在destroy事件中调用
sc_gui_node_event_delete_by_obj(node);
```
---

## 1.3 如何更新一个节点属性 - 
说明：关联到其他节点变化是采用， 其他情况可以直接访问和设置变量</br>
查看文件 GUI/core/sc_curd/sc_gui_update `sc_gui_node_event_update_by_args` or `sc_gui_node_event_update_by_uri`
```gml
    // 更新节点的宽度
    sc_gui_node_event_update_by_args({w : _width});

    // 同步 src node 的text_str属性 到 dst node 的str属性
    // src: self->decorate->(cid == text)          attr: text_str
    // dst: self->parent->decorate->(cid == text)  attr: str
    sc_gui_node_event_update_by_uri(
		"/decorate/cid/" + string(GUI_CLASS.TEXT), "text_str", 
		"/parent/decorate/cid/" + string(GUI_CLASS.TEXT), "str"
    );
```
---

## 1.4 如何制作节点
0. 定义一个组件的名字 {name}
1. 定义一个组件的类型 GUI_CLASS.{TYPE} 
2. 定义一个构造函数 function `sc_gui_{name}_construct`
    * 设置 `sc_gui_global_set_class_construct`
3. 定义一个配置构造函数 function `sc_gui_{name}_config_construct`
    * 设置 `sc_gui_config_attr_alias_set`
    * 设置 `sc_gui_config_attr_value_set`
    * 设置 `sc_gui_config_attr_parse_set`
4. 定义一个组件创建方法 `sc_gui_{name}`
5. 替换 {name},{TYPE} 为具体的 name and type.
6. 可以参考o_example

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
    // 设置解析对应别名
    sc_gui_config_attr_alias_set(_class, ["debug_one", "debug_aa"], "debug");
    // 设置节点默认值
    sc_gui_config_attr_value_set(_class, {
        debug : "",
        func_on_press : function () { show_debug_message(debug); }
    });
    // 设置解析函数
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

// 在instance层的创建事件中实现(o_gui_test)
function object_event_create() {
    // in create
    node = sc_gui_root({x: 200, y: 200}, function() {
        sc_gui_example({w: 64, h: 64, debug_one: "hello world"});
    });
}
// 在instance层的销毁事件中实现(o_gui_test)
function object_event_destroy() {
    sc_gui_node_event_delete_by_obj(node);
}
```
## 1.5 如何布局
See `o_node_direct_flex`
1. 自定义(自己声明坐标位置)
2. FLEX布局 (默认方式)</br>
    1. 父节点会约束子节点的位置(行， 列， 反方向行、列)
3. GRID 网格布局