tool
extends Resource
class_name WorldGenBaseResource

export(Rect2) var rect : Rect2 = Rect2(0, 0, 100, 100)
export(bool) var locked : bool = false

func get_rect() -> Rect2:
	return rect

func set_rect(r : Rect2) -> void:
	rect = r
	emit_changed()

func get_content() -> Array:
	return Array()

func set_content(arr : Array) -> void:
	pass
	
func add_content(entry : WorldGenBaseResource) -> void:
	pass

func create_content(item_name : String = "") -> void:
	pass

func remove_content_entry(entry : WorldGenBaseResource) -> void:
	pass

func duplicate_content_entry(entry : WorldGenBaseResource) -> void:
	var de : WorldGenBaseResource = entry.duplicate(true)
	de.resource_name += " (Duplicate)"
	add_content(de)

func setup_terra_library(library : TerramanLibrary) -> void:
	_setup_terra_library(library)
	
	for c in get_content():
		if c:
			c.setup_terra_library()

func _setup_terra_library(library : TerramanLibrary) -> void:
	pass

func generate_terra_chunk(chunk: TerraChunk, spawn_mobs: bool) -> void:
	pass
	
func generate_map() -> Image:
	var img : Image = Image.new()
	
	img.create(get_rect().size.x, get_rect().size.y, false, Image.FORMAT_RGBA8)
	
	add_to_map(img)
	
	return img

func add_to_map(var img : Image) -> void:
	_add_to_map(img)
	
	for c in get_content():
		if c:
			c.add_to_map(img)

func _add_to_map(var img : Image) -> void:
	pass

func get_editor_rect_border_color() -> Color:
	return Color(1, 1, 1, 1)

func get_editor_rect_color() -> Color:
	return Color(1, 1, 1, 0.9)

func get_editor_rect_border_size() -> int:
	return 2

func get_editor_font_color() -> Color:
	return Color(0, 0, 0, 1)

func get_editor_class() -> String:
	return "WorldGenBaseResource"

func get_editor_additional_text() -> String:
	return "WorldGenBaseResource"

func setup_property_inspector(inspector) -> void:
	inspector.add_slot_line_edit("get_name", "set_name", "Name")
	inspector.add_slot_rect2("get_rect", "set_rect", "Rect", 1)
