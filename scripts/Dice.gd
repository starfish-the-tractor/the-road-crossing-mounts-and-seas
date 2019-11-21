extends Viewport

signal PlayDiceFinish # (pt: int)

var timer: Timer = Timer.new()
var pointTimer: Timer = Timer.new()
var pt: int = 0

var static_quat = [
	Quat(Vector3(0,1,0),0),
	Quat(Vector3(0,0,1),PI/2),
	Quat(Vector3(-1,0,0),PI/2),
	Quat(Vector3(0,0,-1),PI/2),
	Quat(Vector3(1,0,0),PI/2),
	Quat(Vector3(1,0,0),PI)
]

func _ready() -> void:
	timer.one_shot = true
	timer.autostart = false
	timer.connect("timeout", self, "timeout")
	add_child(timer)
	pointTimer.one_shot = true
	pointTimer.autostart = false
	pointTimer.connect("timeout", self, "changePoint")
	add_child(pointTimer)

func timeout() -> void:
	emit_signal("PlayDiceFinish", pt + 1)

func changePoint() -> void:
	(find_node("DiceBody") as Spatial).transform = Transform(Quat(Vector3(0,1,0),randf() * PI) * static_quat[pt])
	timer.start(1.5)

func play() -> void:
	pt = randi() % 6
	var state_machine := find_node("AnimationTree")["parameters/playback"] as AnimationNodeStateMachinePlayback
	state_machine.travel("PlayDice")
	pointTimer.start(1.5)
