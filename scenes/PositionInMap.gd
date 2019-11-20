extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var pos_types = ["hometown", "village1", "village2", "ms1", "ms2", "ms3", "ms4"]

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.animation = pos_types[randi() % pos_types.size()]
	#pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
