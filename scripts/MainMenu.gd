extends Control

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# (get_tree().current_scene.find_node('MainMenu') as Control).visible = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _on_NewGameBtn_pressed() -> void:
	var daemon = get_tree().root.get_child(0)
	# this code only for debug
	get_tree().current_scene.find_node('MainMenu').visible = false
	get_tree().current_scene.find_node('AdventrueRoad').visible = true
	# if not daemon.load_archive('test.arch'):
	# 	print('no such file')
	# daemon.new_archive()
	daemon.load_archive('test.arch')
	# daemon.save_as_archvie('test.arch')
	print(daemon.enum_archive())

func _on_QuitBtn_pressed() -> void:
	get_tree().quit()