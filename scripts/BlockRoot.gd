extends Node2D

var player_position := Vector2(0, 0)
var BLOCK_SIZE := 64
var RADIUS := 5
var moveable := true
var timer := Timer.new()
var camera: Camera2D = null
var step := 20
var map: TileMap = null

func _ready() -> void:
	timer.autostart = false
	timer.one_shot = true
	timer.connect("timeout", self, "into_block")
	add_child(timer)
	camera = find_node("Camera2D") as Camera2D
	map = find_node("TileMap") as TileMap

func _process(delta: float) -> void:
	var Debug := get_parent().find_node("Debug")
	if moveable and step > 0:
		var direct: Vector2 = Vector2(0, 0)
		if Input.is_action_pressed("ui_up"):
			direct = Vector2(0, -1)
		elif Input.is_action_pressed("ui_down"):
			direct = Vector2(0, 1)
		elif Input.is_action_pressed("ui_left"):
			direct = Vector2(-1, 0)
		elif Input.is_action_pressed("ui_right"):
			direct = Vector2(1, 0)
		if direct.x != 0 or direct.y != 0:
			move(direct)
			(Debug.find_node("Position") as Label).text = "postion: (%d,%d)" % [player_position.x, player_position.y]
			(Debug.find_node("Step") as Label).text = "step: %d" % [step]
	pass

func move(direct: Vector2) -> void:
	var new_position := player_position + direct
	if abs(new_position.x) > RADIUS or abs(new_position.y) > RADIUS: return
	if map.get_cellv(new_position) == 0: return
	player_position = new_position
	camera.position = player_position * BLOCK_SIZE
	moveable = false
	step -= 1
	timer.start(0.5)

func into_block() -> void:
	var type := map.get_cellv(player_position)
	print("into: %d" % [type])
	action_finish()
	pass

func action_finish() -> void:
	moveable = true
	if step == 0:
		print("step exhaustion")

# debug
func _on_TextureButton_pressed() -> void:
	step = 20
	var Debug := get_parent().find_node("Debug")
	(Debug.find_node("Step") as Label).text = "step: %d" % [step]
	pass # Replace with function body.
