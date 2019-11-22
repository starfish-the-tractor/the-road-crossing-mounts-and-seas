extends TileMap

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	map_generator()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func map_generator() -> void:
	var noise := OpenSimplexNoise.new()
	noise.seed = OS.get_unix_time()
	print(noise.seed)
	noise.octaves = 4
	noise.period = 16
	noise.persistence = 0.5
	for x in range(-5, 6):
		for y in range(-5, 6):
			var val := int((noise.get_noise_2d(x, y) + 1.0) * 16.0) % 4
			self.set_cell(x, y, val)
	self.set_cell(0, 0, 1)
	pass
