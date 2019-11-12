extends Object
class_name Archive

var file_path: String = ""
var world_seed: int = 0
var last_time: Dictionary = {}

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
		self.world_seed = int(data.get("seed"))
		self.last_time = data.get("last_time")
	pass

func save_to_file(path: String) -> void:
	self.file_path = path
	var file := File.new()
	file.open(path, file.WRITE)
	var data = {
		"seed": self.world_seed,
		"last_time": OS.get_datetime()
		}
	file.store_string(JSON.print(data))
	file.close()
	pass

func get_description() -> String:
	return """存档详情:
{
	seed: %d,
	last_time: %04d-%02d-%02d %d:%02d:%02d
}
""" % [self.world_seed,
	int(self.last_time.get("year")),
	int(self.last_time.get("month")),
	int(self.last_time.get("day")),
	int(self.last_time.get("hour")),
	int(self.last_time.get("minute")),
	int(self.last_time.get("second"))]
