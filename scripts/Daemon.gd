extends Node

var archive_path: String = "user://archive"
var archive: Archive = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Directory.new().dir_exists(archive_path):
		Directory.new().make_dir(archive_path)
		pass
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func enum_archive() -> Array:
	var result := []
	var dir := Directory.new()
	if dir.open(archive_path) == OK:
		dir.list_dir_begin()
		var file_name := dir.get_next()
		while file_name != "":
			if file_name.get_extension() == "arch" and not dir.current_is_dir():
				result.push_back(file_name.get_file())
			file_name = dir.get_next()
	return result

func new_archive() -> void:
	if archive != null:
		archive.save_to_file(archive.file_path)
	archive = Archive.new()
	archive.init(randi())
	pass

func load_archive(name: String) -> bool:
	if not File.new().file_exists(archive_path + '/' + name):
		return false
	if archive != null:
		archive.save_to_file(archive.file_path)
	archive = Archive.new()
	archive.load_from_file(archive_path  + '/' + name)
	return true

func save_archive() -> void:
	if archive == null:
		return
	archive.save_to_file(archive.file_path)
	pass

func save_as_archvie(name: String) -> void:
	if archive == null:
		return
	archive.save_to_file(archive_path  + '/' + name)
	pass
