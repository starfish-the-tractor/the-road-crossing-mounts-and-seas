extends Node2D
export (PackedScene) var Pos

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = $Player
onready var camera = $Camera2D
var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	var velocity = Vector2(0, 0)
	velocity.x -= 3 * 150
	player.position = velocity
	camera.position = player.position
	for i in range(7):
		var pos_offset:int = i * 150 + 50
		var pos = Pos.instance()
		add_child(pos)
		if i==0 || i==6:
			pos.set_animation()
		$PosPath/PosSpawnLocation.set_offset(pos_offset)
		pos.position = $PosPath/PosSpawnLocation.position
	 # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2(0, 0) # 速度变量

	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	
	# 速度不为0，移动玩家位置
	if velocity.length() > 0:
		# 注意这里 normalize 速度矢量，否则会出现斜着走速度比单方向速度快
		player.position += velocity.normalized() * speed * delta
		# 更新摄像机，玩家始终在视窗内活动
		updateCameraPosition()

func updateCameraPosition():
    camera.position = player.position


func _on_DiceViewport_PlayDiceFinish(ted):
	#var velocity = Vector2(0, 0)
	#velocity.x += 100
	#player.position += velocity
	pass # Replace with function body.
