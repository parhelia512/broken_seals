tool
extends ScrollContainer

var _edited_resource : WorldGenBaseResource = null
var properties : Array = Array()

func add_slot_color(getter : String, setter : String) -> int:
	var cp : ColorPickerButton = ColorPickerButton.new()

	var slot_idx : int = add_slot(getter, setter, cp)
	
	cp.color = _edited_resource.call(getter)
	
	cp.connect("color_changed", _edited_resource, setter)
	
	return slot_idx

func add_slot_label(getter : String, setter : String, slot_name : String) -> int:
	var l : Label = Label.new()

	l.text = slot_name
	
	return add_slot(getter, setter, l)

func add_slot_line_edit(getter : String, setter : String, slot_name : String, placeholder : String = "") -> int:
	var bc : HBoxContainer = HBoxContainer.new()
	bc.set_h_size_flags(SIZE_EXPAND_FILL)

	var l : Label = Label.new()
	l.text = slot_name
	bc.add_child(l)
	
	var le : LineEdit = LineEdit.new()
	le.placeholder_text = placeholder
	le.set_h_size_flags(SIZE_EXPAND_FILL)
	bc.add_child(le)
	
	var slot_idx : int =  add_slot(getter, setter, bc)
	
	le.text = _edited_resource.call(getter)
	
	le.connect("text_entered", self, "on_slot_line_edit_text_entered", [ slot_idx ])
	
	return slot_idx

func add_slot_enum(getter : String, setter : String, slot_name : String, values : Array) -> int:
	var bc : VBoxContainer = VBoxContainer.new()
	
	if slot_name:
		var l : Label = Label.new()
		l.text = slot_name
		bc.add_child(l)
	
	var mb : OptionButton = OptionButton.new()
	
	for v in values:
		mb.add_item(v)
	
	bc.add_child(mb)
	
	var slot_idx : int = add_slot(getter, setter, bc)
	
	mb.selected = _edited_resource.call(getter)
	
	mb.connect("item_selected", self, "on_slot_enum_item_selected", [ slot_idx ])
	
	return slot_idx

func add_slot_int(getter : String, setter : String, slot_name : String, prange : Vector2 = Vector2(-1000, 1000)) -> int:
	var bc : VBoxContainer = VBoxContainer.new()
	
	var l : Label = Label.new()
	l.text = slot_name
	bc.add_child(l)
	
	var sb : SpinBox = SpinBox.new()
	sb.rounded = true
	sb.min_value = prange.x
	sb.max_value = prange.y
	bc.add_child(sb)
	
	var slot_idx : int = add_slot(getter, setter, bc)
	
	sb.value = _edited_resource.call(getter)
	
	sb.connect("value_changed", self, "on_int_spinbox_value_changed", [ slot_idx ])
	
	return slot_idx

func add_slot_bool(getter : String, setter : String, slot_name : String) -> int:
	var cb : CheckBox = CheckBox.new()
	cb.text = slot_name
	
	var slot_idx : int = add_slot(getter, setter, cb)
	
	cb.pressed = _edited_resource.call(getter)
	
	cb.connect("toggled", _edited_resource, setter)
	
	return slot_idx

func add_slot_float(getter : String, setter : String, slot_name : String, step : float = 0.1, prange : Vector2 = Vector2(-1000, 1000)) -> int:
	var bc : VBoxContainer = VBoxContainer.new()
	
	var l : Label = Label.new()
	l.text = slot_name
	bc.add_child(l)
	
	var sb : SpinBox = SpinBox.new()
	bc.add_child(sb)
	
	var slot_idx : int = add_slot(getter, setter, bc)
	sb.rounded = false
	sb.step = step
	sb.min_value = prange.x
	sb.max_value = prange.y
	sb.value = _edited_resource.call(getter)

	sb.connect("value_changed", self, "on_float_spinbox_value_changed", [ slot_idx ])
	
	return slot_idx

func add_slot_vector2(getter : String, setter : String, slot_name : String, step : float = 0.1, prange : Vector2 = Vector2(-1000, 1000)) -> int:
	var bc : VBoxContainer = VBoxContainer.new()
	
	var l : Label = Label.new()
	l.text = slot_name
	bc.add_child(l)
	
	var sbx : SpinBox = SpinBox.new()
	bc.add_child(sbx)
	
	var sby : SpinBox = SpinBox.new()
	bc.add_child(sby)
	
	var slot_idx : int = add_slot(getter, setter, bc)
	sbx.rounded = false
	sby.rounded = false
	sbx.step = step
	sby.step = step
	sbx.min_value = prange.x
	sbx.max_value = prange.y
	sby.min_value = prange.x
	sby.max_value = prange.y
	
	var val : Vector2 = _edited_resource.call(getter)
	
	sbx.value = val.x
	sby.value = val.y

	sbx.connect("value_changed", self, "on_vector2_spinbox_value_changed", [ slot_idx, sbx, sby ])
	sby.connect("value_changed", self, "on_vector2_spinbox_value_changed", [ slot_idx, sbx, sby ])
	
	return slot_idx
	
