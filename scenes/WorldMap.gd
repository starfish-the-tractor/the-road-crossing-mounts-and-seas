extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = $Player
onready var camera = $Camera2D
var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	camera.position = player.position
	 # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2(0, 0) # 速度变量

	if Input.is_action_pressed('go'):
		velocity.x += 1
	
	# 速度不为0，移动玩家位置
	if velocity.length() > 0:
		# 注意这里 normalize 速度矢量，否则会出现斜着走速度比单方向速度快
		player.position += velocity.normalized() * speed * delta
		# 更新摄像机，玩家始终在视窗内活动
		updateCameraPosition()

func updateCameraPosition():
    camera.position = player.position
