tool
extends Control

const DataManagerAddonSettings = preload("res://addons/data_manager/resources/data_manager_addon_settings.gd")

signal inspect_data

export(PackedScene) var resource_scene : PackedScene
export(PackedScene) var folder_entry_button_scene : PackedScene
export(String) var base_folder : String = "res://"
export(NodePath) var main_container : NodePath
export(NodePath) var module_entry_container_path : NodePath
export(NodePath) var folder_entry_container_path : NodePath

var _main_container : Node
var _resource_scene : Node
var _module_entry_container : Node
var _folder_entry_container : Node

var _modules : Array = Array()
var _active_modules : Array = Array()
var _settings : DataManagerAddonSettings = null

var _initialized : bool = false
var _plugin : EditorPlugin = null

func _enter_tree():
	if !is_connected("visibility_changed", self, "on_visibility_changed"):
		connect("visibility_changed", self, "on_visibility_changed")

func on_visibility_changed():
	if _plugin && is_visible_in_tree() && !_initialized:
		_initialized = true
		load_data()

func load_data():
	var dir : Directory = Directory.new()
	
	_settings = _plugin.settings
	
	_main_container = get_node(main_container)
	
	_resource_scene = resource_scene.instance()
	_main_container.add_child(_resource_scene)
	_resource_scene.owner = _main_container
	_resource_scene.connect("inspect_data", self, "inspect_data")
	
	_module_entry_container = get_node(module_entry_container_path)
	_folder_entry_container = get_node(folder_entry_container_path)
	
	generate_module_entry_list()

func generate_module_entry_list() -> void:
	for ch in _folder_entry_container.get_children():
		ch.queue_free()
	
	load_modules()
	
	for m in _modules:
		var label_str : String = get_module_label_text(m)
			
		var b : Button = Button.new()
		b.toggle_mode = true
		b.text = label_str
		b.set_h_size_flags(SIZE_EXPAND_FILL)
		b.connect("toggled", self, "on_module_entry_button_toggled", [ m ])
		_module_entry_container.add_child(b)

func generate_folder_entry_list() -> void:
	for ch in _folder_entry_container.get_children():
		ch.queue_free()
		
	var dir : Directory = Directory.new()
	
	for module in _active_modules:
		var label_str : String = "= " + get_module_label_text(module) + " ="
		var mlabel : Label = Label.new()
		mlabel.text = label_str
		mlabel.align = HALIGN_CENTER
		mlabel.valign = VALIGN_CENTER
		_folder_entry_container.add_child(mlabel)
		var module_dir_base : String = module.resource_path.get_base_dir()
		
		var index = 0
		for f in _settings.folders:
			if !dir.dir_exists(module_dir_base + "/" + f.folder):
				continue
			
			if f.header != "":
				var h : Label = Label.new()
				
				_folder_entry_container.add_child(h)
				h.text = f.header
			
			var fe : Node = folder_entry_button_scene.instance()
			
			_folder_entry_container.add_child(fe)
			
			fe.text = f.name
			fe.tab = index
			
			fe.set_main_panel(self)
			
			index += 1
	
	set_tab(0)

func on_module_entry_button_toggled(on : bool, module) -> void:
	if on:
		for m in _active_modules:
			if m == module:
				return
		
		_active_modules.push_back(module)
		generate_folder_entry_list()
	else:
		for i in range(_active_modules.size()):
			if _active_modules[i] == module:
				_active_modules.remove(i)
				generate_folder_entry_list()
				return

func load_modules() -> void:
	_modules.clear()
	load_modules_at("res://")
	_modules.sort_custom(ModulePathSorter, "sort_ascending")
	
func load_modules_at(path : String) -> void:
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name == "." or file_name == "..":
				file_name = dir.get_next()
				continue

			if dir.current_is_dir():
				if path == "res://":
					load_modules_at(path + file_name)
				else:
					load_modules_at(path + "/" + file_name)
			else:
				if file_name == "game_module.tres":
					var res : Resource = null
					
					if path == "res://":
						res = ResourceLoader.load(path + file_name)
					else:
						res = ResourceLoader.load(path + "/" + file_name)
						
					if res.enabled:
						_modules.append(res)
					
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path: " + path)

class ModulePathSorter:
	static func sort_ascending(a, b):
		if a.resource_path < b.resource_path:
			return true
		return false


func set_tab(tab_index : int) -> void:
	hide_all()
	
	_resource_scene.show()
	_resource_scene.set_resource_type(_settings.folder_get_folder(tab_index), _settings.folder_get_type(tab_index))
	
func hide_all() -> void:
	_resource_scene.hide()

func inspect_data(var data : Resource) -> void:
	emit_signal("inspect_data", data)

func set_plugin(plugin : EditorPlugin) -> void:
	_plugin = plugin

func get_module_label_text(module) -> String:
	var label_str : String = module.resource_name
		
	if label_str == "":
		label_str = module.resource_path
		label_str = label_str.replace("res://", "")
		label_str = label_str.replace("/game_module.tres", "")
		label_str = label_str.replace("game_module.tres", "")
		
	return label_str