func add_slot_vector3(getter : String, setter : String, slot_name : String, step : float = 0.1, prange : Vector2 = Vector2(-1000, 1000)) -> int:
	var bc : VBoxContainer = VBoxContainer.new()
	
	var l : Label = Label.new()
	l.text = slot_name
	bc.add_child(l)
	
	var sbx : SpinBox = SpinBox.new()
	bc.add_child(sbx)
	
	var sby : SpinBox = SpinBox.new()
	bc.add_child(sby)
	
	var sbz : SpinBox = SpinBox.new()
	bc.add_child(sbz)
	
	var slot_idx : int = add_slot(getter, setter, bc)
	sbx.rounded = false
	sby.rounded = false
	sbz.rounded = false
	sbx.step = step
	sby.step = step
	sbz.step = step
	sbx.min_value = prange.x
	sbx.max_value = prange.y
	sby.min_value = prange.x
	sby.max_value = prange.y
	sbz.min_value = prange.x
	sbz.max_value = prange.y
	
	var val : Vector3 = _edited_resource.call(getter)
	
	sbx.value = val.x
	sby.value = val.y
	sbz.value = val.z

	sbx.connect("value_changed", self, "on_vector3_spinbox_value_changed", [ slot_idx, sbx, sby, sbz ])
	sby.connect("value_changed", self, "on_vector3_spinbox_value_changed", [ slot_idx, sbx, sby, sbz ])
	sbz.connect("value_changed", self, "on_vector3_spinbox_value_changed", [ slot_idx, sbx, sby, sbz ])
	
	return slot_idx


func add_slot_rect2(getter : String, setter : String, slot_name : String, step : float = 0.1, prange : Vector2 = Vector2(-10000, 10000)) -> int:
	var bc : VBoxContainer = VBoxContainer.new()
	
	var l : Label = Label.new()
	l.text = slot_name
	bc.add_child(l)
	
	var hc1 : HBoxContainer = HBoxContainer.new()
	bc.add_child(hc1)
	
	var sbx : SpinBox = SpinBox.new()
	hc1.add_child(sbx)
	
	var sby : SpinBox = SpinBox.new()
	hc1.add_child(sby)
	
	var hc2 : HBoxContainer = HBoxContainer.new()
	bc.add_child(hc2)
	
	var sbw : SpinBox = SpinBox.new()
	hc2.add_child(sbw)
	
	var sbh : SpinBox = SpinBox.new()
	hc2.add_child(sbh)
	
	var slot_idx : int = add_slot(getter, setter, bc)
	sbx.rounded = false
	sby.rounded = false
	sbw.rounded = false
	sbh.rounded = false
	sbx.step = step
	sby.step = step
	sbw.step = step
	sbh.step = step
	sbx.min_value = prange.x
	sbx.max_value = prange.y
	sby.min_value = prange.x
	sby.max_value = prange.y
	sbw.min_value = prange.x
	sbw.max_value = prange.y
	sbh.min_value = prange.x
	sbh.max_value = prange.y
	
	var val : Rect2 = _edited_resource.call(getter)
	
	sbx.value = val.position.x
	sby.value = val.position.y
	sbw.value = val.size.x
	sbh.value = val.size.y

	sbx.connect("value_changed", self, "on_rect2_spinbox_value_changed", [ slot_idx, [ sbx, sby, sbw, sbh ] ])
	sby.connect("value_changed", self, "on_rect2_spinbox_value_changed", [ slot_idx, [ sbx, sby, sbw, sbh ] ])
	sbw.connect("value_changed", self, "on_rect2_spinbox_value_changed", [ slot_idx, [ sbx, sby, sbw, sbh ] ])
	sbh.connect("value_changed", self, "on_rect2_spinbox_value_changed", [ slot_idx, [ sbx, sby, sbw, sbh ] ])
	
	return slot_idx

func add_slot(getter : String, setter : String, control : Control) -> int:
	var content_node = $MainContainer/Content
	
	content_node.add_child(control)
	var slot_idx : int = content_node.get_child_count() - 1
	
	var arr : Array = Array()
	
	arr.append(slot_idx)
	arr.append(getter)
	arr.append(setter)
	arr.append(control)
	
	properties.append(arr)

	return slot_idx

func get_property_control(slot_idx : int) -> Node:
	return properties[slot_idx][3]

func on_int_spinbox_value_changed(val : float, slot_idx) -> void:
	_edited_resource.call(properties[slot_idx][2], int(val))

func on_float_spinbox_value_changed(val : float, slot_idx) -> void:
	_edited_resource.call(properties[slot_idx][2], val)

func on_vector2_spinbox_value_changed(val : float, slot_idx, spinbox_x, spinbox_y) -> void:
	var vv : Vector2 = Vector2(spinbox_x.value, spinbox_y.value)
	
	_edited_resource.call(properties[slot_idx][2], vv)

func on_vector3_spinbox_value_changed(val : float, slot_idx, spinbox_x, spinbox_y, spinbox_z) -> void:
	var vv : Vector3 = Vector3(spinbox_x.value, spinbox_y.value, spinbox_z.value)
	
	_edited_resource.call(properties[slot_idx][2], vv)

func on_rect2_spinbox_value_changed(val : float, slot_idx, spinboxes) -> void:
	var vv : Rect2 = Rect2(spinboxes[0].value, spinboxes[1].value, spinboxes[2].value, spinboxes[3].value)
	
	_edited_resource.call(properties[slot_idx][2], vv)

func on_slot_enum_item_selected(val : int, slot_idx : int) -> void:
	_edited_resource.call(properties[slot_idx][2], val)

func on_slot_line_edit_text_entered(text : String, slot_idx : int) -> void:
	_edited_resource.call(properties[slot_idx][2], text)

func clear() -> void:
	properties.clear()

	var content_node = $MainContainer/Content
	
	if !content_node:
		return
	
	for c in content_node.get_children():
		c.queue_free()
		content_node.remove_child(c)

func refresh() -> void:
	clear()
	
	if _edited_resource:
		_edited_resource.setup_property_inspector(self)
		
		if !_edited_resource.is_connected("changed", self, "on_edited_resource_changed"):
			_edited_resource.connect("changed", self, "on_edited_resource_changed")

func edit_resource(wgw) -> void:
	if _edited_resource:
		_edited_resource.disconnect("changed", self, "on_edited_resource_changed")
	
	_edited_resource = wgw
	
	refresh()

func on_edited_resource_changed() -> void:
	refresh()
