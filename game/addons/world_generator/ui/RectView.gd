tool
extends Control

var rect_editor_node_scene : PackedScene = preload("res://addons/world_generator/ui/RectViewNode.tscn")

var edited_resource : WorldGenBaseResource = null

func _draw():
	draw_rect(Rect2(Vector2(), get_size()), Color(0.2, 0.2, 0.2, 1))
	
func refresh() -> void:
	clear()
	
	if !edited_resource:
		return
	
	var rect : Rect2 = edited_resource.rect
	
	set_custom_minimum_size(rect.size)
	
	var p : MarginContainer = get_parent() as MarginContainer

	p.add_constant_override("margin_left", rect.size.x / 4.0)
	p.add_constant_override("margin_right", rect.size.x / 4.0)
	p.add_constant_override("margin_top", rect.size.y / 4.0)
	p.add_constant_override("margin_bottom", rect.size.y / 4.0)
	
	refresh_rects()
	
func clear() -> void:
	pass
	
func refresh_rects() -> void:
	clear_rects()
	
	if !edited_resource:
		return
	
	var cont : Array = edited_resource.get_content()
	
	for c in cont:
		if c:
			var s : Node = rect_editor_node_scene.instance()
			
			add_child(s)
			s.set_edited_resource(c)

func clear_rects():
	for c in get_children():
		c.queue_free()
		remove_child(c)

func set_edited_resource(res : WorldGenBaseResource):
#	if edited_resource:
#		edited_resource.disconnect("changed", self, "on_edited_resource_changed")
	
	edited_resource = res
	
	refresh()
	
#	if edited_resource:
#		edited_resource.connect("changed", self, "on_edited_resource_changed")

#func on_edited_resource_changed() -> void:
#	pass