extends Object
class_name Archive

var file_path: String = ""
var world_seed: int = 0

func init(world_seed: int) -> void:
	self.world_seed = world_seed
	pass

func load_from_file(path: String) -> void:
	self.file_path = path
	var file := File.new()
	file.open(path, file.READ)
	var parsed_data := JSON.parse(file.get_as_text())
	if parsed_data.error != OK:
		print(parsed_data.get_error_string())
	else:
		var data = parsed_data.get_result()
		self.world_seed = int(data.get('seed'))
	pass

func save_to_file(path: String) -> void:
	self.file_path = path
	var file := File.new()
	file.open(path, file.WRITE)
	var data = {
		'seed': self.world_seed
		}
	file.store_string(JSON.print(data))
	file.close()
	pass
