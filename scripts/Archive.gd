extends Object
class_name Archive

class State:
	var HP: int = 100 # 生命
	var vigour: int = 20 # 体力
	var money: int = 0 # 财产
	var level: int = 0 # 等级

var file_path: String = ""
var world_seed: int = 0
var last_time: Dictionary = {}
var state: State

func init(world_seed: int) -> void:
	self.world_seed = world_seed
	self.state = State.new()
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
		var dict_state = data.get("state")
		self.state = State.new()
		self.state.HP = int(dict_state.get("HP"))
		self.state.vigour = int(dict_state.get("vigour"))
		self.state.money = int(dict_state.get("money"))
		self.state.level = int(dict_state.get("level"))
	pass

func save_to_file(path: String) -> void:
	self.file_path = path
	var file := File.new()
	file.open(path, file.WRITE)
	var data = {
		"seed": self.world_seed,
		"last_time": OS.get_datetime(),
		"state": {
			"HP": self.state.HP,
			"vigour": self.state.vigour,
			"money": self.state.money,
			"level": self.state.level
		}
	}
	file.store_string(JSON.print(data))
	file.close()
	pass

func get_description() -> String:
	return """存档详情:
{
	seed: %d,
	last_time: %04d-%02d-%02d %d:%02d:%02d,
	state: {
		HP: %d,
		vigour: %d,
		money: %d,
		level: %d
	}
}
""" % [self.world_seed,
	int(self.last_time.get("year")),
	int(self.last_time.get("month")),
	int(self.last_time.get("day")),
	int(self.last_time.get("hour")),
	int(self.last_time.get("minute")),
	int(self.last_time.get("second")),
	self.state.HP,self.state.vigour,self.state.money,self.state.level]
