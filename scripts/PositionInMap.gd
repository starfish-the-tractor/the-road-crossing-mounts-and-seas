extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var pos_types = ["cs", "hs", "kl", "ks", "gg", "wyg"]

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.animation = pos_types[randi() % pos_types.size()]
	#pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_animation():
	$AnimatedSprite.animation = "wj"