extends Node2D

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var base_center := Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var root := get_tree().get_root() as Viewport
	root.connect("size_changed", self, "_resize")
	_resize()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _resize() -> void:
	var root := get_tree().get_root() as Viewport
	# print(root.size)
	var new_center := root.size / 2
	find_node("ActionRoot").position += new_center - base_center
	base_center = new_center
	pass
